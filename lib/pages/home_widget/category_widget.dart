import 'package:flutter/material.dart';
import 'package:musicapp/models/categories.dart';
import 'package:musicapp/pages/home_widget/album_list.dart';
import 'package:musicapp/providers/album_provider.dart';

import 'package:provider/provider.dart';


class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({required this.categories, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "See more" action
                    },
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Horizontal album list
              HorizontalAlbumList(albumIds: category.albumIds, albumProvider: albumProvider),
            ],
          ),
        );
      },
    );
  }
}
