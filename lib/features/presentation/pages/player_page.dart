import 'package:flutter/material.dart';
import 'package:itunes_music_player/core/utils/extensions.dart';
import 'package:itunes_music_player/features/presentation/providers/player_provider.dart';
import 'package:itunes_music_player/features/presentation/widgets/images.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PalyerProvider>(
      builder: (_, playerProvider, __) {
        final media = playerProvider.media;
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: media.trackId,
                  child: ImageApp(
                    url: media.artworkUrl100,
                    width: context.width * 0.8,
                  ),
                ),
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
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous_outlined, size: 30),
                    ),
                    Material(
                      color: context.theme.colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.play_arrow_outlined,
                            size: 50,
                            color: context.theme.colorScheme.surface,
                          ),
                        ),
                      ),
                    ).paddingOnly(left: 8, right: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next_outlined, size: 30),
                    ),
                  ],
                ).paddingOnly(top: 20),
                Slider(
                  value: 0.5,
                  onChanged: (value) {},
                ).paddingOnly(top: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
