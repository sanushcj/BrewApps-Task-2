import 'package:brewapps_task02/common/skeltontile.dart';
import 'package:brewapps_task02/constants/constants.dart';
import 'package:brewapps_task02/features/home/services/home_controller.dart';
import 'package:brewapps_task02/features/open/page/open_page.dart';
import 'package:brewapps_task02/theme/mythemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../common/feedtile.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  static const routeName = '/home';

// final  ApiServiceNowPlaying apic = ApiServiceNowPlaying();

// final  List<NowPlayingModel> nowPlaying = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        // color: Pallete.greyColor,
        child: RefreshIndicator(
          color: Pallete.redColor,
          onRefresh: () async {
            await Get.find<ApiServiceNowPlaying>().fetchNowPlaying();
            if (kDebugMode) {
              print('doneeeee');
            }
          },
          child: Column(children: [
            rrHeight20,
            Obx(
              () => Expanded(
                child: Get.find<ApiServiceNowPlaying>().loading.value == true
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            const NewsCardSkelton(),
                        separatorBuilder: (context, index) => rrHeight40,
                        itemCount: 5)
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Slidable(
                            endActionPane:
                                ActionPane(motion: BehindMotion(), children: [
                              SlidableAction(
                                backgroundColor: Pallete.redColor,
                                icon: CupertinoIcons.delete,
                                onPressed: (context) =>
                                    Get.find<ApiServiceNowPlaying>()
                                        .deletetheMovieNow(index),
                              )
                            ]),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(OpenPAGE(
                                  detailsNow: Get.find<ApiServiceNowPlaying>()
                                      .foundMovieResult[index],
                                ));
                              },
                              // key: ValueKey(Get.find<ApiServiceNowPlaying>().foundMovieResult[index].id),
                              child: FeedTile(
                                title: Get.find<ApiServiceNowPlaying>()
                                    .foundMovieResult[index]
                                    .title,
                                img: Get.find<ApiServiceNowPlaying>()
                                    .foundMovieResult[index]
                                    .posterPath,
                                subtitle: Get.find<ApiServiceNowPlaying>()
                                    .foundMovieResult[index]
                                    .overview,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: Get.find<ApiServiceNowPlaying>()
                            .foundMovieResult
                            .length),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
