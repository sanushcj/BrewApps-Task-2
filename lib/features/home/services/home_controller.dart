// import 'dart:developer';

import 'package:brewapps_task02/model/nowplaying_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceNowPlaying extends GetxController {
  RxList<NowPlayingModel> foundMovieResult = <NowPlayingModel>[].obs;
  List<NowPlayingModel> _nowPlayingList = <NowPlayingModel>[];
  RxBool loading = true.obs;

  @override
  void onInit() async {
    await fetchNowPlaying();
    foundMovieResult.value = _nowPlayingList;
    super.onInit();
  }

  void searchRunNow(String enteredKeywords) async {
    List<NowPlayingModel> result = <NowPlayingModel>[];
    if (enteredKeywords.isEmpty) {
      result = _nowPlayingList;
    } else {
      result = _nowPlayingList
          .where((movie) =>
              movie.title.toLowerCase().contains(enteredKeywords.toLowerCase()))
          .toList();
    }
    foundMovieResult.value = result;
    refresh();
  }

  static const String baseUrl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';

  fetchNowPlaying() async {
    // print('hiiiii');
    loading.value = true;
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = await data['results'];
      _nowPlayingList = results
          .map((dynamic item) => NowPlayingModel.fromJson(item))
          .toList();
      if (kDebugMode) {
        print(_nowPlayingList.toString());
      }
      loading.value = false;
    } else {
      // print('nadkoola mone');/
      throw Exception('Failed to load now playing movies');
    }
    refresh();
  }

  deletetheMovieNow(int index) {
    Get.find<ApiServiceNowPlaying>().foundMovieResult.removeAt(index);
  }
}
