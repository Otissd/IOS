import 'package:flutter/material.dart';
import 'package:musicapp/providers/album_provider.dart';
import 'package:musicapp/providers/user_provider.dart';
import 'package:musicapp/pages/general_widget/footer.dart';
import 'package:musicapp/pages/general_widget/header.dart';
import 'package:musicapp/pages/user_page.dart';
import 'package:provider/provider.dart';

import 'home_content-viewer.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AlbumProvider(), // Wrap the app with AlbumProvider
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContent(), // HomeContent widget for the first page
    Center(
        child:
            Text("Favorites Content", style: TextStyle(color: Colors.white))),
    Center(
        child: Text("Search Content", style: TextStyle(color: Colors.white))),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color.fromARGB(255, 219, 4, 76)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Header positioned at the top of the screen
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: const GeneralHeader(),
          ),
          
          // Content in between header and footer
          Positioned.fill(
            top: 70, // Offset to account for header height
            bottom: 60, // Offset to account for footer height
            child: SafeArea(
              child: _pages[
                  _currentIndex], // Safe area to avoid UI elements overlap
            ),
          ),
          // Footer positioned at the bottom of the screen
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GeneralFooter(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
