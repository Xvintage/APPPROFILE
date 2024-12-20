import 'package:flutter/material.dart';
import 'login_screen.dart';

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
        scaffoldBackgroundColor: const Color(0xFFE9E5AD),  // Global background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE9E5AD),  // AppBar background color
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFE9E5AD),  // Drawer background color
        ),
      ),
      home: const LoginScreen(), // Initially loading the Login Screen
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
          mainAxisAlignment: MainAxisAlignment.center,
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
              "", // Placeholder text, can be removed or filled with a bio or description
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileItem(icon: Icons.email, label: 'Personal Email', value: 'busallakyle29@gmail.com'),
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
// Cipher screen implementation
class CipherScreen extends StatefulWidget {
  const CipherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CipherScreenState createState() => _CipherScreenState();
}
class _CipherScreenState extends State<CipherScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String _output = "";
  String _selectedCipher = "ATBASH";

  // Cipher encryption/decryption logic
  String atbashCipher(String input) {
    return input
        .toUpperCase()
        .split('')
        .map((char) {
          if (char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90) {
            return String.fromCharCode(155 - char.codeUnitAt(0));
          }
          return char;
        })
        .join('');
  }

  String ceasarCipher(String input, int shift, {bool decrypt = false}) {
    return input
        .split('')
        .map((char) {
          if (char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90) {
            int newCharCode = ((char.codeUnitAt(0) - 65 + shift * (decrypt ? -1 : 1)) % 26 + 26) % 26 + 65;
            return String.fromCharCode(newCharCode);
          }
          return char;
        })
        .join('');
  }

  String vigenereCipher(String input, String key, {bool decrypt = false}) {
    key = key.toUpperCase();
    int keyIndex = 0;
    return input
        .toUpperCase()
        .split('')
        .map((char) {
          if (char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90) {
            int shift = key.codeUnitAt(keyIndex % key.length) - 65;
            if (decrypt) shift = -shift;
            keyIndex++;
            return String.fromCharCode(((char.codeUnitAt(0) - 65 + shift) % 26 + 26) % 26 + 65);
          }
          return char;
        })
        .join('');
  }

  void _processInput({bool decrypt = false}) {
    String input = _inputController.text.trim();
    String key = _keyController.text.trim();
    setState(() {
      switch (_selectedCipher) {
        case "ATBASH":
          _output = atbashCipher(input);
          break;
        case "CEASAR":
          _output = ceasarCipher(input, int.tryParse(key) ?? 0, decrypt: decrypt);
          break;
        case "VIGENERE":
          _output = vigenereCipher(input, key, decrypt: decrypt);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cipher Encryption/Decryption"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedCipher,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCipher = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(value: "ATBASH", child: Text("ATBASH Cipher")),
                DropdownMenuItem(value: "CEASAR", child: Text("CEASAR Cipher")),
                DropdownMenuItem(value: "VIGENERE", child: Text("VIGENERE Cipher")),
              ],
            ),
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: "Input Text",
              ),
            ),
            if (_selectedCipher != "ATBASH")
              TextField(
                controller: _keyController,
                decoration: InputDecoration(
                  labelText: _selectedCipher == "CEASAR"
                      ? "Key (Shift Amount)"
                      : "Key (Text)",
                ),
              ),
            const SizedBox(height: 16),
            // Encrypt Button
            ElevatedButton(
              onPressed: () => _processInput(decrypt: false),
              child: const Text("Encrypt"),
            ),
            const SizedBox(height: 8),
            // Decrypt Button
            ElevatedButton(
              onPressed: () => _processInput(decrypt: true),
              child: const Text("Decrypt"),
            ),
            const SizedBox(height: 16),
            const Text(
              "Output:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              _output,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFE9E5AD),  // Ensure the drawer uses the same background
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFE9E5AD),  // Ensure the header uses the same background
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
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.black),
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
            leading: const Icon(Icons.lock, color: Colors.black),
            title: const Text('Ciphers', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CipherScreen()),
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
          const Spacer(),
         
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
        title: const Text("Projects"),
      ),
      backgroundColor: const Color(0xFFE9E5AD), // Set background color of the screen
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProjectBox(
                imagePath: 'assets/project1.png',
                projectName: "Math Project",
                description:
                    "THES PROJECT IS DURING MY FIRST YEAR SECOND SEM IN MY DISTINCT MATH",
              ),
              SizedBox(height: 16),
              ProjectBox(
                imagePath: 'assets/project2.png',
                projectName: "INSTITUTE T-SHIRT",
                description:
                    "THESE IS MY FIRST TIME TO LAYOUT A INSTITUTE T-SHIRT",
              ),
              SizedBox(height: 16),
              ProjectBox(
                imagePath: 'assets/project3.png',
                projectName: "BYTE FEST",
                description:
                    "THESE PROJECT IS DURING IN BYTE FEAST AND I'M A PARTICIPANT OF SDE OR SAME DAY EDIT AND WE ARE THE FIRST RUNNER UP DURING THAT TIME",
              ),
              SizedBox(height: 16),
              ProjectBox(
                imagePath: 'assets/project4.png',
                projectName: "SALES AND INVENTORY SYSTEM",
                description:
                    "We generated multiple projects in our first year of programming using Java. One of our final projects was the contact information holder, where we used CRUD operations and stored the data in a database.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ProjectBox extends StatelessWidget {
  final String imagePath;
  final String projectName;
  final String description;

  const ProjectBox({
    super.key,
    required this.imagePath,
    required this.projectName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E5AD), // Set the background color for the box
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(
            projectName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
          ),
        ],
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
        title: const Text("About the App"),
      ),
      body: const Center(
        child: Text(
          "About this app...",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
