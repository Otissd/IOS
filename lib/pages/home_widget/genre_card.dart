import 'package:flutter/material.dart';

import '../../models/genre.dart';
class GenreCard extends StatelessWidget {
  final Genre genre;
  final VoidCallback? onTap;
  const GenreCard({super.key, required this.genre,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: genre.color.withOpacity(0.2),
          border: Border.all(color: genre.color, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          genre.title,
          style: TextStyle(
            color: genre.color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}