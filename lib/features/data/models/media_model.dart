import 'dart:convert';

class MediaModel {
  final int collectionId;
  final String kind;
  final String artistName;
  final String trackName;
  final String artistViewUrl;
  final String collectionViewUrl;
  final String trackViewUrl;
  final String previewUrl;
  final String artworkUrl100;
  final DateTime? releaseDate;
  final int trackCount;
  final int trackNumber;
  final int trackTimeMillis;
  final String country;
  final String primaryGenreName;

  MediaModel({
    this.collectionId = 0,
    this.kind = '',
    this.artistName = '',
    this.trackName = '',
    this.artistViewUrl = '',
    this.collectionViewUrl = '',
    this.trackViewUrl = '',
    this.previewUrl = '',
    this.artworkUrl100 = '',
    this.releaseDate,
    this.trackCount = 0,
    this.trackNumber = 0,
    this.trackTimeMillis = 0,
    this.country = '',
    this.primaryGenreName = '',
  });

  factory MediaModel.fromRawJson(String str) =>
      MediaModel.fromJson(json.decode(str));

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        collectionId: json["collectionId"] ?? 0,
        kind: json["kind"] ?? '',
        artistName: json["artistName"] ?? '',
        trackName: json["trackName"] ?? '',
        artistViewUrl: json["artistViewUrl"] ?? '',
        collectionViewUrl: json["collectionViewUrl"] ?? '',
        trackViewUrl: json["trackViewUrl"] ?? '',
        previewUrl: json["previewUrl"] ?? '',
        artworkUrl100: json["artworkUrl100"] ?? '',
        releaseDate: json["releaseDate"] != null
            ? DateTime.parse(json["releaseDate"])
            : null,
        trackCount: json["trackCount"] ?? 0,
        trackNumber: json["trackNumber"] ?? 0,
        trackTimeMillis: json["trackTimeMillis"] ?? 0,
        country: json["country"] ?? '',
        primaryGenreName: json["primaryGenreName"] ?? '',
      );
}
