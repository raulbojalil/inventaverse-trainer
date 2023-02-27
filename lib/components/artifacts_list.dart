import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

import '../models/user_data.dart';

class ArtifactDescription {
  final int index;
  final String name;
  final String type;
  final String description;
  final String image;

  ArtifactDescription(
      {required this.index,
      required this.name,
      required this.type,
      required this.description,
      required this.image});
}

class ArtifactsList extends StatefulWidget {
  final UserData userData;
  final Function onChange;

  // ignore: use_key_in_widget_constructors
  const ArtifactsList({required this.userData, required this.onChange});

  @override
  // ignore: no_logic_in_create_state
  State<ArtifactsList> createState() =>
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
          index: int.parse(x["Index"]?.toString() ?? "0"),
          name: x["Name"]?.toString() ?? "",
          type: x["Type"]?.toString() ?? "",
          description: x["Description"]?.toString() ?? "",
          image: x["Image"]?.toString() ?? "",
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
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        isThreeLine: true,
                        leading: Checkbox(
                          value: userData.userProfile.possessions.artifacts
                              .contains(item.index),
                          onChanged: (checked) {
                            if (checked ?? false) {
                              if (userData.userProfile.possessions.artifacts
                                      .length >=
                                  3) {
                                userData.userProfile.possessions.artifacts
                                    .removeAt(0);
                              }
                              userData.userProfile.possessions.artifacts
                                  .add(item.index);
                            } else {
                              userData.userProfile.possessions.artifacts
                                  .remove(item.index);
                            }

                            onChange(userData);
                          },
                        ),
                        trailing: Image.network(
                          item.image,
                          scale: 0.2,
                        )),
                ],
              )))
    ]);
  }
}
