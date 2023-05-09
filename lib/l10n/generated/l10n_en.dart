import 'l10n.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String notFound(Object value) {
    return '$value not found';
  }

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get searchHint => 'Search for artist, songs, or albums';

  @override
  String get artistSongsAlbumsNotFound => 'No artists, songs, or albums found';
}
