import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:itunes_music_player/core/utils/api.dart';
import 'package:itunes_music_player/core/utils/failure.dart';
import 'package:itunes_music_player/features/data/models/media_model.dart';
import 'package:itunes_music_player/features/data/models/response_model.dart';
import 'package:itunes_music_player/features/data/repositories/itunes_repository_contract.dart';
import 'package:tuple/tuple.dart';

@LazySingleton(as: ItunesRepositoryContract)
class ItunesRepository implements ItunesRepositoryContract {
  final Api _api;

  ItunesRepository(this._api);

  @override
  Future<Tuple2<Failure?, List<MediaModel>>> getMediaList(String term) async {
    final res = await _api.apiRequest(
      url: itunesUrl,
      method: RequestMethod.GET,
      apiPath: 'search',
      queryParameter: {
        'term': term,
        'media': 'music',
        'entity': 'song',
        'limit': '25',
      },
    );

    if (res.statusCode == 200) {
      final data = ResponseModel.fromJson(jsonDecode(res.body));
      final mediaList = (data.results as List).map((e) {
        return MediaModel.fromJson(e);
      }).toList();
      return Tuple2(null, mediaList);
    } else {
      return Tuple2(
        ServerFailure('Server Error: ${res.body}', code: res.statusCode),
        [],
      );
    }
  }
}
