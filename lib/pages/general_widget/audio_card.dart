import 'package:flutter/material.dart';
import 'package:musicapp/providers/playlist_provider.dart';
import 'package:provider/provider.dart';

class AudioCard extends StatelessWidget {
  const AudioCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final playlist = value.playlist;

        final currentSong = (value.currentSongIndex != null &&
                value.currentSongIndex! >= 0 &&
                value.currentSongIndex! < playlist.length)
            ? playlist[value.currentSongIndex!]
            : null;
        if (currentSong == null) {
          return Card(
            child: Text(""),
          ); // Return empty if no song is available
        }
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Song thumbnail
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          currentSong.albumArtImagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Song details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.songName,
                            // style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            currentSong.artistName,
                            // style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
              
                     
                    ],
                  ),
                  // Playback controls
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: () => value.playPreviousSong(),
                      ),
                      IconButton(
                        icon:
                            Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: () => value.pauseOrResume(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: () => value.playNextSong(),
                      ),
                    ],
                  ),
                ],
              ),
               SizedBox(
                width: 3000,
                 child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                          ),
                          child: Slider(
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            value: value.currentDuration.inSeconds.toDouble(),
                            activeColor: Colors.white,
                            onChanged: (double double) {},
                            onChangeEnd: (double double) {
                              value.seek(Duration(seconds: double.toInt()));
                            },
                          ),
                        ),
               ),
            ],
          ),
        );
      },
    );
  }
}
