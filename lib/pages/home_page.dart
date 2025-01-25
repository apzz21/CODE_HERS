import 'dart:async';

import 'package:CODE_HERS/pages/bloodbank.dart';
import 'package:CODE_HERS/pages/fundraiser.dart';
import 'package:CODE_HERS/pages/strayanimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
<<<<<<< HEAD
import 'package:pet_haven/pages/caretaker.dart';
import 'package:pet_haven/pages/user_settings_page.dart';
=======
import 'package:pet_haven/pages/adoption.dart';
import 'package:pet_haven/pages/caretaker.dart';
>>>>>>> 7d6f33dd8f496ad81d51425374b37145908fa7a2

import 'demo_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, String>> petFacts = [
    {
      "fact": "Dogs can learn over 1000 words!",
      "image": "lib/assets/dog_line_illustration.png",
    },
    {
      "fact": "Cats spend 70% of their lives sleeping.",
      "image": "lib/assets/cat_line_illustration.png",
    },
    {
      "fact": "Parrots can live for over 50 years!",
      "image": "lib/assets/cat_line_illustration.png",
    }
  ];

  final List<Color> gradientColors = [
    const Color.fromARGB(255, 141, 204, 238),
    const Color.fromARGB(255, 238, 174, 206),
    const Color.fromARGB(255, 229, 202, 159),
    const Color.fromARGB(255, 143, 233, 215),
    const Color.fromARGB(255, 224, 147, 175),
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % petFacts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.4,
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.04,
                  horizontal: width * 0.05,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gradientColors[_currentIndex],
                      gradientColors[
                          (_currentIndex + 1) % gradientColors.length],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: width * 0.5,
                        height: height * 0.2,
                        child: Image.asset(
                          petFacts[_currentIndex]["image"]!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              size: 60,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      petFacts[_currentIndex]["fact"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: width * 0.02,
                crossAxisSpacing: width * 0.02,
                children: const [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 0),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 3),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 4),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 2),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 5),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFF48FB1),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DemoPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'ChatAI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;

  const Tile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    switch (index) {
      case 0:
<<<<<<< HEAD
        return _buildTile('Profile and edits', 'lib/assets/Profile_and_edits.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserSettingsPage())), width);
      case 1:
        return _buildTile('Fetch Mate', 'lib/assets/Fetch_mate.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerScreen())), width);
      case 2:
        return _buildTile('Blood Bank', 'lib/assets/blood_bank.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage())), width);
      case 3:
        return _buildTile('Fund Raiser', 'lib/assets/fund_raiser.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage())), width);
      case 4:
        return _buildTile('Adopto', 'lib/assets/Adopto.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage())), width);
      case 5:
        return _buildTile('Stray Animal Posting', 'lib/assets/stray_animal_post.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage())), width);
=======
        return _buildTile(
            'Profile and edits',
            'lib/assets/Activity_catalogue.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DemoPage()),
                ));
      case 1:
        return _buildTile(
            'Fetch Mate',
            'lib/assets/Activity_catalogue.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CaretakerScreen()),
                ));
      case 2:
        return _buildTile(
            'Blood Bank',
            'lib/assets/Activity_catalogue.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BloodBankPage()),
                ));
      case 3:
        return _buildTile(
            'Fund Raiser',
            'lib/assets/Upload_certificate.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FundraiserPage()),
                ));
      case 4:
        return _buildTile(
<<<<<<< HEAD
            'Adopto',
=======
            'Adoption',
>>>>>>> 81b1ac95a9117d92a77faa06b244c0b3801e2abc
            'lib/assets/Tracked_activity_list.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalAdoptionApp()),
                ));
      case 5:
        return _buildTile(
            'Stray Animal Posting',
            'lib/assets/Earn_your_points.png',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StrayAnimalPage()),
                ));
>>>>>>> 7d6f33dd8f496ad81d51425374b37145908fa7a2
      default:
        return Container();
    }
  }

  Widget _buildTile(String title, String imagePath, VoidCallback onTap, double width) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< HEAD
            Flexible(
              child: SizedBox(
                width: width * 0.2,
                height: width * 0.2,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
=======
            SizedBox(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            Text(title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
>>>>>>> 7d6f33dd8f496ad81d51425374b37145908fa7a2
          ],
        ),
      ),
    );
  }
}
