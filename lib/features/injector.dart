import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:itunes_music_player/features/injector.config.dart';

final di = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => di.init();
