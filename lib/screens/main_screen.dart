import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventaverse_trainer/api/users.dart';
import 'package:inventaverse_trainer/components/artifacts_list.dart';
import 'package:inventaverse_trainer/components/metadata_list.dart';
import 'package:inventaverse_trainer/models/treasure.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:inventaverse_trainer/models/user_data.dart';
import 'package:inventaverse_trainer/models/user_profile.dart';

import '../constants.dart';
import '../models/stats.dart';
import '../models/user_possessions.dart';
import '../responsive_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserData _userData = UserData(
      cookie: "",
      localId: "",
      userId: "",
      unlockAllCharacters: true,
      unlockAllArtifacts: true,
      unlockAllMagicBooks: true,
      userProfile: UserProfile(
          displayName: "",
          groupName: "",
          home: "",
          mapId: "",
          possessions: UserPossessions(
              artifacts: [],
              fighters: [],
              magics: [],
              mentor: 1,
              owned: [],
              skills: [],
              progress: 0,
              incantations: [],
              treasure: Treasure(gold: 50000, commendations: 0, inceptium: 0),
              fleet: [],
              history: [],
              mazes: [],
              puzzles: [],
              campaign: [],
              loadouts: [],
              sets: [],
              stats: Stats(c: 0, d: 0, e: 0, k: 0, r: 0, t: 0, w: 0)),
          profilePicture: -1));

  @override
  void initState() {
    super.initState();

    setState(() {
      try {
        final data = js.context.callMethod('loadData');
        _userData = UserData.fromJson(json.decode(data));
        _userData.userId = "";
      } catch (e) {
        // ignore: avoid_print
        print("invalid data $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final setupDialog = AlertDialog(
      elevation: 2,
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            const Text(
              "What is your Inventaverse User ID?",
              style: TextStyle(fontSize: 20),
            ),
            const ListTile(
              isThreeLine: true,
              title: Text("User ID (Local ID)"),
              subtitle: Text(
                  "To get this, go to Developer tools -> Network tab, then Go to your homeworld, go back to Developer Tools and Filter by 'isHome' -> Copy the id from the URL of the api/User/XXXXXXXXXXXX?isHome=true endpoint. This is also known as localId by the game code."),
            ),
            const SizedBox(height: 30),
            Image.asset(
              "assets/hint.png",
              height: 600,
            ),
            ListTile(
              title: TextFormField(
                  decoration: const InputDecoration(hintText: "Paste it here"),
                  initialValue: _userData.localId,
                  onChanged: (text) {
                    _userData.localId = text;
                    js.context.callMethod('saveData', [jsonEncode(_userData)]);
                  }),
            ),
            const ListTile(
              isThreeLine: true,
              title: Text("Cookie"),
              subtitle: Text(
                  "From the request above copy the cookie value from Request Headers (Headers tab)"),
            ),
            ListTile(
              title: TextFormField(
                  decoration: const InputDecoration(hintText: "Paste it here"),
                  initialValue: _userData.cookie,
                  onChanged: (text) {
                    _userData.cookie = text;
                    js.context.callMethod('saveData', [jsonEncode(_userData)]);
                  }),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              try {
                final userProfile =
                    await UsersApi.getUser(_userData.localId, _userData.cookie);

                // ignore: use_build_context_synchronously
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            'Are you sure you want to load this profile?'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              ListTile(
                                title: const Text("Name"),
                                subtitle: Text(userProfile.displayName),
                              ),
                              ListTile(
                                title: const Text("Group"),
                                subtitle: Text(userProfile.groupName),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              setState(() {
                                _userData.userProfile = userProfile;
                                _userData.userId = userProfile.mapId;
                                js.context.callMethod(
                                    'saveData', [jsonEncode(_userData)]);
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              } catch (e) {
                print(e);
                js.context.callMethod('alert', [
                  "An error has occurred, make sure your cookie and userId are correct. Or maybe just try again."
                ]);
              }
            },
            child: const Text("Load data")),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Inventaverse Trainer'), actions: [
        if (_userData.userId != "")
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final status = await UsersApi.updateUser(_userData);
              if (status == 200) {
                js.context.callMethod('alert', ["Success"]);
              } else {
                js.context.callMethod('alert', [
                  "An error has occurred, make sure your cookie and userId are correct"
                ]);
              }
            },
          ),
        IconButton(
          icon: const Icon(Icons.fullscreen),
          onPressed: () {
            js.context.callMethod('toggleFullscreen');
          },
        ),
      ]),
      body: ResponsiveContainer(
          mobile: const Text("Make your screen bigger to use this app"),
          desktop: _userData.userId == ""
              ? setupDialog
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: MetadataList(
                            userData: _userData,
                            onChange: (userData) {
                              js.context.callMethod(
                                  'saveData', [jsonEncode(_userData)]);
                              setState(() {
                                _userData = userData;
                              });
                            })),
                    Expanded(
                        flex: 2,
                        child: Container(
                            color: secondaryBgColor,
                            padding: const EdgeInsets.all(defaultPadding),
                            child: ArtifactsList(
                                userData: _userData,
                                onChange: (userData) {
                                  js.context.callMethod(
                                      'saveData', [jsonEncode(_userData)]);
                                  setState(() {
                                    _userData = userData;
                                  });
                                })))
                  ],
                )),
    );
  }
}
