// import 'dart:developer';

import 'package:brewapps_task02/model/nowplaying_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceNowPlaying extends GetxController {
  @override
  void onInit() {
    fetchNowPlaying();
    super.onInit();
  }

  RxBool loading = true.obs;
  RxList<NowPlayingModel> nowPlayingList = <NowPlayingModel>[].obs;

  static const String baseUrl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';

  fetchNowPlaying() async {
    // print('hiiiii');
    loading.value = true;
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = await data['results'];
      nowPlayingList.value = results
          .map((dynamic item) => NowPlayingModel.fromJson(item))
          .toList();
      if (kDebugMode) {
        print(nowPlayingList.toString());
      }
      loading.value = false;
    } else {
      // print('nadkoola mone');/
      throw Exception('Failed to load now playing movies');
    }
  }
}
