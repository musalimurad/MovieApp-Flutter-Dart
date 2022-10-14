import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/bloc/get_movies_byGenre_bloc.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/screens/movie_detail_screen.dart';
import 'package:movieapp/style/theme.dart' as Style;
import '../model/movie_response.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;
  GenreMovies({Key? key, required this.genreId}) : super(key: key);
  @override
  _GenreMoviesState createState() => _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;
  _GenreMoviesState(this.genreId);
  @override
  void initState() {
    super.initState();
    moviesByGenreBloc..getMoviesByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: moviesByGenreBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.error != null && snapshot.data!.error.length > 0) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildMoviesByGenreWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget("");
        } else {
          return _buildLoadingWidget();
        }
      },
    );
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

  Widget _buildMoviesByGenreWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      // ignore: avoid_unnecessary_containers
      return Container(
        child: const Text("No Movies"),
      );
    } else {
      return Container(
        height: 150.0,
        padding: const EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                // test
                right: 10.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movie: movies[index]),
                      ));
                },
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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
                            height: 160.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200/" +
                                          movies[index].poster
                                      // "https://m.media-amazon.com/images/I/71Y5pMAw8rL._AC_SL1200_.jpg"),
                                      ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                    // ignore: prefer_const_constructors

                    // ignore: sized_box_for_whitespace
                    Container(
                      width: 100.0,
                      // child: Text(
                      //   movies[index].title,
                      //   maxLines: 2,
                      //   // ignore: prefer_const_constructors
                      //   style: TextStyle(
                      //     height: 1.4,
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 11.0,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
