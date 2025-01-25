import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: AnimalAdoptionApp(),
  ));
}

class AnimalAdoptionApp extends StatefulWidget {
  @override
  _AnimalAdoptionAppState createState() => _AnimalAdoptionAppState();
}

class _AnimalAdoptionAppState extends State<AnimalAdoptionApp> {
  final List<Map<String, String>> animals = [
    {
      'name': 'Bella',
      'image': 'lib/assets/bordercollie.jpg',
      'description': 'Bella is a friendly and energetic dog who loves to play!',
      'address': '123 Pet Lane, Dogtown',
      'phone': '123-456-7890',
      'vaccination': 'Fully vaccinated',
      'adoption': 'Free',
    },
    {
      'name': 'Luna',
      'image': 'lib/assets/orangecat.jpg',
      'description':
          'Luna is a calm and loving cat, perfect for relaxing evenings.',
      'address': '456 Cat Street, Meow City',
      'phone': '987-654-3210',
      'vaccination': 'Fully vaccinated',
      'adoption': 'Paid-5000',
    },
    {
      'name': 'Max',
      'image': 'lib/assets/puppy.jpg',
      'description':
          'Max is a playful puppy who loves to explore the outdoors.',
      'address': '789 Puppy Road, Barksville',
      'phone': '555-123-4567',
      'vaccination': 'Pending',
      'adoption': 'Paid-8000',
    },
    {
      'name': 'Charlie',
      'image': 'lib/assets/rabbit.jpg',
      'description':
          'Charlie is a mischievous rabbit who loves carrots and hopping around!',
      'address': '321 Rabbit Avenue, Hopville',
      'phone': '222-333-4444',
      'vaccination': 'Not applicable',
      'adoption': 'Free',
    },
  ];

  void addAnimal(Map<String, String> newAnimal) {
    setState(() {
      animals.add(newAnimal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            Color(0xFFF8C8D8), // Light pastel pink background color
        appBar: AppBar(
          title: Text('Animal Adoption'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Adopt'),
              Tab(text: 'For Adoption'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AnimalAdoptionScreen(animals: animals),
            ForAdoptionScreen(onSubmit: addAnimal),
          ],
        ),
      ),
    );
  }
}

class AnimalAdoptionScreen extends StatelessWidget {
  final List<Map<String, String>> animals;

  AnimalAdoptionScreen({required this.animals});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: animals.map((animal) {
          return AnimalCard(
            name: animal['name']!,
            image: animal['image']!,
            description: animal['description']!,
            address: animal['address']!,
            phone: animal['phone']!,
            vaccination: animal['vaccination']!,
            adoption: animal['adoption']!,
          );
        }).toList(),
      ),
    );
  }
}

class AnimalCard extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final String address;
  final String phone;
  final String vaccination;
  final String adoption;

  AnimalCard({
    required this.name,
    required this.image,
    required this.description,
    required this.address,
    required this.phone,
    required this.vaccination,
    required this.adoption,
  });

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalDetailScreen(
                      name: widget.name,
                      image: widget.image,
                      description: widget.description,
                      address: widget.address,
                      phone: widget.phone,
                      vaccination: widget.vaccination,
                      adoption: widget.adoption,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.asset(
                      widget.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isHovered)
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Adopt Me',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Vaccination Status: ${widget.vaccination}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Adoption Status: ${widget.adoption}',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          widget.adoption == 'Free' ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String address;
  final String phone;
  final String vaccination;
  final String adoption;

  AnimalDetailScreen({
    required this.name,
    required this.image,
    required this.description,
    required this.address,
    required this.phone,
    required this.vaccination,
    required this.adoption,
  });

  void _showAdoptionConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adoption Confirmed'),
          content:
              Text('Thank you for adopting $name! We will contact you soon.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pop(); // Close the detail screen after confirmation
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(phone, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(
              'Vaccination Status: $vaccination',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Adoption Status: $adoption',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: adoption == 'Free' ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showAdoptionConfirmation(context),
              child: Text('Adopt Now'),
            ),
          ],
        ),
      ),
    );
  }
}

class ForAdoptionScreen extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;

  ForAdoptionScreen({required this.onSubmit});

  @override
  _ForAdoptionScreenState createState() => _ForAdoptionScreenState();
}

class _ForAdoptionScreenState extends State<ForAdoptionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _animalType = '';
  String _animalName = '';
  String _address = '';
  String _phone = '';
  String _description = '';
  String _vaccination = '';
  String _adoption = 'Free';
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newAnimal = {
        'name': _animalName,
        'image': _image?.path ?? '',
        'description': _description,
        'address': _address,
        'phone': _phone,
        'vaccination': _vaccination,
        'adoption': _adoption,
      };

      widget.onSubmit(newAnimal);

      setState(() {
        _animalType = '';
        _animalName = '';
        _address = '';
        _phone = '';
        _description = '';
        _vaccination = '';
        _adoption = 'Free';
        _image = null;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Animal added successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Animal Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the animal\'s name';
                }
                return null;
              },
              onSaved: (value) {
                _animalName = value!;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Animal Description'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an address';
                }
                return null;
              },
              onSaved: (value) {
                _address = value!;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
              onSaved: (value) {
                _phone = value!;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Vaccination Status'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter vaccination details';
                }
                return null;
              },
              onSaved: (value) {
                _vaccination = value!;
              },
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _image == null
                    ? Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _adoption,
              decoration: InputDecoration(labelText: 'Adoption Status'),
              items: ['Free', 'Paid'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _adoption = newValue!;
                });
              },
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
