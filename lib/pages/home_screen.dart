import 'package:flutter/material.dart';
import 'caretaker.dart'; // Import the caretaker screen file

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildFeatureButton({
    required String title,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PawPal'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildFeatureButton(
            title: 'FetchMate',
            icon: Icons.handshake,
            color: Colors.blue,
            screen:
                CaretakerScreen(), // Navigate to CaretakerScreen from caretaker.dart
          ),
          _buildFeatureButton(
            title: 'Animal Adoption',
            icon: Icons.pets,
            color: Colors.green,
            screen: AdoptionScreen(),
          ),
          _buildFeatureButton(
            title: 'Fundraisers',
            icon: Icons.volunteer_activism,
            color: Colors.orange,
            screen: FundraiserScreen(),
          ),
          _buildFeatureButton(
            title: 'Animal Blood Bank',
            icon: Icons.bloodtype,
            color: Colors.red,
            screen: BloodBankScreen(),
          ),
          _buildFeatureButton(
            title: 'Responsible Breeding',
            icon: Icons.family_restroom,
            color: Colors.purple,
            screen: BreedingScreen(),
          ),
          _buildFeatureButton(
            title: 'Stray Animal Help',
            icon: Icons.location_on,
            color: Colors.brown,
            screen: StrayAnimalScreen(),
          ),
        ],
      ),
    );
  }
}

// AdoptionScreen Demo
class AdoptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animal Adoption')),
      body: Center(child: Text('Adoption Feature Coming Soon!')),
    );
  }
}

// FundraiserScreen Demo
class FundraiserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fundraisers')),
      body: Center(child: Text('Fundraiser Feature Coming Soon!')),
    );
  }
}

// BloodBankScreen Demo
class BloodBankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animal Blood Bank')),
      body: Center(child: Text('Blood Bank Feature Coming Soon!')),
    );
  }
}

// BreedingScreen Demo
class BreedingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Responsible Breeding')),
      body: Center(child: Text('Breeding Feature Coming Soon!')),
    );
  }
}

// StrayAnimalScreen Demo
class StrayAnimalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stray Animal Help')),
      body: Center(child: Text('Stray Animal Help Feature Coming Soon!')),
    );
  }
}
