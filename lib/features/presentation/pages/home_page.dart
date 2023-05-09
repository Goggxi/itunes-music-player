import 'package:flutter/material.dart';
import 'package:itunes_music_player/core/configs/configs.dart';
import 'package:itunes_music_player/core/utils/utils.dart';
import 'package:itunes_music_player/features/data/models/models.dart';
import 'package:itunes_music_player/features/presentation/providers/config_provider.dart';
import 'package:itunes_music_player/features/presentation/providers/media_provider.dart';
import 'package:itunes_music_player/features/presentation/providers/player_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          _HeaderSection(),
          _ListSection(),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  void _searchMedia(BuildContext context, {required String term}) {
    if (term.isEmpty) {
      return;
    }

    final mediaProvider = context.read<MediaProvider>();
    mediaProvider.getMediaList(
      term: term,
      onError: (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
    );
  }

  Future<void> _showConfig(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return _ConfigModalBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for artist, songs, or albums',
                  prefixIcon: const Icon(Icons.search_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) {
                  final execute = debounce(
                    () => _searchMedia(context, term: value),
                    milliseconds: 500,
                  );
                  execute();
                },
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => _showConfig(context),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.theme.disabledColor),
                ),
                child: const Icon(Icons.settings_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfigModalBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigProvider>(
      builder: (context, model, child) => SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppThemes.paddingDefault,
              child: Text(
                'Settings',
                style: context.textTheme.titleLarge,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Dark mode'),
              trailing: Switch(
                value: model.isDarkMode,
                onChanged: (value) {
                  model.toggleThemeMode();
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: DropdownButton<String>(
                value: 'en',
                onChanged: (String? value) {},
                items: <String>['en', 'id'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<MediaProvider>(builder: (_, mediaProvider, __) {
      return Expanded(
        child: Visibility(
          visible: !mediaProvider.isSearching,
          replacement: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            itemBuilder: (_, __) => const _MediaItemSkeleton(),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          ),
          child: mediaProvider.mediaList.isEmpty
              ? ListView(
                  children: [
                    Icon(
                      Icons.search_off_outlined,
                      size: 60,
                      color: context.theme.highlightColor,
                    ).paddingOnly(top: context.height * 0.2),
                    Text(
                      'Artist, songs, or albums not found',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.theme.highlightColor,
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: mediaProvider.mediaList.length,
                  itemBuilder: (_, index) {
                    final media = mediaProvider.mediaList[index];
                    return _MediaItem(
                      media: media,
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final playerProvider = context.read<PalyerProvider>();
                        context.pushNamed(Navigate.player);
                        if (playerProvider.media.trackId != media.trackId) {
                          playerProvider.reset();
                          playerProvider.media = media;
                          await playerProvider.setPlayer(
                            onError: (_) {},
                          );
                        }
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                ),
        ),
      );
    });
  }
}

class _MediaItem extends StatelessWidget {
  const _MediaItem({
    Key? key,
    required this.media,
    required this.onTap,
  }) : super(key: key);

  final MediaModel media;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Hero(
            tag: media.trackId,
            child: ImageApp(
              url: media.artworkUrl100,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  media.trackName,
                  maxLines: 2,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.grey[400]),
                    Flexible(
                      child: Text(
                        media.artistName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Consumer<PalyerProvider>(builder: (_, playerProvider, __) {
            if (media.trackId == playerProvider.media.trackId) {
              return Material(
                color: context.theme.colorScheme.onSurface,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: () {
                    playerProvider.togglePlayback();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      !playerProvider.isPlaying
                          ? Icons.play_arrow_outlined
                          : Icons.pause_outlined,
                      size: 30,
                      color: context.theme.colorScheme.surface,
                    ),
                  ),
                ),
              ).paddingOnly(left: 8);
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }
}

class _MediaItemSkeleton extends StatelessWidget {
  const _MediaItemSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: context.theme.highlightColor,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width * 0.6,
                height: 20,
                decoration: BoxDecoration(
                  color: context.theme.highlightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: context.width * 0.4,
                height: 15,
                decoration: BoxDecoration(
                  color: context.theme.highlightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
