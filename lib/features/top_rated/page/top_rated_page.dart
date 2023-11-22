import 'package:brewapps_task02/features/top_rated/services/toprated_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            GetBuilder<TopRatedController>(
              builder: (mycontroller) => Expanded(
                child: mycontroller.loading.value == true
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            const NewsCardSkelton(),
                        separatorBuilder: (context, index) => rrHeight40,
                        itemCount: 5)
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Get.to(OpenPAGE(
                                  detailsNow: mycontroller.topRatedList[index],
                                ));
                              },
                              key:
                                  ValueKey(mycontroller.topRatedList[index].id),
                              child: FeedTile(
                                title: mycontroller.topRatedList[index].title,
                                img:
                                    mycontroller.topRatedList[index].posterPath,
                                subtitle:
                                    mycontroller.topRatedList[index].overview,
                              ),
                            ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: mycontroller.topRatedList.length),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
