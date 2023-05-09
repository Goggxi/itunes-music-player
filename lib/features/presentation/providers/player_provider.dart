import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:itunes_music_player/features/data/models/media_model.dart';
import 'package:just_audio/just_audio.dart';

class PalyerProvider with ChangeNotifier {
  MediaModel _media = MediaModel();
  MediaModel get media => _media;
  set media(MediaModel value) {
    _media = value;
    notifyListeners();
  }

  bool _isSetPlayer = false;
  bool get isSetPlayer => _isSetPlayer;
  set isSetPlayer(bool value) {
    _isSetPlayer = value;
    notifyListeners();
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  Duration _duration = Duration.zero;
  Duration get duration => _duration;
  set duration(Duration value) {
    _duration = value;
    notifyListeners();
  }

  Duration _position = Duration.zero;
  Duration get position => _position;
  set position(Duration value) {
    _position = value;
    notifyListeners();
  }

  final player = AudioPlayer();

  Future<void> setPlayer({
    required Function(String message) onError,
  }) async {
    try {
      isSetPlayer = true;
      await Future.wait([
        player.setUrl(media.previewUrl),
        player.play(),
      ]);
      isPlaying = true;
      player.durationStream.listen((event) {
        duration = event ?? Duration.zero;
      });
      player.positionStream.listen((event) {
        position = event;
        if (position >= duration) {
          isPlaying = false;
        }
      });
    } catch (e) {
      log(e.toString());
      isSetPlayer = false;
      onError(e.toString());
    } finally {
      isSetPlayer = false;
    }
  }

  Future<void> togglePlayback() async {
    isPlaying = !isPlaying;
    if (isPlaying) {
      // if end duration then reset position
      if (position >= duration) {
        await player.seek(Duration.zero);
      }
      await player.play();
    } else {
      await player.pause();
    }
  }

  String positionToString() {
    final minutes = position.inMinutes.toString().padLeft(2, '0');
    final seconds = (position.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String durationToString() {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void seek(int seconds) {
    player.seek(Duration(seconds: seconds));
  }

  void fordward() {
    if (position + const Duration(seconds: 10) >= duration) {
      player.seek(duration);
      player.stop();
      isPlaying = false;
      return;
    }

    player.seek(position + const Duration(seconds: 10));
  }

  void rewind() {
    if (position - const Duration(seconds: 10) <= Duration.zero) {
      player.seek(Duration.zero);
      return;
    }

    player.seek(position - const Duration(seconds: 10));
  }

  void reset() {
    isPlaying = false;
    duration = Duration.zero;
    position = Duration.zero;
    player.stop();
    media = MediaModel();
  }
}
