// Model: Item
import 'package:flutter/material.dart';

class Genre {
  final int id;
  final String title;
  final String image;
  final Color color;

  // Genre({required this.id, required this.title, required this.image,});
  Genre(
      {required this.id,
      required this.title,
      required this.image,
      required this.color});

  // Factory method to create an Item from JSON
  // factory Genre.fromJson(Map<String, dynamic> json) {
  //   return Genre(
  //     id: json['id'],
  //     title: json['title'],
  //     image: json['image'],
  //   );
  // }
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      color: colorMapping[json['color']] ?? Colors.grey,
    );
  }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'image': image,
  //   };
  // }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'color': color,
    };
  }
}

final Map<String, Color> colorMapping = {
  "brown": Colors.brown,
  "blue": Colors.blue,
  "red": Colors.red,
  "green": Colors.green,
  "pink": Colors.pink,
  "yellow": Colors.yellow,
  
};
