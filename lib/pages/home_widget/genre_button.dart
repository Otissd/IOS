import 'package:flutter/material.dart';
import '../../models/genre.dart';
import '../../services/api/genre_api.dart';
import '../genre_page.dart';
import 'button_custom.dart';
import 'genre_widget.dart';

class GenreButton extends StatelessWidget {
  const GenreButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final apiService = GenreApi("your_base_url_here"); // Pass the API service here
    final apiService = GenreApi();
    return SingleChildScrollView(
      // Just use SingleChildScrollView to make the row horizontally scrollable
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Music and Podcast Buttons
          CustomButton(
            id: 1,
            onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenrePage(
                    genre: Genre(
                      id: 1,
                      title: 'Rnb',
                      image: 'image1.png',
                      color: Colors.brown,
                    ),
                  ),
                ),
              );
            },
            apiService: apiService,
          ),
          const SizedBox(width: 15),
          CustomButton(
            id: 2,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenrePage(
                    genre: Genre(
                      id: 2,
                      title: 'Chill',
                      image: 'image2.png',
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            },
            apiService: apiService,
          ),
          const SizedBox(width: 10),
          CustomButton(
            id: 3,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenrePage(
                    genre: Genre(
                      id: 3,
                      title: 'Love',
                      image: 'image3.png',
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
            apiService: apiService,
          ),
          const SizedBox(width: 15),
           CustomButton(
            id: 4,
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenrePage(
                    genre: Genre(
                      id: 3,
                      title: 'Rock',
                      image: 'image4.png',
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            },
            apiService: apiService,
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
               Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenreList(apiService: apiService),
      ),
    );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'More...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
