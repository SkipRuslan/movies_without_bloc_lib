import 'package:cached_network_image/cached_network_image.dart';
import 'package:elopage_films/resources/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilmCard extends StatelessWidget {
  const FilmCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.releaseDate,
      required this.image,
      required this.overView,
      required this.posterPath,
      required this.onTap})
      : super(key: key);
  final int id;
  final String title;
  final String releaseDate;
  final String image;
  final String overView;
  final String posterPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(16.0),
                child: const SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(image),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.black12,
                      blurRadius: 5.0,
                      offset: Offset(2.0, 5.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppColors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(
                        overView,
                        maxLines: 3,
                        style: const TextStyle(
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _formatReleaseDateToDMY(releaseDate),
                        maxLines: 3,
                        style: const TextStyle(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 300.0,
            height: 0.5,
            color: AppColors.black12,
            margin: const EdgeInsets.all(16.0),
          )
        ],
      ),
    );
  }

  String _formatReleaseDateToDMY(String releaseDate) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateFormat outputFormat = DateFormat('dd-MM-yyyy');
    DateTime fromStrToDate = inputFormat.parse(releaseDate);
    String fromDateToString = outputFormat.format(fromStrToDate);
    List<String> formattedTime = fromDateToString.split(':');
    return formattedTime[0];
  }
}
