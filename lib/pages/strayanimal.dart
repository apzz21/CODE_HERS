import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StrayAnimalPage extends StatefulWidget {
  @override
  _StrayAnimalPageState createState() => _StrayAnimalPageState();
}

class _StrayAnimalPageState extends State<StrayAnimalPage>
    with TickerProviderStateMixin {
  // List to store stray animal posts
  List<Map<String, dynamic>> strayAnimals = [];

  // Controllers for posting stray animal details
  final TextEditingController locationController = TextEditingController();
  final TextEditingController nameController =
      TextEditingController(); // Controller for user name

  // Image for stray animal
  File? strayImage;

  // Animation controller for scaling image
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize stray animal data
    strayAnimals = [
      {
        'image':
            'https://images.theconversation.com/files/417128/original/file-20210820-27-j1ro6y.jpg?ixlib=rb-4.1.0&rect=0%2C11%2C3994%2C2640&q=45&auto=format&w=926&fit=clip',
        'location': 'Central Park',
        'user': 'Alice',
      },
      {
        'image':
            'https://media.gettyimages.com/id/668030048/photo/stray-dogs-sleeping-on-the-pavement-pondicherry-india-let-sleeping-dogs-lie.jpg?s=612x612&w=0&k=20&c=nmvkvoPf8H4GafaqIKg7hVB6mpx2l9eZVhgreC2skO8=',
        'location': 'Downtown',
        'user': 'Bob',
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpgladlKf9Hm0DTMcsHpojbbjuwuJVwl94Hw&s',
        'location': 'Old Town',
        'user': 'Charlie',
      },
    ];

    // Initialize animation controller for scaling
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stray Animal Posting"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section to Post Stray Animal Details
            Text(
              "Post Stray Animal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // TextField for User Name
            buildTextField("Enter your name", nameController),
            SizedBox(height: 10),
            // Image Picker
            GestureDetector(
              onTap: () => pickStrayImage(),
              child: MouseRegion(
                onEnter: (_) => _animationController.forward(),
                onExit: (_) => _animationController.reverse(),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: strayImage != null
                          ? Image.file(strayImage!, fit: BoxFit.cover)
                          : Center(
                              child: Icon(
                                Icons.pets,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            buildTextField(
                "Enter location where stray was found", locationController),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: postStrayAnimal,
              icon: Icon(Icons.add),
              label: Text("Post"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),

            // Section to View Posted Stray Animals
            Text(
              "Posted Stray Animals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: strayAnimals.length,
              itemBuilder: (context, index) {
                final stray = strayAnimals[index];
                return buildStrayAnimalCard(stray);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildStrayAnimalCard(Map<String, dynamic> stray) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(12.0),
        leading: stray['image'] != null
            ? (stray['image'] is String
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(stray['image']), // For network images
                    radius: 30,
                  )
                : CircleAvatar(
                    backgroundImage:
                        FileImage(stray['image']), // For local images
                    radius: 30,
                  ))
            : Icon(Icons.pets, size: 40, color: Colors.teal),
        title: Text("Location: ${stray['location']}"),
        subtitle: Text("Posted by: ${stray['user']}"),
        trailing: Icon(Icons.info_outline),
        onTap: () => showDetailsDialog(stray),
      ),
    );
  }

  Future<void> pickStrayImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        strayImage = File(pickedFile.path);
      });
    }
  }

  void postStrayAnimal() async {
    if (locationController.text.isEmpty || nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add your name and location!")),
      );
      return;
    }

    setState(() {
      strayAnimals.add({
        'image': strayImage != null ? strayImage!.path : null,
        'location': locationController.text,
        'user': nameController.text,
      });
    });

    // Clear input fields and image
    strayImage = null;
    locationController.clear();
    nameController.clear();
  }

  void showDetailsDialog(Map<String, dynamic> stray) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Stray Animal Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            stray['image'] != null
                ? (stray['image'] is String
                    ? Image.network(stray['image'],
                        height: 150, width: 150, fit: BoxFit.cover)
                    : Image.file(File(stray['image'])))
                : Icon(Icons.pets, size: 50, color: Colors.teal),
            SizedBox(height: 10),
            Text("Location: ${stray['location']}"),
            SizedBox(height: 10),
            Text("Posted by: ${stray['user']}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
