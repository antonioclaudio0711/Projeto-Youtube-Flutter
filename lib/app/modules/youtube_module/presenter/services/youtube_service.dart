import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

Future<void> callApi({
  required List<YouTubeVideo> listVideo,
  required YoutubeAPI ytbApi,
  String search = '',
  bool isLoaded = false,
}) async {
  try {
    listVideo = await ytbApi.search(search);

    !isLoaded;
  } catch (e) {
    debugPrint(e.toString());
  }
}
