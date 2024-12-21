import 'package:flutter/material.dart';

class GeneralFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GeneralFooter({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures the footer fills the entire width
      height: 70, // Set the height of the footer to match the desired ClipRRect size
      decoration: const BoxDecoration(
        color: Colors.white, // Footer background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Rounded top corners
          topRight: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), // Matches container's border radius
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white, // Matches container background color
          currentIndex: currentIndex,
          onTap: onTap,
          elevation: 0, // Removes shadow from BottomNavigationBar
          selectedItemColor: Colors.red, // Active item color
          unselectedItemColor: const Color.fromARGB(255, 8, 8, 8), // Inactive item color
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
