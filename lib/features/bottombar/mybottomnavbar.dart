import 'package:brewapps_task02/features/home/page/homepage.dart';
import 'package:brewapps_task02/features/top_rated/page/top_rated_page.dart';
import 'package:brewapps_task02/features/top_rated/services/toprated_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/mythemes.dart';
import '../home/services/home_controller.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  static const bottomRoute = '/bottomPage';

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _listofPages = <Widget>[MyHomePage(), TopRatedpage()];
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: _listofPages.elementAt(_selectedIndex),
      appBar: AppBar(
        backgroundColor: Pallete.orange,
        title: CupertinoSearchTextField(
            backgroundColor: Pallete.whiteColor,
            prefixIcon: const Icon(CupertinoIcons.search),
            autocorrect: false,
            controller: searchController,
            suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill),
            onSuffixTap: () {
              searchController.clear();
              _selectedIndex == 1
                  ? Get.find<TopRatedController>()
                      .searchRunTop(searchController.text)
                  : Get.find<ApiServiceNowPlaying>()
                      .searchRunNow(searchController.text);
            },
            onChanged: (value) => _selectedIndex == 1
                ? Get.find<TopRatedController>().searchRunTop(value)
                : Get.find<ApiServiceNowPlaying>().searchRunNow(value)

            // : controllerTop.searchRunTop(value),

            // onSubmitted: (value) => controller.searchRunNow(value),

            ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          onTap: (value) {
            setState(() {
              searchController.clear();

              _selectedIndex == 1
                  ? Get.find<TopRatedController>()
                      .searchRunTop(searchController.text)
                  : Get.find<ApiServiceNowPlaying>()
                      .searchRunNow(searchController.text);
              _selectedIndex = value;
            });
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.film_fill), label: 'Now Playing'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.star_fill), label: 'Top Rated'),
          ]),
    );
  }
}
