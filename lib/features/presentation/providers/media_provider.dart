import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:itunes_music_player/core/utils/failure.dart';
import 'package:itunes_music_player/features/data/models/media_model.dart';
import 'package:itunes_music_player/features/data/repositories/repositories.dart';

@injectable
class MediaProvider with ChangeNotifier {
  final ItunesRepositoryContract _itunesRepository;

  MediaProvider(this._itunesRepository);

  bool _isSearching = false;
  bool get isSearching => _isSearching;
  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  final List<MediaModel> _mediaList = [];
  List<MediaModel> get mediaList => _mediaList;
  set mediaList(List<MediaModel> value) {
    _mediaList.clear();
    _mediaList.addAll(value);
    notifyListeners();
  }

  Future<void> getMediaList({
    required String term,
    required Function(Failure failure) onError,
  }) async {
    isSearching = true;
    final result = await _itunesRepository.getMediaList(term);

    if (result.item1 != null) {
      isSearching = false;

      if (result.item1!.code == 404) {
        onError(ServerFailure('$term not result found!', code: 404));
        return;
      }

      onError(result.item1!);
      return;
    }

    isSearching = false;
    mediaList = result.item2;
  }
}
