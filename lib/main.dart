import 'package:flutter/material.dart';
import 'package:jing_hong_v4/route/router.dart';
import 'package:jing_hong_v4/ui/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
     routerConfig: router(),
     theme: AppTheme.lightTheme,
     darkTheme: AppTheme.dartTheme,
    );
  }
}
