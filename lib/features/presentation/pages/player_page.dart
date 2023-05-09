import 'package:flutter/material.dart';
import 'package:itunes_music_player/core/utils/extensions.dart';
import 'package:itunes_music_player/features/presentation/providers/player_provider.dart';
import 'package:itunes_music_player/features/presentation/widgets/images.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: IconButton(
              onPressed: () => context.popPage(),
              icon: const Icon(Icons.arrow_back_outlined),
            ),
          ),
        ),
      ),
      body: Consumer<PalyerProvider>(
        builder: (_, playerProvider, __) {
          if (playerProvider.isSetPlayer) {
            return const Center(child: CircularProgressIndicator());
          }

          final media = playerProvider.media;
          return SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: media.trackId,
                  child: ImageApp(
                    url: media.artworkUrl100,
                    width: context.width * 0.8,
                  ),
                ).paddingOnly(top: 20),
                Text(
                  media.trackName,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ).paddingOnly(top: 16),
                Text(
                  media.artistName,
                ).paddingOnly(top: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => playerProvider.rewind(),
                      icon: const Icon(Icons.replay_10_outlined, size: 30),
                    ),
                    Material(
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
                            size: 50,
                            color: context.theme.colorScheme.surface,
                          ),
                        ),
                      ),
                    ).paddingOnly(left: 8, right: 8),
                    IconButton(
                      onPressed: () => playerProvider.fordward(),
                      icon: const Icon(Icons.forward_10_outlined, size: 30),
                    ),
                  ],
                ).paddingOnly(top: 20),
                Slider(
                  value: playerProvider.position.inSeconds.toDouble(),
                  max: playerProvider.duration.inSeconds.toDouble(),
                  onChanged: (value) => playerProvider.seek(value.toInt()),
                ).paddingOnly(top: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      playerProvider.positionToString(),
                      style: context.textTheme.bodyMedium,
                    ),
                    Text(
                      playerProvider.durationToString(),
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ).paddingSymmetric(h: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
