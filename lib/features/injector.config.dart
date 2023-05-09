// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:itunes_music_player/core/utils/api.dart' as _i5;
import 'package:itunes_music_player/features/data/repositories/itunes_repository.dart'
    as _i8;
import 'package:itunes_music_player/features/data/repositories/itunes_repository_contract.dart'
    as _i7;
import 'package:itunes_music_player/features/data/repositories/repositories.dart'
    as _i10;
import 'package:itunes_music_player/features/modules.dart' as _i11;
import 'package:itunes_music_player/features/presentation/providers/config_provider.dart'
    as _i6;
import 'package:itunes_music_player/features/presentation/providers/media_provider.dart'
    as _i9;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.Client>(registerModule.httpClient);
    await gh.factoryAsync<_i4.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i5.Api>(() => _i5.Api(gh<_i3.Client>()));
    gh.factory<_i6.ConfigProvider>(
        () => _i6.ConfigProvider(gh<_i4.SharedPreferences>()));
    gh.lazySingleton<_i7.ItunesRepositoryContract>(
        () => _i8.ItunesRepository(gh<_i5.Api>()));
    gh.factory<_i9.MediaProvider>(
        () => _i9.MediaProvider(gh<_i10.ItunesRepositoryContract>()));
    return this;
  }
}

class _$RegisterModule extends _i11.RegisterModule {}
