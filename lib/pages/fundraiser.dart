import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FundraiserPage extends StatefulWidget {
  @override
  _FundraiserPageState createState() => _FundraiserPageState();
}

class _FundraiserPageState extends State<FundraiserPage> {
  // Preloaded dummy fundraisers
  List<Map<String, dynamic>> fundraisers = [
    {
      'name': 'Tommy',
      'description': 'Tommy needs surgery after a car accident.',
      'amount': '5000',
      'image': null, // Placeholder for no image
    },
    {
      'name': 'Bella',
      'description': 'Bella needs medication for chronic illness.',
      'amount': '8000',
      'image': null,
    },
    {
      'name': 'Rocky',
      'description': 'Rocky requires treatment for a fractured leg.',
      'amount': '3000',
      'image': null,
    },
  ];

  // Controllers for posting a new fundraiser
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountNeededController = TextEditingController();

  // Image for fundraiser
  File? fundraiserImage;

  // Donation amount controller
  final TextEditingController donationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fundraiser"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF76D6FF),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section to Post a New Fundraiser
            Text(
              "Post a Fundraiser",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF76D6FF)),
            ),
            SizedBox(height: 10),
            buildTextField("Pet Name", petNameController),
            buildTextField("Description", descriptionController, maxLines: 3),
            buildTextField(
              "Amount Needed (₹)",
              amountNeededController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => pickFundraiserImage(),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF76D6FF)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: fundraiserImage != null
                    ? Image.file(fundraiserImage!, fit: BoxFit.cover)
                    : Center(
                        child: Text(
                          "Tap to upload image",
                          style: TextStyle(color: Color(0xFF76D6FF)),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: postFundraiser,
              icon: Icon(Icons.add, color: Colors.white),
              label: Text("Post Fundraiser"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF76D6FF),
                  foregroundColor: Colors.white),
            ),

            SizedBox(height: 20),
            Divider(color: Color(0xFF76D6FF)),
            SizedBox(height: 20),

            // Section to View Available Fundraisers
            Text(
              "Available Fundraisers",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF76D6FF)),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: fundraisers.length,
              itemBuilder: (context, index) {
                final fundraiser = fundraisers[index];
                return buildFundraiserCard(fundraiser);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF76D6FF)),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF76D6FF)),
          ),
        ),
        cursorColor: Color(0xFF76D6FF),
      ),
    );
  }

  Widget buildFundraiserCard(Map<String, dynamic> fundraiser) {
    return GestureDetector(
      onTap: () => openDonationDialog(fundraiser),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4,
        child: ListTile(
          leading: fundraiser['image'] != null
              ? CircleAvatar(
                  backgroundImage: FileImage(fundraiser['image']),
                  radius: 25,
                )
              : CircleAvatar(
                  backgroundColor: Color(0xFF76D6FF),
                  child: Icon(Icons.pets, color: Colors.white),
                ),
          title: Text(
            fundraiser['name'],
            style: TextStyle(color: Color(0xFF76D6FF)),
          ),
          subtitle: Text("Amount Needed: ₹${fundraiser['amount']}",
              style: TextStyle(color: Color(0xFF76D6FF))),
          trailing: Icon(Icons.arrow_forward, color: Color(0xFF76D6FF)),
        ),
      ),
    );
  }

  Future<void> pickFundraiserImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        fundraiserImage = File(pickedFile.path);
      });
    }
  }

  void postFundraiser() {
    if (petNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        amountNeededController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please fill in all fields to post a fundraiser!")),
      );
      return;
    }

    setState(() {
      fundraisers.add({
        'name': petNameController.text,
        'description': descriptionController.text,
        'amount': amountNeededController.text,
        'image': fundraiserImage,
      });
    });

    // Clear input fields and image
    petNameController.clear();
    descriptionController.clear();
    amountNeededController.clear();
    fundraiserImage = null;
  }

  void openDonationDialog(Map<String, dynamic> fundraiser) {
    donationController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(fundraiser['name'],
              style: TextStyle(color: Color(0xFF76D6FF))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              fundraiser['image'] != null
                  ? Image.file(fundraiser['image'],
                      height: 150, fit: BoxFit.cover)
                  : Icon(Icons.pets, size: 100, color: Color(0xFF76D6FF)),
              SizedBox(height: 10),
              Text(fundraiser['description'],
                  style: TextStyle(color: Color(0xFF76D6FF))),
              SizedBox(height: 10),
              Text("Amount Needed: ₹${fundraiser['amount']}",
                  style: TextStyle(color: Color(0xFF76D6FF))),
              SizedBox(height: 10),
              TextField(
                controller: donationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter Donation Amount",
                  labelStyle: TextStyle(color: Color(0xFF76D6FF)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF76D6FF)),
                  ),
                ),
                cursorColor: Color(0xFF76D6FF),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Color(0xFF76D6FF))),
            ),
            ElevatedButton(
              onPressed: () {
                if (donationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a donation amount!")),
                  );
                  return;
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          "Payment Successful! Thank you for your donation.")),
                );
              },
              child: Text("Donate"),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF76D6FF)),
            ),
          ],
        );
      },
    );
  }
}
