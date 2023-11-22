import 'package:brewapps_task02/common/skeltontile.dart';
import 'package:brewapps_task02/constants/constants.dart';
import 'package:brewapps_task02/features/home/services/home_controller.dart';
import 'package:brewapps_task02/model/nowplaying_model.dart';
import 'package:brewapps_task02/theme/mythemes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/feedtile.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

// final  ApiServiceNowPlaying apic = ApiServiceNowPlaying();

// final  List<NowPlayingModel> nowPlaying = [];

  final ApiServiceNowPlaying controllerNowPlaying =
      Get.put(ApiServiceNowPlaying());

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
            await controllerNowPlaying.fetchNowPlaying();
            if (kDebugMode) {
              print('doneeeee');
            }
          },
          child: Column(children: [
            rrHeight20,
            Obx(
              () => Expanded(
                child: controllerNowPlaying.loading.value == true
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            const NewsCardSkelton(),
                        separatorBuilder: (context, index) => rrHeight40,
                        itemCount: 5)
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => FeedTile(
                              title: controllerNowPlaying
                                  .nowPlayingList[index].title,
                              img: controllerNowPlaying
                                  .nowPlayingList[index].posterPath,
                              subtitle: controllerNowPlaying
                                  .nowPlayingList[index].overview,
                            ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: controllerNowPlaying.nowPlayingList.length),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
