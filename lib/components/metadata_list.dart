import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventaverse_trainer/api/users.dart';
import 'package:inventaverse_trainer/models/user_data.dart';
import '../constants.dart';

import 'dart:js' as js;

class MetadataListItem extends StatelessWidget {
  final String title;
  final String description;
  final String value;
  final Function onChange;

  const MetadataListItem({
    Key? key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(title)),
          Expanded(
            child: TextFormField(
                initialValue: value,
                onChanged: (text) {
                  onChange(text);
                }),
          ),
        ],
      ),
      subtitle: Text(description),
    );
  }
}

class BooleanMetadataListItem extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final Function onChange;

  const BooleanMetadataListItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.value,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(child: Text(title)),
          Checkbox(
              value: value,
              onChanged: (checked) {
                onChange(checked);
              }),
        ],
      ),
      subtitle: Text(description),
    );
  }
}

class MetadataList extends StatefulWidget {
  final UserData userData;
  final Function onChange;

  const MetadataList({required this.userData, required this.onChange});

  @override
  State<MetadataList> createState() =>
      // ignore: no_logic_in_create_state
      _MetadataListState(userData: userData, onChange: onChange);
}

class _MetadataListState extends State<MetadataList> {
  final UserData userData;
  final Function onChange;

  _MetadataListState({required this.userData, required this.onChange});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
                  defaultPadding, defaultPadding * 2),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text("Player"),
                    isThreeLine: true,
                    subtitle: Text(
                        "${userData.userProfile.displayName}, Local ID: ${userData.localId}, ID: ${userData.userId}"),
                  ),
                  // const ListTile(
                  //   isThreeLine: true,
                  //   title: Text("User ID"),
                  //   subtitle: Text(
                  //       "Developer tools -> Network tab -> Go to your homeworld -> Filter by 'isHome' -> Copy the id from the URL of the api/User/XXXXXXXXXXXX?isHome=true endpoint"),
                  // ),
                  // ListTile(
                  //   title: TextFormField(
                  //       decoration: InputDecoration(hintText: "Paste it here"),
                  //       initialValue: userData.userId,
                  //       onChanged: (text) {
                  //         userData.userId = text;
                  //         onChange(userData);
                  //       }),
                  // ),
                  const ListTile(
                    isThreeLine: true,
                    title: Text("Cookie"),
                    subtitle: Text(
                        "Update the cookie if you can no longer update your data"),
                  ),
                  ListTile(
                    title: TextFormField(
                        decoration: InputDecoration(hintText: "Paste it here"),
                        initialValue: userData.cookie,
                        onChanged: (text) {
                          userData.cookie = text;
                          onChange(userData);
                        }),
                  ),
                  BooleanMetadataListItem(
                    title: "Unlock all characters",
                    description: "Even the secret ones",
                    value: userData.unlockAllCharacters,
                    onChange: (value) {
                      userData.unlockAllCharacters = value;
                      onChange(userData);
                    },
                  ),
                  BooleanMetadataListItem(
                    title: "Unlock all artifacts",
                    description: "Even the rare ones",
                    value: userData.unlockAllArtifacts,
                    onChange: (value) {
                      userData.unlockAllArtifacts = value;
                      onChange(userData);
                    },
                  ),
                  BooleanMetadataListItem(
                    title: "Unlock all magic books",
                    description:
                        "Magic books are used to cast incantations. Press T on your home world to view incantations.",
                    value: userData.unlockAllMagicBooks,
                    onChange: (value) {
                      userData.unlockAllMagicBooks = value;
                      onChange(userData);
                    },
                  ),
                  MetadataListItem(
                    title: "Gold",
                    description: "Set the amount of gold",
                    value: userData.userProfile.possessions.treasure.gold
                        .toString(),
                    onChange: (value) {
                      userData.userProfile.possessions.treasure.gold =
                          int.parse(value);
                      onChange(userData);
                    },
                  ),
                  MetadataListItem(
                    title: "Inceptium",
                    description: "Set the amount of inceptium",
                    value: userData.userProfile.possessions.treasure.inceptium
                        .toString(),
                    onChange: (value) {
                      userData.userProfile.possessions.treasure.inceptium =
                          int.parse(value);
                      onChange(userData);
                    },
                  ),
                  MetadataListItem(
                    title: "Commendations",
                    description: "Set the amount of commendations",
                    value: userData
                        .userProfile.possessions.treasure.commendations
                        .toString(),
                    onChange: (value) {
                      userData.userProfile.possessions.treasure.commendations =
                          int.parse(value);
                      onChange(userData);
                    },
                  ),
                  MetadataListItem(
                    title: "Rescued survivors",
                    description: "Set the amount of rescued survivors",
                    value: userData.userProfile.possessions.stats.r.toString(),
                    onChange: (value) {
                      userData.userProfile.possessions.stats.r =
                          int.parse(value);
                      onChange(userData);
                    },
                  ),
                  MetadataListItem(
                    title: "Enemies Killed",
                    description: "Set the amount of killed enemies",
                    value: userData.userProfile.possessions.stats.e.toString(),
                    onChange: (value) {
                      userData.userProfile.possessions.stats.e =
                          int.parse(value);
                      onChange(userData);
                    },
                  ),
                  MetadataListItem(
                    title: "Worlds completed",
                    description: "Set the amount of completed worlds",
                    value: userData.userProfile.possessions.stats.w.toString(),
                    onChange: (value) {
                      userData.userProfile.possessions.stats.w =
                          int.parse(value);
                      onChange(userData);
                    },
                  ),
                  MetadataListItem(
                    title: "Treasure chests looted",
                    description: "Set the amount of looted chests",
                    value: userData.userProfile.possessions.stats.t.toString(),
                    onChange: (value) {
                      userData.userProfile.possessions.stats.t =
                          int.parse(value);
                      onChange(userData);
                    },
                  ),
                  ListTile(
                    title: Text("Equipped artifacts"),
                    isThreeLine: true,
                    subtitle: Text(
                        "Use the 1,2 or 3 keys to use these during gameplay"),
                  ),
                  Row(
                    children: [
                      userData.userProfile.possessions.artifacts.length > 0
                          ? Image.network(
                              "https://inventaverse.com/js/game/images/objects/triggers/${userData.userProfile.possessions.artifacts[0]}.png",
                              scale: 0.2)
                          : Text(""),
                      SizedBox(width: 10),
                      userData.userProfile.possessions.artifacts.length > 1
                          ? Image.network(
                              "https://inventaverse.com/js/game/images/objects/triggers/${userData.userProfile.possessions.artifacts[1]}.png",
                              scale: 0.2)
                          : Text(""),
                      SizedBox(width: 10),
                      userData.userProfile.possessions.artifacts.length > 2
                          ? Image.network(
                              "https://inventaverse.com/js/game/images/objects/triggers/${userData.userProfile.possessions.artifacts[2]}.png",
                              scale: 0.2)
                          : Text(""),
                    ],
                  ),
                  const ListTile(
                    isThreeLine: true,
                    title: Text("R Incantation"),
                    subtitle: Text(
                        "Press R to activate this incantation during gameplay"),
                  ),
                  ListTile(
                    title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null, // <-- SEE HERE
                        initialValue: userData.userProfile.possessions
                                    .incantations.length >
                                0
                            ? userData.userProfile.possessions.incantations[0]
                            : "",
                        onChanged: (text) {
                          if (userData
                                  .userProfile.possessions.incantations.length >
                              0) {
                            userData.userProfile.possessions.incantations[0] =
                                text;
                          } else {
                            userData.userProfile.possessions.incantations
                                .add(text);
                          }
                          onChange(userData);
                        }),
                  ),

                  const ListTile(
                    isThreeLine: true,
                    title: Text("F Incantation"),
                    subtitle: Text(
                        "Press F to activate this incantation during gameplay"),
                  ),
                  ListTile(
                    title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null, // <-- SEE HERE
                        initialValue: userData.userProfile.possessions
                                    .incantations.length >
                                1
                            ? userData.userProfile.possessions.incantations[1]
                            : "",
                        onChanged: (text) {
                          if (userData
                                  .userProfile.possessions.incantations.length >
                              1) {
                            userData.userProfile.possessions.incantations[1] =
                                text;
                          } else {
                            userData.userProfile.possessions.incantations
                                .add(text);
                          }
                          onChange(userData);
                        }),
                  ),
                  const ListTile(
                    isThreeLine: true,
                    title: Text("V Incantation"),
                    subtitle: Text(
                        "Press V to activate this incantation during gameplay"),
                  ),
                  ListTile(
                    title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null, // <-- SEE HERE
                        initialValue: userData.userProfile.possessions
                                    .incantations.length >
                                2
                            ? userData.userProfile.possessions.incantations[2]
                            : "",
                        onChanged: (text) {
                          if (userData
                                  .userProfile.possessions.incantations.length >
                              2) {
                            userData.userProfile.possessions.incantations[2] =
                                text;
                          } else {
                            userData.userProfile.possessions.incantations
                                .add(text);
                          }
                          onChange(userData);
                        }),
                  ),
                ],
              )))
    ]);
  }
}
