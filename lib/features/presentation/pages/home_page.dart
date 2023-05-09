import 'package:flutter/material.dart';
import 'package:itunes_music_player/core/configs/navigate.dart';
import 'package:itunes_music_player/core/utils/utils.dart';
import 'package:itunes_music_player/features/data/models/models.dart';
import 'package:itunes_music_player/features/presentation/providers/media_provider.dart';
import 'package:provider/provider.dart';

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
                  prefixIcon: const Icon(Icons.search),
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
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: const Icon(Icons.settings_rounded),
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
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: mediaProvider.mediaList.length,
            itemBuilder: (_, index) {
              final media = mediaProvider.mediaList[index];
              return _MediaItem(
                media: media,
                onTap: () => context.pushNamed(Navigate.player),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              media.artworkUrl100,
              width: 100,
              height: 100,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(Icons.image, color: Colors.grey[400]),
                  ),
                );
              },
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.broken_image_rounded,
                      color: Colors.grey[400],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  media.trackName,
                  style: context.textTheme.titleLarge,
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
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
