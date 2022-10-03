import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_movies_bloc.dart';
import 'package:movieapp/style/theme.dart' as Style;

import '../model/movie.dart';
import '../model/movie_response.dart';

class TopMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {
  @override
  void initState() {
    super.initState();
    moviesBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // ignore: prefer_const_constructors
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          // ignore: prefer_const_constructors
          child: Text(
            "Top Rated Movies",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: moviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.error != null &&
                  snapshot.data!.error.length > 0) {
                return _buildErrorWidget(snapshot.data!.error);
              }
              return _buildMoviesWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget("");
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ],
    );
  }
}

Widget _buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 25.0,
        width: 25.0,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 4.0,
        ),
      )
    ],
  ));
}

Widget _buildErrorWidget(String error) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Error occured: $error"),
    ],
  ));
}

Widget _buildMoviesWidget(MovieResponse data) {
  List<Movie> movies = data.movies;
  if (movies.length == 0) {
    return Container(
      child: Text("No Movies"),
    );
  } else {
    return Container(
      height: 270.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 10.0,
            ),
            child: Column(
              children: [
                movies[index].poster == null
                    ? Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                            color: Style.Colors.secondColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle),
                        child: Column(
                          children: [
                            Icon(
                              EvaIcons.filmOutline,
                              color: Colors.white,
                              size: 50.0,
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w200/" +
                                      movies[index].poster),
                              fit: BoxFit.cover),
                        ),
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 100,
                  child: Text(
                    movies[index].title,
                    maxLines: 2,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
