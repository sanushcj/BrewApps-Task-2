import 'package:brewapps_task02/features/home/page/homepage.dart';
import 'package:brewapps_task02/features/home/services/home_controller.dart';
import 'package:brewapps_task02/features/top_rated/services/toprated_controller.dart';
import 'package:brewapps_task02/features/top_rated/page/top_rated_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/mythemes.dart';

class ScreenNavigation extends StatelessWidget {
  ScreenNavigation({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedPageIndex = ValueNotifier(0);
  final _pages = [MyHomePage(), TopRatedpage()];
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    ApiServiceNowPlaying controllerNow = Get.put(ApiServiceNowPlaying());
    TopRatedController controllerTop = Get.put(TopRatedController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.yellow,
        title: CupertinoSearchTextField(
          backgroundColor: Pallete.whiteColor,
          prefixIcon: const Icon(CupertinoIcons.search),
          autocorrect: false,
          controller: searchController,
          suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill),
          onSuffixTap: () {
            searchController.clear();
            controllerNow.searchRunNow(searchController.text);
          },
          onChanged: (value) => selectedPageIndex == 0
              ? controllerNow.searchRunNow(value)
              : controllerTop.searchRunTop(value),
          // onSubmitted: (value) => controller.searchRunNow(value),
        ),
      ),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: ScreenNavigation.selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
              unselectedIconTheme: const IconThemeData(
                color: Pallete.black,
              ),
              selectedIconTheme: const IconThemeData(
                color: Pallete.yellow,
              ),
              selectedLabelStyle: const TextStyle(
                  color: Pallete.yellow, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(
                  color: Pallete.black, fontWeight: FontWeight.bold),
              selectedItemColor: Pallete.yellow,
              backgroundColor: Pallete.whiteColor,
              selectedFontSize: 9,
              unselectedFontSize: 9,
              currentIndex: updatedIndex,
              onTap: ((newIndex) {
                ScreenNavigation.selectedPageIndex.value = newIndex;
              }),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.film_fill), label: 'Now Playing'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.star_fill), label: 'Top Rated'),
              ]);
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return _pages[updatedIndex];
        },
      ),
    );
  }
}
