import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_japan_v3/ui/auth.dart';
import 'package:flutter_japan_v3/ui/loginpage.dart';
import 'package:flutter_japan_v3/ui/main_page.dart';
import 'package:flutter_japan_v3/ui/profile.dart';
import 'package:flutter_japan_v3/ui/settings.dart';

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'MyApp',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.dark(),
      ),
      navigatorKey: GlobalKey<NavigatorState>(),
      initialRoute: AuthPage.routeName,
      routes: {
        AuthPage.routeName: (context) => AuthPage(),
        LoginPage.routeName: (context) => LoginPage(),
        MainPage.routeName: (context) => const MainPage(),
        Profile.routeName: (context) => Profile(),
        Settings.routeName: (context) => const Settings(),
      },
    );
  }
}
