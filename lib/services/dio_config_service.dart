import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioInstance;
createInstance() async {

  var options = BaseOptions(
      baseUrl: "https://imdb8.p.rapidapi.com/auto-complete",
      connectTimeout: 12000,
      receiveTimeout: 12000,
      headers: {
        "x-rapidapi-key": "5fcd15a8d0mshe24bf96323663f5p1bb983jsn5a523e58bb46",
        "x-rapidapi-host": "imdb8.p.rapidapi.com"
      });
  dioInstance = new Dio(options);
  dioInstance.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));

}

Future<Dio> dio() async {
  await createInstance();
  dioInstance.options.baseUrl = "https://imdb8.p.rapidapi.com/auto-complete";
  return dioInstance;
}

