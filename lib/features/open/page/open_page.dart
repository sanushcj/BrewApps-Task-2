import 'package:brewapps_task02/constants/constants.dart';
import 'package:brewapps_task02/model/nowplaying_model.dart';
import 'package:brewapps_task02/theme/mythemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenPAGE extends StatelessWidget {
  const OpenPAGE({super.key, required this.details});
  static const routeName = '/theopen';
  final NowPlayingModel details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/original/${details.backdropPath}'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          // physics: BouncingScrollPhysics(),
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.sizeOf(context).height / 2.5,
                width: double.infinity,
                color: Pallete.black.withOpacity(0.4),
                padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      details.originalTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Pallete.whiteColor),
                    ),
                    rrHeight20,
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      details.releaseDate,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Pallete.greyColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.deblur_rounded,
                                color: Pallete.whiteColor,
                              ),
                              Text(
                                details.voteCount.toString(),
                                style: const TextStyle(
                                  color: Pallete.whiteColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.clock_solid,
                                color: Pallete.whiteColor,
                                size: 16,
                              ),
                              rrwidth10,
                              Text(
                                '2hr 49 mins',
                                style: TextStyle(
                                  color: Pallete.whiteColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    rrHeight10,
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        details.overview,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Pallete.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
