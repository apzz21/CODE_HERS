import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // Add this dependency for picking images

class UserSettingsPage extends StatefulWidget {
  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  // User details controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // User profile picture
  File? userProfileImage;

  // List to store pet details
  List<Map<String, dynamic>> pets = [];

  // Controllers for pet details
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petTypeController = TextEditingController();
  final TextEditingController petBreedController = TextEditingController();
  final TextEditingController petAgeController = TextEditingController();

  // Pet image
  File? petImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User picture and details section
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => pickUserImage(),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: userProfileImage != null
                        ? FileImage(userProfileImage!)
                        : null,
                    child: userProfileImage == null
                        ? Icon(Icons.person, size: 40, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "User Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            buildTextField("Username", usernameController),
            buildTextField("Email", emailController),
            buildTextField("Phone Number", phoneController,
                keyboardType: TextInputType.phone),
            buildTextField("Address", addressController),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),

            // Pet details section
            Text(
              "Pet Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...pets.map((pet) => buildPetCard(pet)).toList(),
            SizedBox(height: 10),

            // Add new pet section
            Text(
              "Add a Pet",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildTextField("Pet Name", petNameController),
            buildTextField("Type (e.g., Dog, Cat)", petTypeController),
            buildTextField("Breed", petBreedController),
            buildTextField("Age (Optional)", petAgeController,
                keyboardType: TextInputType.number),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => pickPetImage(),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: petImage != null
                    ? Image.file(petImage!, fit: BoxFit.cover)
                    : Center(
                        child: Text(
                          "Tap to add pet image",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: addPet,
              icon: Icon(Icons.add),
              label: Text("Add Pet"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),

            SizedBox(height: 20),
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

  Widget buildPetCard(Map<String, dynamic> pet) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: pet['image'] != null
            ? CircleAvatar(
                backgroundImage: FileImage(pet['image']),
                radius: 25,
              )
            : Icon(Icons.pets, color: Colors.teal),
        title: Text(pet['name'] ?? ''),
        subtitle: Text(
          "Type: ${pet['type']}\nBreed: ${pet['breed']}${pet['age'] != null && pet['age']!.isNotEmpty ? "\nAge: ${pet['age']}" : ""}",
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => removePet(pet),
        ),
        isThreeLine: true,
      ),
    );
  }

  Future<void> pickUserImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        userProfileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> pickPetImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        petImage = File(pickedFile.path);
      });
    }
  }

  void addPet() {
    if (petNameController.text.isEmpty ||
        petTypeController.text.isEmpty ||
        petBreedController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please fill in all required fields for the pet!")),
      );
      return;
    }

    setState(() {
      pets.add({
        'name': petNameController.text,
        'type': petTypeController.text,
        'breed': petBreedController.text,
        'age': petAgeController.text,
        'image': petImage,
      });
    });

    // Clear pet input fields and image
    petNameController.clear();
    petTypeController.clear();
    petBreedController.clear();
    petAgeController.clear();
    petImage = null;
  }

  void removePet(Map<String, dynamic> pet) {
    setState(() {
      pets.remove(pet);
    });
  }
}
