import 'package:flutter/material.dart';
import 'package:musicapp/models/genre.dart';
import 'package:musicapp/pages/general_widget/background_gradiant.dart';
import 'package:musicapp/pages/home_widget/genre_card.dart';
import 'package:musicapp/services/api/genre_api.dart';

import '../genre_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData.dark(),
      home: GenreList(apiService: GenreApi()),
    );
  }
}

class GenreList extends StatelessWidget {
  final GenreApi apiService;

  const GenreList({Key? key, required this.apiService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Set transparent to let gradient show
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Select Genres',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
            ),
          ),
          elevation: 0,
          backgroundColor:
              Colors.transparent, // AppBar transparent to match gradient
        ),
        body: FutureBuilder<List<Genre>>(
          future: apiService.fetchItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No genres found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              final items = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: items
                      .map((item) => GenreCard(
                            genre: item,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GenrePage(genre: item),
                                ),
                              );
                              // Handle tap action for GenreCard
                              print('Genre ${item.title} tapped!');
                            },
                          ))
                      .toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
