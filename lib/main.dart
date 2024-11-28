import 'package:flutter/material.dart';
import 'login_screen.dart';
// Import ProfileScreen




void main() {
  runApp(const ProfileApp());
}


class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE9E5AD), // Global background color for all pages
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE9E5AD), // Set navbar (AppBar) background color
          iconTheme: IconThemeData(color: Colors.black), // Set icon color if desired
          titleTextStyle: TextStyle(
            color: Colors.black, // Set title text color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0, // Remove shadow for a flat look if desired
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(), // Set LoginScreen as the home screen
      debugShowCheckedModeBanner: false, // Hide debug banner
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kyle Busalla"),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Hi Kyle",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            
            const Spacer(), // Pushes profile items down
            const Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
              children: [
                ProfileItem(icon: Icons.email, label: 'Personal Email', value: 'busallakyle29@gamilcom'),
                ProfileItem(icon: Icons.email, label: 'School Email', value: 'busalla.kyle@edu.ph'),
                ProfileItem(icon: Icons.facebook, label: 'Facebook', value: 'Kyle Busalla'),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileItem({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Text(
            "$label:",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFE9E5AD), // Set background color for the drawer
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFE9E5AD), // Same background color for header
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black), // Set icon color
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.black), // Set text color
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work, color: Colors.black),
            title: const Text(
              'Project',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProjectScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.black),
            title: const Text(
              'About',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          const Spacer(), // Pushes the contact option to the bottom
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.black),
            title: const Text(
              'Contact',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to Contact screen or any desired functionality here
            },
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "I AM KYLE BUSALLA, AND I AM AN IT STUDENT FROM DAVAO DEL NORTE STATE "
            "COLLEGE AND AN UPCOMING 3RD YEAR STUDENT. MY JOURNEY AS AN IT STUDENT "
            "STARTED WITH BEING SIMPLY FASCINATED BY HOW TECHNOLOGIES WORK AND "
            "EVENTUALLY TURNED INTO A CURIOSITY, WHICH SERVED AS A DRIVING FORCE "
            "FOR ME TO PURSUE A BACHELOR OF SCIENCE IN INFORMATION TECHNOLOGY (BSIT).",
            style: TextStyle(fontSize: 18, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project"),
      ),
      body: const Center(
        child: Text(
          "Project Details Here!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: const Center(
        child: Text(
          "About the App",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
