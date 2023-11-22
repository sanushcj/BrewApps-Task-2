// import 'dart:developer';
import 'package:brewapps_task02/model/toprated_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TopRatedController extends GetxController {
  RxBool loading = true.obs;
  RxList<TopratedModel> topfoundResult = <TopratedModel>[].obs;
  List<TopratedModel> topRatedList = <TopratedModel>[];

  @override
  void onInit() async {
    await fetchToprated();
    topfoundResult.value = topRatedList;
    super.onInit();
  }

  static const String baseUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';

  fetchToprated() async {
    // print('hiiiii');
    loading.value = true;
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = await data['results'];
      topRatedList =
          results.map((dynamic item) => TopratedModel.fromJson(item)).toList();
      if (kDebugMode) {
        print(topRatedList.toString());
      }
      loading.value = false;
    } else {
      // print('nadkoola mone');/
      throw Exception('Failed to load now playing movies');
    }
    refresh();
  }

  void searchRunTop(String enteredKeywords) {
    // print(enteredKeywords);
    List<TopratedModel> result = <TopratedModel>[];
    if (enteredKeywords.isEmpty) {
      result = topRatedList;
    } else {
      result = topRatedList
          .where((movie) =>
              movie.title.toLowerCase().contains(enteredKeywords.toLowerCase()))
          .toList();
    }
    topfoundResult.value = result;
    refresh();
  }

  deletetheMovieNow(int index) {
    topfoundResult.removeAt(index);
  }
}
