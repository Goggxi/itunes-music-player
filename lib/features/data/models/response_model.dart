import 'dart:convert';

class ResponseModel {
  final int resultCount;
  final dynamic results;

  ResponseModel({
    this.resultCount = 0,
    this.results,
  });

  factory ResponseModel.fromRawJson(String str) =>
      ResponseModel.fromJson(json.decode(str));

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        resultCount: json["resultCount"],
        results: json["results"],
      );
}
