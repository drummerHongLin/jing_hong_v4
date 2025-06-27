// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/data/chat/chat_repo.dart';
import 'package:jing_hong_v4/data/data/chat/local/chat_repo_local.dart';
import 'package:jing_hong_v4/ui/chat/chat_screen.dart' show ChatScreen;
import 'package:jing_hong_v4/ui/chat/view_models/chat_viewmodel.dart';


/// Flutter code sample for [AnimatedSlide].

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.network("http://images.honghouse.cn/logo.png",height: 50,),);
  }
}