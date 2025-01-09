import 'dart:io';

import 'package:dio/dio.dart';

var apiManager = Dio(
  BaseOptions(
    baseUrl: 'https://api.kinopoisk.dev',
    headers: {
      'X-API-KEY': 'KCSGV2J-HGTMRV3-JJGE791-XKKS3MW',
    },
  ),
);

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (_) {
    return false;
  }
}