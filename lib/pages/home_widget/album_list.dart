import 'package:flutter/material.dart';
import 'package:musicapp/providers/album_provider.dart';


class HorizontalAlbumList extends StatelessWidget {
  final List<String> albumIds;
  final AlbumProvider albumProvider;

  const HorizontalAlbumList({
    required this.albumIds,
    required this.albumProvider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final albums = albumProvider.getAlbumsFromIds(albumIds);

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                // Handle album tap here
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(album.albumArt),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    album.artistName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
