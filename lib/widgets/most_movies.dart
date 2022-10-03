import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_movies_bloc.dart';
import 'package:movieapp/style/theme.dart' as Style;

import '../model/movie.dart';
import '../model/movie_response.dart';

class MostMovies extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MostMoviesState createState() => _MostMoviesState();
}

class _MostMoviesState extends State<MostMovies> {
  @override
  void initState() {
    super.initState();
    // ignore: avoid_single_cascade_in_expression_statements
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
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          // ignore: prefer_const_constructors
          child: Text(
            "Most view Movies",
            style: const TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: moviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.error != null &&
                  // ignore: prefer_is_empty
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
          // ignore: prefer_const_constructors, unnecessary_new
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
  // ignore: prefer_is_empty
  if (movies.length == 0) {
    return Container(
      child: const Text("No Movies"),
    );
  } else {
    return Container(
      height: 270.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
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
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: Style.Colors.secondColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Icon(
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "https://image.tmdb.org/t/p/w200/" +
                                      movies[index].poster),
                              fit: BoxFit.cover),
                        ),
                      ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 100.0,
                  child: Text(
                    movies[index].title,
                    maxLines: 2,
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                ),
                const SizedBox(
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
