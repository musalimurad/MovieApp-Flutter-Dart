import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/bloc/get_movie_videos_bloc.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/model/video_response.dart';
import 'package:movieapp/style/theme.dart' as style;
import 'package:movieapp/widgets/similar_movies.dart';

import '../model/video.dart';
import 'Home_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final Movie movie;
  _MovieDetailScreenState(this.movie);
  @override
  void initState() {
    super.initState();
    movieVideosBloc..getMovieVideos(movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieVideosBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: style.Colors.mainColor,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: style.Colors.secondColor,
            centerTitle: true,
            pinned: true,
            automaticallyImplyLeading: mounted,
            toolbarHeight: 50,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  movie.title.length > 40
                      ? movie.title.substring(0, 37) + '...'
                      : movie.title,
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                background: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/original/" +
                                  movie.backPoster),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            style.Colors.mainColor.withOpacity(0.9),
                            style.Colors.mainColor.withOpacity(0.0),
                          ])),
                    )
                  ],
                )),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "IMDB " + movie.rating.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                // ignore: prefer_const_constructors
                child: Text(
                  "OVERVIEW",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      color: style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  movie.overview,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10.0,
              ),
              SimilarMovies(
                id: movie.id,
              )
            ])),
          ),
        ],
      ),
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

  Widget _buildVideoWidget(VideoResponse data) {
    List<Video> videos = data.videos;
    return const FloatingActionButton(
      backgroundColor: style.Colors.secondColor,
      child: Icon(Icons.play_arrow),
      onPressed: null,
    );
  }
}
