import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/database/agendadb.dart';
import 'package:proyecto/models/actor_model.dart';
import 'package:proyecto/models/popular_model.dart';
import 'package:proyecto/network/api_popular.dart';
import 'package:proyecto/provider/test_provider.dart';
import 'package:proyecto/services/local_storage.dart';
import 'package:proyecto/widgets/ItemActorMovie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  final PopularModel model;
  DetailMovieScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<DetailMovieScreen> createState() => __DetailMovieScreenState();
}

int fav = 0;

class __DetailMovieScreenState extends State<DetailMovieScreen> {
  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
  }

  final ApiPopular apiPopular = ApiPopular();
  Color iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Hero(
        tag: widget.model.id!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500/${widget.model.backdropPath}'),
                        fit: BoxFit.fitHeight,
                        opacity: 0.3)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.model.title.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () => {
                                setState(() {
                                  int? idd = widget.model.id;
                                  if (agendaDB!.GETPOPULAR(idd!) == true) {
                                    iconColor = Colors.white;
                                    agendaDB!
                                        .DELETEMOVIE('tblPopular', idd!)
                                        .then((value) {
                                      var msj = (value > 0)
                                          ? 'Eliminada de Favoritos!'
                                          : 'Ocurrió un error';
                                      var snackbar =
                                          SnackBar(content: Text(msj));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    });
                                  } else {
                                    iconColor = Colors.red;
                                    agendaDB!.DELETEMOVIE('tblPopular', idd!);
                                    agendaDB!.INSERT('tblPopular', {
                                      'backdrop_path':
                                          widget.model.backdropPath,
                                      'id': widget.model.id,
                                      'original_language':
                                          widget.model.originalLanguage,
                                      'original_title':
                                          widget.model.originalTitle,
                                      'overview': widget.model.overview,
                                      'popularity': widget.model.popularity,
                                      'poster_path': widget.model.posterPath,
                                      'release_date': widget.model.releaseDate,
                                      'title': widget.model.title,
                                      'vote_average': widget.model.voteAverage,
                                      'vote_count': widget.model.voteCount
                                    }).then((value) {
                                      var msj = (value > 0)
                                          ? 'Agregada a Favoritos!'
                                          : 'Ocurrió un error';
                                      var snackbar =
                                          SnackBar(content: Text(msj));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    });
                                  }
                                })
                              },
                          icon: Icon(
                            Icons.favorite,
                            color: iconColor,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 200,
                            width: 100,
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${widget.model.posterPath}'),
                          ),
                          Container(
                            child: RatingBar(
                              initialRating: widget.model.voteAverage! / 2,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 238, 0)),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Color.fromARGB(255, 255, 238, 0),
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    color: Color.fromARGB(255, 255, 238, 0),
                                  )),
                              ignoreGestures: true,
                              onRatingUpdate: (value) {},
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Sinopsis',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          widget.model.overview.toString(),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        future: apiPopular.getVideo(widget.model.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: snapshot.data.toString(),
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: true,
                                    captionLanguage: AutofillHints.countryName,
                                  )),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Actores',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<List<ActorModel>?>(
                        future: apiPopular.getAllActors(widget.model),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  ActorModel actor = snapshot.data![index];
                                  return CardActor(
                                    name: actor.name.toString(),
                                    photo: actor.profilePath != null
                                        ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                                        : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                                    character: actor.character!,
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
