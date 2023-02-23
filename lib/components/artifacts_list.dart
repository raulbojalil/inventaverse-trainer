import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

import 'dart:js' as js;

import '../models/user_data.dart';

class ArtifactDescription {
  final int Index;
  final String Name;
  final String Type;
  final String Description;
  final String Image;

  ArtifactDescription(
      {required this.Index,
      required this.Name,
      required this.Type,
      required this.Description,
      required this.Image});
}

class ArtifactsList extends StatefulWidget {
  final UserData userData;
  final Function onChange;

  const ArtifactsList({required this.userData, required this.onChange});

  @override
  State<ArtifactsList> createState() =>
      // ignore: no_logic_in_create_state
      _ArtifactsListState(userData: userData, onChange: onChange);
}

class _ArtifactsListState extends State<ArtifactsList> {
  final Function onChange;
  final UserData userData;
  List<ArtifactDescription> _artifacts = [];

  _ArtifactsListState({
    required this.onChange,
    required this.userData,
  });

  void loadArtifacts() async {
    final rawJson = await rootBundle.loadString(
      'assets/artifacts.json',
    );

    var list = json.decode(rawJson).map((x) => ArtifactDescription(
          Index: int.parse(x["Index"]?.toString() ?? "0"),
          Name: x["Name"]?.toString() ?? "",
          Type: x["Type"]?.toString() ?? "",
          Description: x["Description"]?.toString() ?? "",
          Image: x["Image"]?.toString() ?? "",
        ));

    final artifacts = List<ArtifactDescription>.from(list);

    setState(() {
      _artifacts = artifacts;
    });
  }

  @override
  void initState() {
    super.initState();
    loadArtifacts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  defaultPadding, 0, defaultPadding, defaultPadding),
              child: ListView(
                children: [
                  for (var item in _artifacts)
                    ListTile(
                        title: Text(item.Name),
                        subtitle: Text(item.Description),
                        isThreeLine: true,
                        leading: Checkbox(
                          value: userData.userProfile.possessions.artifacts
                              .contains(item.Index),
                          onChanged: (checked) {
                            if (checked ?? false) {
                              if (userData.userProfile.possessions.artifacts
                                      .length >=
                                  3) {
                                userData.userProfile.possessions.artifacts
                                    .removeAt(0);
                              }
                              userData.userProfile.possessions.artifacts
                                  .add(item.Index);
                            } else {
                              userData.userProfile.possessions.artifacts
                                  .remove(item.Index);
                            }

                            onChange(userData);
                          },
                        ),
                        trailing: Image.network(
                          item.Image,
                          scale: 0.2,
                        )),
                ],
              )))
    ]);
  }
}
