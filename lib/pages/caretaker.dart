// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CaretakerScreen extends StatefulWidget {
//   @override
//   _CaretakerScreenState createState() => _CaretakerScreenState();
// }

// class _CaretakerScreenState extends State<CaretakerScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _petNameController = TextEditingController();
//   final TextEditingController _ownerNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _petTypeController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   File? _petImage;

//   DateTime? _startDate;
//   DateTime? _endDate;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickPetImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _petImage = File(pickedFile.path);
//       });
//     }
//   }

//   void _selectDateRange(BuildContext context) async {
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//       initialDateRange: _startDate != null && _endDate != null
//           ? DateTimeRange(start: _startDate!, end: _endDate!)
//           : null,
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: Colors.pink[900],
//             colorScheme: ColorScheme.light(
//               primary: Colors.pink[900]!,
//               onPrimary: Colors.white,
//               surface: Colors.pink[50]!,
//               onSurface: Colors.pink[700]!,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.pink[900],
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null) {
//       setState(() {
//         _startDate = picked.start;
//         _endDate = picked.end;
//       });
//     }
//   }

//   void _submitRequest() {
//     if (_formKey.currentState!.validate()) {
//       if (_petImage == null) {
//         _showErrorDialog('Please upload an image of your pet.');
//       } else {
//         _showAvailableCaretakers();
//       }
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showAvailableCaretakers() {
//     final List<Map<String, String>> caretakers = [
//       {'name': 'John Doe', 'experience': '5 years', 'rating': '4.8/5'},
//       {'name': 'Jane Smith', 'experience': '3 years', 'rating': '4.5/5'},
//       {'name': 'Emily Davis', 'experience': '7 years', 'rating': '4.9/5'},
//     ];

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Available Caretakers'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: caretakers.map((caretaker) {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.pink[100],
//                   child: Icon(Icons.person, color: Colors.pink[900]),
//                 ),
//                 title: Text(caretaker['name']!),
//                 subtitle: Text(
//                     'Experience: ${caretaker['experience']}\nRating: ${caretaker['rating']}'),
//               );
//             }).toList(),
//           ),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 16, left: 20),
//               child: Text(
//                 'FetchMate',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.pink[900],
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             SizedBox(height: 16),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.pink[50],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 'FetchMate connects pet owners with trusted caregivers for reliable, short-term pet care.',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//             SizedBox(height: 16),
//             Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextFormField(
//                     controller: _petTypeController,
//                     decoration: InputDecoration(
//                       labelText: 'Pet Type',
//                       labelStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[900],
//                       ),
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your pet\'s type';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _petNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Pet Name',
//                       labelStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[900],
//                       ),
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your pet\'s name';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _ownerNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Your Name',
//                       labelStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[900],
//                       ),
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       labelText: 'Phone Number',
//                       labelStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[900],
//                       ),
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your phone number';
//                       }
//                       if (!RegExp(r'^\d{10}\$').hasMatch(value)) {
//                         return 'Please enter a valid 10-digit phone number';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _addressController,
//                     decoration: InputDecoration(
//                       labelText: 'Address',
//                       labelStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[900],
//                       ),
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: 3,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your address';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   OutlinedButton(
//                     onPressed: () => _selectDateRange(context),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.pink[900],
//                       side: BorderSide(color: Colors.pink[900]!),
//                     ),
//                     child: Text(
//                       _startDate == null || _endDate == null
//                           ? 'Select Care Duration'
//                           : '${_startDate!.toLocal()}'.split(' ')[0] +
//                               ' to ' +
//                               '${_endDate!.toLocal()}'.split(' ')[0],
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[900],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(
//                       labelText: 'Special Care Instructions',
//                       labelStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink[900],
//                       ),
//                       border: OutlineInputBorder(),
//                       hintText: 'Dietary needs, medications, etc.',
//                     ),
//                     maxLines: 3,
//                   ),
//                   SizedBox(height: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Upload Pet Image:',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.pink[900],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       _petImage == null
//                           ? Text(
//                               'No image selected.',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           : Container(
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 4,
//                                     offset: Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.file(
//                                       _petImage!,
//                                       width: double.infinity,
//                                       height: 250,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     'Pet Name: ${_petNameController.text}',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     _descriptionController.text.isNotEmpty
//                                         ? _descriptionController.text
//                                         : 'No description provided.',
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                       SizedBox(height: 10),
//                       ElevatedButton.icon(
//                         onPressed: _pickPetImage,
//                         icon: Icon(
//                           Icons.upload,
//                           color: Colors.white,
//                         ),
//                         label: Text('Upload Image'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.pink[900],
//                           foregroundColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: _submitRequest,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink[900],
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: Text(
//                       'Find a Pet Caretaker',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _petNameController.dispose();
//     _ownerNameController.dispose();
//     _descriptionController.dispose();
//     _petTypeController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(CaretakerScreen());
}

class CaretakerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FetchMate',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _posts = [
    {
      'petName': 'Buddy',
      'petType': 'Dog',
      'ownerName': 'Alice',
      'phone': '9876543210',
      'address': '123 Main Street',
      'description': 'Loves treats and walks. No special care needed.',
      'startDate': DateTime.now(),
      'endDate': DateTime.now().add(Duration(days: 7)),
      'image': null,
    },
    {
      'petName': 'Mittens',
      'petType': 'Cat',
      'ownerName': 'Bob',
      'phone': '9876541230',
      'address': '456 Elm Street',
      'description': 'Needs daily grooming and playtime.',
      'startDate': DateTime.now(),
      'endDate': DateTime.now().add(Duration(days: 10)),
      'image': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addPost(Map<String, dynamic> post) {
    setState(() {
      _posts.add(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FetchMate', style: TextStyle(color: Colors.pink[500])),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Posts'),
            Tab(text: 'Fetch'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PostsScreen(onPostSubmit: _addPost, posts: _posts),
          FetchScreen(),
        ],
      ),
    );
  }
}

class PostsScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onPostSubmit;
  final List<Map<String, dynamic>> posts;

  PostsScreen({required this.onPostSubmit, required this.posts});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petTypeController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _petImage;

  DateTime? _startDate;
  DateTime? _endDate;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickPetImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _petImage = File(pickedFile.path);
      });
    }
  }

  void _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      widget.onPostSubmit({
        'petName': _petNameController.text,
        'petType': _petTypeController.text,
        'ownerName': _ownerNameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'description': _descriptionController.text,
        'startDate': _startDate,
        'endDate': _endDate,
        'image': _petImage,
      });
      _formKey.currentState!.reset();
      setState(() {
        _petImage = null;
        _startDate = null;
        _endDate = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _petTypeController,
                  decoration: InputDecoration(
                    labelText: 'Pet Type',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink[500]!),
                    ),
                  ),
                  style: TextStyle(color: Colors.pink[500]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pet\'s type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _petNameController,
                  decoration: InputDecoration(
                    labelText: 'Pet Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink[500]!),
                    ),
                  ),
                  style: TextStyle(color: Colors.pink[500]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pet\'s name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _ownerNameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink[500]!),
                    ),
                  ),
                  style: TextStyle(color: Colors.pink[500]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink[500]!),
                    ),
                  ),
                  style: TextStyle(color: Colors.pink[500]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink[500]!),
                    ),
                  ),
                  maxLines: 2,
                  style: TextStyle(color: Colors.pink[500]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => _selectDateRange(context),
                  child: Text(
                    _startDate == null || _endDate == null
                        ? 'Select Care Duration'
                        : '${_startDate!.toLocal()}'.split(' ')[0] +
                            ' to ' +
                            '${_endDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(color: Colors.pink[500]),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.pink[500]!),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Special Care Instructions',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink[500]!),
                    ),
                  ),
                  maxLines: 3,
                  style: TextStyle(color: Colors.pink[500]),
                ),
                SizedBox(height: 16),
                _petImage == null
                    ? Text('No image selected.',
                        style: TextStyle(color: Colors.pink[500]))
                    : Image.file(
                        _petImage!,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickPetImage,
                  icon: Icon(Icons.upload, color: Colors.pink[500]),
                  label: Text('Upload Image',
                      style: TextStyle(color: Colors.pink[500])),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.pink[500]!),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitPost,
                  child: Text('Submit Post',
                      style: TextStyle(color: Colors.pink[500])),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.pink[500]!),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Existing Posts:',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink[500]),
          ),
          ...widget.posts.map((post) => Card(
                margin: EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: post['image'] != null
                      ? Image.file(
                          post['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.pets, size: 50, color: Colors.pink[900]),
                  title: Text(post['petName'],
                      style: TextStyle(color: Colors.black)),
                  subtitle: Text(post['description'],
                      style: TextStyle(color: Colors.black)),
                ),
              )),
        ],
      ),
    );
  }
}

class FetchScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _sheltersAndCaretakers = [
    {
      'name': 'Happy Tails Shelter',
      'type': 'Animal Shelter',
      'address': '789 Oak Avenue',
      'phone': '9123456780',
      'description': 'Providing care for abandoned pets.',
      'image': null,
    },
    {
      'name': 'Loving Paws Caretaker',
      'type': 'Caretaker',
      'address': '321 Pine Street',
      'phone': '9988776655',
      'description': 'Experienced in caring for dogs and cats.',
      'image': null,
    },
    {
      'name': 'Furry Friends Home',
      'type': 'Animal Shelter',
      'address': '654 Willow Lane',
      'phone': '9876543210',
      'description': 'A safe place for pets in need.',
      'image': null,
    },
    {
      'name': 'Pet Paradise Caretaker',
      'type': 'Caretaker',
      'address': '123 Maple Boulevard',
      'phone': '9012345678',
      'description': 'Loving care for pets while you are away.',
      'image': null,
    },
  ];

  void _showBookingDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to book this caretaker/shelter?'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // No action happens when "Book Now" is pressed
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking action ignored for $name!')),
                );
              },
              child: Text('Book Now'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[500]),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // No action happens when "Cancel" is pressed
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Available Shelters and Caretakers:',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 16),
          ..._sheltersAndCaretakers.map((entity) => Card(
                margin: EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: entity['image'] != null
                      ? Image.file(
                          entity['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          entity['type'] == 'Animal Shelter'
                              ? Icons.home
                              : Icons.person,
                          size: 50,
                          color: Colors.pink[900],
                        ),
                  title: Text(entity['name'],
                      style: TextStyle(color: Colors.black)),
                  subtitle: Text(entity['description'],
                      style: TextStyle(color: Colors.black)),
                  trailing: Text(entity['type'],
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    _showBookingDialog(context, entity['name']);
                  },
                ),
              )),
        ],
  ),
  );
  }
}
