import 'package:flutter/material.dart';
import 'package:movieapp/model/genre.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/widgets/genre_movies.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  GenresList({Key? key, required this.genres}) : super(key: key);

  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  List<Genre> genres;
  var _tabController;
  _GenresListState(this.genres);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
  }

  @override
  void dispose() {
    super.initState();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: PreferredSize(
              // ignore: sort_child_properties_last
              child: AppBar(
                backgroundColor: Style.Colors.mainColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Style.Colors.secondColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2.0,
                  unselectedLabelColor: Style.Colors.titleColor,
                  labelColor: Style.Colors.secondColor,
                  isScrollable: true,
                  tabs: genres.map((Genre genre) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: Text(
                        genre.name!.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
              preferredSize: Size.fromHeight(50.0)),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((Genre genre) {
              return GenreMovies(genreId: genre.id!);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
