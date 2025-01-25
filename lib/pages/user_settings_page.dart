import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      backgroundColor: const Color.fromARGB(255, 255, 247, 241), // Skin color
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "User Settings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // User picture and details section
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => pickUserImage(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    backgroundImage: userProfileImage != null
                        ? FileImage(userProfileImage!)
                        : null,
                    child: userProfileImage == null
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  "User Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildTextField("Username", usernameController),
            buildTextField("Email", emailController),
            buildTextField("Phone Number", phoneController,
                keyboardType: TextInputType.phone),
            buildTextField("Address", addressController),

            const SizedBox(height: 30),

            // Pet details section
            const Row(
              children: [
                Icon(Icons.pets, size: 30, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  "Pet Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...pets.map((pet) => buildPetCard(pet)).toList(),
            const SizedBox(height: 20),

            // Add new pet section
            const Text(
              "Add a Pet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            buildTextField("Pet Name", petNameController),
            buildTextField("Type (e.g., Dog, Cat)", petTypeController),
            buildTextField("Breed", petBreedController),
            buildTextField("Age (Optional)", petAgeController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => pickPetImage(),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 111, 95, 95),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: petImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(petImage!, fit: BoxFit.cover),
                      )
                    : const Center(
                        child: Text(
                          "Tap to add pet image",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: addPet,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Add Pet", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 81, 61, 61), // Pastel pink
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        style: const TextStyle(color: Color.fromARGB(255, 156, 156, 156)),
      ),
    );
  }

  Widget buildPetCard(Map<String, dynamic> pet) {
    return Card(
      color: const Color.fromARGB(255, 67, 64, 64), // Pastel dark pink
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        leading: pet['image'] != null
            ? CircleAvatar(
                backgroundImage: FileImage(pet['image']),
                radius: 30,
              )
            : const Icon(Icons.pets, color: Colors.white),
        title: Text(
          pet['name'] ?? '',
          style: const TextStyle(color: Color.fromARGB(255, 70, 42, 42)),
        ),
        subtitle: Text(
          "Type: ${pet['type']}\nBreed: ${pet['breed']}${pet['age'] != null && pet['age']!.isNotEmpty ? "\nAge: ${pet['age']}" : ""}",
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
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
        const SnackBar(content: Text("Please fill in all required fields for the pet!")),
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
