import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_haven/pages/adoption.dart';
import 'package:pet_haven/pages/bloodbank.dart';
import 'package:pet_haven/pages/caretaker.dart';
import 'package:pet_haven/pages/fundraiser.dart';
import 'package:pet_haven/pages/gen_ai.dart';
import 'package:pet_haven/pages/setting_page.dart';
import 'package:pet_haven/pages/strayanimal.dart';
import 'package:pet_haven/pages/user_settings_page.dart';

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
      "image": "lib/assets/parrot.png",
    },
    {
      "fact": "Goldfish have a memory span of months.",
      "image": "lib/assets/golden_fish.png",
    },
    {
      "fact": "Dolphins have unique names for each other.",
      "image": "lib/assets/dolphi.png",
    },
  ];

  final List<Color> gradientColors = [
    const Color.fromARGB(255, 141, 204, 238),
    const Color.fromARGB(255, 238, 174, 206),
    const Color.fromARGB(255, 229, 202, 159),
    const Color.fromARGB(255, 224, 162, 243),
    const Color.fromARGB(255, 227, 162, 192),
  ];

  int _currentPetFactIndex = 0;  // Index for pet facts
  int _bottomNavBarIndex = 0;    // Index for BottomNavigationBar
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _currentPetFactIndex = (_currentPetFactIndex + 1) % petFacts.length;
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
      appBar: AppBar(
        elevation: 0,
        title: Text('Pet Haven', style: TextStyle(color: Colors.purple.shade100)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: width * 0.045),
        //     child: const Icon(Icons.notifications_none, color: Colors.black),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.5,
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.045,
                  horizontal: width * 0.05,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gradientColors[_currentPetFactIndex],
                      gradientColors[(_currentPetFactIndex + 1) % gradientColors.length],
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
                        width: width * 0.55,
                        height: height * 0.25,
                        child: Image.asset(
                          petFacts[_currentPetFactIndex]["image"]!,
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
                      petFacts[_currentPetFactIndex]["fact"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: width * 0.025,
                crossAxisSpacing: width * 0.025,
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
        currentIndex: _bottomNavBarIndex,  // Use separate index for BottomNavigationBar
        selectedItemColor: const Color(0xFFF48FB1),
        onTap: (index) {
          setState(() {
            _bottomNavBarIndex = index;  // Update BottomNavigationBar index
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ChatPageG()),
            );
          }
          else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   DashboardPage ()),
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
        return _buildTile('Profile and edits', 'lib/assets/Profile_and_edits.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserSettingsPage())), width);
      case 1:
        return _buildTile('Fetch Mate', 'lib/assets/Fetch_mate.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerScreen())), width);
      case 2:
        return _buildTile('Blood Bank', 'lib/assets/blood_bank.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => BloodBankPage())), width);
      case 3:
        return _buildTile('Fund Raiser', 'lib/assets/fund_raiser.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => FundraiserPage())), width);
      case 4:
        return _buildTile('Adopto', 'lib/assets/Adopto.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalAdoptionApp())), width);
      case 5:
        return _buildTile('Stray Animal Posting', 'lib/assets/stray_animal_post.png',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => StrayAnimalPage())), width);
      default:
        return Container();
    }
  }

  Widget _buildTile(String title, String imagePath, VoidCallback onTap, double width) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                width: width * 0.25,
                height: width * 0.25,
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
          ],
        ),
      ),
    );
  }
}
