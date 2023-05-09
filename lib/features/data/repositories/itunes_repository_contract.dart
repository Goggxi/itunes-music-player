import 'package:itunes_music_player/core/utils/failure.dart';
import 'package:itunes_music_player/features/data/models/models.dart';
import 'package:tuple/tuple.dart';

abstract class ItunesRepositoryContract {
  Future<Tuple2<Failure?, List<MediaModel>>> getMediaList(String term);
}
