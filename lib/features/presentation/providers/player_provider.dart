import 'package:flutter/material.dart';
import 'package:itunes_music_player/features/data/models/media_model.dart';

class PalyerProvider with ChangeNotifier {
  MediaModel _media = MediaModel();
  MediaModel get media => _media;
  set media(MediaModel value) {
    _media = value;
    notifyListeners();
  }
}
