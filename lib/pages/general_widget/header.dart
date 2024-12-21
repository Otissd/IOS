import 'package:flutter/material.dart';
import 'package:musicapp/providers/user_provider.dart'; // Update the path if necessary
import 'package:musicapp/pages/user_page.dart';
import 'package:provider/provider.dart';

class GeneralHeader extends StatelessWidget {
  const GeneralHeader({super.key});

  // Get greeting based on the time of day
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Color.fromARGB(255, 219, 4, 76)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.currentUser;

          // if (user == null) {
          //   return const Center(
          //     child: Text(
          //       'No user logged in',
          //       style: TextStyle(color: Colors.white, fontSize: 16),
          //     ),
          //   );
          // }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${getGreeting()}, ${user?.fullname}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to a profile or user detail page
                  // Replace `DetailUser` with your actual widget
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(), // Replace with your widget
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: user!.image.startsWith('http')
                      ? NetworkImage(user.image)
                      : AssetImage(user.image) as ImageProvider,
                  radius: 20,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
