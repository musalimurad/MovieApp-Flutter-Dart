import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_movie_similar_bloc.dart';
import 'package:movieapp/bloc/get_movies_bloc.dart';
import 'package:movieapp/style/theme.dart' as Style;

import '../model/movie.dart';
import '../model/movie_response.dart';

class SimilarMovies extends StatefulWidget {
  final int id;
  // ignore: invalid_required_positional_param, use_key_in_widget_constructors
  SimilarMovies({Key? key, required this.id}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SimilarMoviesState createState() => _SimilarMoviesState(id);
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final int id;
  _SimilarMoviesState(this.id);
  @override
  void initState() {
    super.initState();
    similarMoviesBloc..getSimilarMovies(id);
  }

  @override
  void dispose() {
    super.dispose();
    similarMoviesBloc..drainStream();
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
            "Similar Movies".toUpperCase(),
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: similarMoviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.error != null &&
                  snapshot.data!.error.isNotEmpty) {
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
      Text(
        "Error occured: $error",
        style: TextStyle(color: Colors.white),
      ),
    ],
  ));
}

Widget _buildMoviesWidget(MovieResponse data) {
  List<Movie> movies = data.movies;
  if (movies.isEmpty) {
    return Container(
      child: const Text("No Movies"),
    );
  } else {
    return Container(
      height: 190.0,
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
                        height: 160.0,
                        decoration: const BoxDecoration(
                            color: Style.Colors.secondColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
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
                        height: 160.0,
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

                // Container(
                //   width: 100,
                //   child: Text(
                //     movies[index].title,
                //     maxLines: 2,
                //     style: TextStyle(
                //       height: 1.4,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 11.0
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
