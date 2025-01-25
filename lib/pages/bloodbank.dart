import 'package:flutter/material.dart';

class BloodBankPage extends StatefulWidget {
  @override
  _BloodBankPageState createState() => _BloodBankPageState();
}

class _BloodBankPageState extends State<BloodBankPage> {
  // List to store posted animal details
  List<Map<String, String>> animalDetails = [];

  // Controllers for posting animal details
  final TextEditingController animalNameController = TextEditingController();
  final TextEditingController animalTypeController = TextEditingController();
  final TextEditingController animalBreedController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();

  // Dummy list of nearby hospitals/veterinarians
  final List<Map<String, String>> nearbyHospitals = [
    {
      'name': 'Happy Paws Veterinary Hospital',
      'address': '123 Pet Street, New York',
      'availableBlood': 'A+, B+, O+',
    },
    {
      'name': 'Care & Cure Vet Clinic',
      'address': '456 Animal Ave, Boston',
      'availableBlood': 'B-, O-',
    },
    {
      'name': 'Pet Life Hospital',
      'address': '789 Pet Lovers Lane, Chicago',
      'availableBlood': 'A-, AB+',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal Blood Bank"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section to Post Animal Details
            Text(
              "Post Animal Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildTextField("Animal Name", animalNameController),
            buildTextField(
                "Animal Type (e.g., Dog, Cat)", animalTypeController),
            buildTextField("Breed", animalBreedController),
            buildTextField("Blood Group (e.g., A+, O-)", bloodGroupController),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: postAnimalDetails,
              icon: Icon(Icons.add),
              label: Text("Post Details"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),

            // Section to View Posted Animals
            Text(
              "Posted Animals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: animalDetails.length,
              itemBuilder: (context, index) {
                final animal = animalDetails[index];
                return buildAnimalCard(animal);
              },
            ),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),

            // Section to View Nearby Hospitals
            Text(
              "Nearby Hospitals with Available Blood",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: nearbyHospitals.length,
              itemBuilder: (context, index) {
                final hospital = nearbyHospitals[index];
                return buildHospitalCard(hospital);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildAnimalCard(Map<String, String> animal) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(Icons.pets, color: Colors.white),
        ),
        title: Text(animal['name'] ?? ''),
        subtitle: Text(
          "Type: ${animal['type']}\nBreed: ${animal['breed']}\nBlood Group: ${animal['bloodGroup']}",
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget buildHospitalCard(Map<String, String> hospital) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.local_hospital, color: Colors.teal, size: 40),
        title: Text(hospital['name'] ?? ''),
        subtitle: Text(
          "${hospital['address']}\nAvailable Blood: ${hospital['availableBlood']}",
        ),
        isThreeLine: true,
        trailing: Icon(Icons.arrow_forward, color: Colors.teal),
      ),
    );
  }

  void postAnimalDetails() {
    if (animalNameController.text.isEmpty ||
        animalTypeController.text.isEmpty ||
        animalBreedController.text.isEmpty ||
        bloodGroupController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please fill in all fields to post animal details!")),
      );
      return;
    }

    setState(() {
      animalDetails.add({
        'name': animalNameController.text,
        'type': animalTypeController.text,
        'breed': animalBreedController.text,
        'bloodGroup': bloodGroupController.text,
      });
    });

    // Clear input fields
    animalNameController.clear();
    animalTypeController.clear();
    animalBreedController.clear();
    bloodGroupController.clear();
  }
}
