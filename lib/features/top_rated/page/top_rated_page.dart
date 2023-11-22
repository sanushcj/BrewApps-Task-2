import 'package:brewapps_task02/features/top_rated/services/toprated_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../common/feedtile.dart';
import '../../../common/skeltontile.dart';
import '../../../constants/constants.dart';
import '../../../theme/mythemes.dart';
import '../../open/page/open_page.dart';

class TopRatedpage extends StatelessWidget {
  TopRatedpage({super.key});

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
            await Get.find<TopRatedController>().fetchToprated();
            if (kDebugMode) {
              print('doneeeee');
            }
          },
          child: Column(children: [
            rrHeight20,
            Obx(
              () => Expanded(
                child: Get.find<TopRatedController>().loading.value == true
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            const NewsCardSkelton(),
                        separatorBuilder: (context, index) => rrHeight40,
                        itemCount: 5)
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Slidable(
                            endActionPane:
                                ActionPane(motion: BehindMotion(), children: [
                              SlidableAction(
                                backgroundColor: Pallete.redColor,
                                icon: CupertinoIcons.delete,
                                onPressed: (context) =>
                                    Get.find<TopRatedController>()
                                        .deletetheMovieNow(index),
                              )
                            ]),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(OpenPAGE(
                                  detailsNow: Get.find<TopRatedController>()
                                      .topfoundResult[index],
                                ));
                              },
                              key: ValueKey(Get.find<TopRatedController>()
                                  .topfoundResult[index]
                                  .id),
                              child: FeedTile(
                                title: Get.find<TopRatedController>()
                                    .topfoundResult[index]
                                    .title,
                                img: Get.find<TopRatedController>()
                                    .topfoundResult[index]
                                    .posterPath,
                                subtitle: Get.find<TopRatedController>()
                                    .topfoundResult[index]
                                    .overview,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: Get.find<TopRatedController>()
                            .topfoundResult
                            .length),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
