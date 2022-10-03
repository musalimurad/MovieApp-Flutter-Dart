import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/main.dart';
import 'package:movieapp/style/theme.dart' as style;
import '../screens/home_screen.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CurvedNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          ListTile(
            title: const Icon(EvaIcons.searchOutline,
                color: Colors.white, size: 35.0),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
          ),
          ListTile(
            title: const Icon(EvaIcons.homeOutline,
                color: Colors.white, size: 35.0),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SplashScreen(),
              ));
            },
          ),
          ListTile(
            title: const Icon(
              EvaIcons.menu2Outline,
              color: Colors.white,
              size: 35.0,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const NavigationDrawer(),
              ));
            },
          ),
        ],
        backgroundColor: style.Colors.mainColor,
        buttonBackgroundColor: style.Colors.mainColor,
        color: style.Colors.secondColor,
        height: 55.0,
        animationDuration: Duration(milliseconds: 300),
        index: 1,
      ),
    );
  }
}