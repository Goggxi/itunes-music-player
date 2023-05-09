import 'l10n.dart';

/// The translations for Indonesian (`id`).
class SId extends S {
  SId([String locale = 'id']) : super(locale);

  @override
  String notFound(Object value) {
    return '$value tidak ditemukan';
  }

  @override
  String get settings => 'Pengaturan';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get language => 'Bahasa';

  @override
  String get searchHint => 'Cari lagu, artis, atau album';

  @override
  String get artistSongsAlbumsNotFound => 'Tidak ada lagu atau album ditemukan';
}
