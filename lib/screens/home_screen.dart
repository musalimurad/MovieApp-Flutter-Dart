import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/style/theme.dart' as style;
import 'package:movieapp/widgets/genres.dart';
import 'package:movieapp/widgets/most_movies.dart';
import 'package:movieapp/widgets/now_playing.dart';
import 'package:movieapp/widgets/top_movies.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: style.Colors.mainColor,
        centerTitle: true,
        // ignore: prefer_const_constructors
        leading: Icon(
          EvaIcons.settingsOutline,
          color: Colors.white,
          size: 35,
        ),
        title: Text("Metaflix"),
        actions: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: Image.asset(
              "assets/images/logo.jpg",
              width: 55,
              height: 41,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          TopMovies(),
          MostMovies()
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
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
                builder: (context) => const HomeScreen(),
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
      drawer: const NavigationDrawer(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: style.Colors.mainColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Material(
        color: style.Colors.titleColor,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              color: style.Colors.titleColor,
              padding: EdgeInsets.only(
                  top: 24 + MediaQuery.of(context).padding.top, bottom: 24.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(900)),
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Musali Murad",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2),
                  ),
                  const Text(
                    "musalimurat1@gmail.com",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2),
                  )
                ],
              )),
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Wrap(
          children: [
            Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top)),
            ListTile(
              leading: const Icon(
                EvaIcons.homeOutline,
                size: 40,
                color: style.Colors.secondColor,
              ),
              title: const Text("Home",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.3)),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(EvaIcons.heartOutline,
                  size: 40, color: style.Colors.secondColor),
              title: const Text("favorite",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.3)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.filmOutline,
                size: 40,
                color: style.Colors.secondColor,
              ),
              title: const Text("Movies",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.3)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.filmOutline,
                size: 40,
                color: style.Colors.secondColor,
              ),
              title: const Text(
                "Metaflix original",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3),
              ),
              onTap: () {},
            ),
          ],
        ),
      );
}
