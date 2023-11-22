import 'package:brewapps_task02/theme/mythemes.dart';
import 'package:flutter/material.dart';

class FeedTile extends StatelessWidget {
  const FeedTile({
    super.key,
    required this.img,
    required this.title,
    required this.subtitle,
  });

  final String img;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height / 5,
      // color: Pallete.redColor,
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          // color: Pallete.lightbluee,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/w342/$img'))),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width / 2.9,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
