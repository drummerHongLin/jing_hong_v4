import 'package:flutter/material.dart' show Icons;
import 'package:jing_hong_v4/data/local/route/model.dart' show NavInfo;

final navInfo = <NavInfo>[
  NavInfo(name: "Home", path: "/home", iconUrl: Icons.account_circle_outlined),
  NavInfo(name: "Chat", path: "/chat", iconUrl: Icons.message_outlined),
  NavInfo(name: "About", path: "/about", iconUrl:Icons.catching_pokemon_outlined),
];

