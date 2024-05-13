import 'package:flutter/material.dart';
import 'package:bag_app/Themes/appbar_style.dart';
import 'package:bag_app/Themes/elevated_button_style.dart';
import 'package:bag_app/Utils/scroll_behavior.dart';
import 'package:bag_app/views/screens/home_screen_view.dart';



class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreenView(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        appBarTheme: AppbarStyle.getAppbarStyle(),
        elevatedButtonTheme: ElevatedButtonStyle.getElevatedButtonStyle(),
      ),
      scrollBehavior: AppScrollBehaviour(),
    );
  }
}