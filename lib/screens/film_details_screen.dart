import 'package:cached_network_image/cached_network_image.dart';
import 'package:elopage_films/blocs/film_details/film_details_bloc.dart';
import 'package:elopage_films/blocs/film_details/film_details_event.dart';
import 'package:elopage_films/blocs/film_details/film_details_state.dart';
import 'package:elopage_films/resources/app_constants.dart';
import 'package:flutter/material.dart';

class FilmDetailsScreen extends StatefulWidget {
  final int id;

  const FilmDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<FilmDetailsScreen> createState() => _FilmDetailsScreenState();
}

class _FilmDetailsScreenState extends State<FilmDetailsScreen> {
  final FilmDetailsBloc _filmDetailsBloc = FilmDetailsBloc();

  @override
  void initState() {
    super.initState();
    _filmDetailsBloc.setEvent(FilmDetailsLoadEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<FilmDetailsState>(
          stream: _filmDetailsBloc.filmsState,
          builder: (_, snap) {
            if (snap.data is FilmDetailsLoadState) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(AppConstants.imageUrl +
                              AppConstants.detailsImageSize +
                              snap.data!.film.posterPath),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(snap.data!.film.title),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(snap.data!.film.overView),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _filmDetailsBloc.dispose();
    super.dispose();
  }
}
