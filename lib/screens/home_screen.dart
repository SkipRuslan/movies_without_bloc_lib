import 'package:elopage_films/blocs/home/home_event.dart';
import 'package:elopage_films/blocs/home/home_state.dart';
import 'package:elopage_films/blocs/home/home_bloc.dart';
import 'package:elopage_films/resources/app_colors.dart';
import 'package:elopage_films/resources/app_constants.dart';
import 'package:elopage_films/resources/app_routes.dart';
import 'package:elopage_films/resources/app_strings.dart';
import 'package:elopage_films/widgets/film_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _homeBloc.setEvent(FilmsLoadUpcomingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            _bottomBarItem(
              () {
                _homeBloc.setEvent(FilmsLoadUpcomingEvent());
              },
              Icons.upcoming,
              AppStrings.upcoming,
            ),
            _bottomBarItem(
              () {
                _homeBloc.setEvent(FilmsTopRatedEvent());
              },
              Icons.star_outlined,
              AppStrings.topRated,
            ),
          ],
        ),
        body: StreamBuilder<HomeState>(
          stream: _homeBloc.filmsState,
          builder: (_, snap) {
            if (snap.data is FilmsLoadState) {
              return ListView.builder(
                itemCount: snap.data!.filmsList.length,
                itemBuilder: (_, index) {
                  return FilmCard(
                    id: snap.data!.filmsList[index].id,
                    title: snap.data!.filmsList[index].title,
                    releaseDate: snap.data!.filmsList[index].releaseDate,
                    image: AppConstants.imageUrl + AppConstants.listImageSize + snap.data!.filmsList[index].posterPath,
                    overView: snap.data!.filmsList[index].overView,
                    posterPath: snap.data!.filmsList[index].posterPath,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.filmDetailsScreenRoute,
                        arguments: snap.data!.filmsList[index].id,
                      );
                    },
                  );
                },
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
    _homeBloc.dispose();
    super.dispose();
  }

  Widget _bottomBarItem(VoidCallback onTap, IconData icon, String label) {
    return Expanded(
      child: SizedBox(
        height: 68.0,
        child: TextButton(
          onPressed: onTap,
          child: Column(
            children: [
              Icon(
                icon,
                color: AppColors.black,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
