<<<<<<< HEAD
import 'package:CODE_HERS/pages/fundraiser.dart';
import 'package:CODE_HERS/pages/home_page.dart';
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:pet_haven/pages/home_page.dart';
>>>>>>> 81b1ac95a9117d92a77faa06b244c0b3801e2abc

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get set => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      title: 'pet_heven',
      
=======
      title: 'Activity Point Tracker',

>>>>>>> 7d6f33dd8f496ad81d51425374b37145908fa7a2
      initialRoute: '/', // Set the initial route to login page
      routes: {
        '/': (context) => DashboardPage(), // Login page route
        '/home': (context) => const DashboardPage(), // Home page route
        // '/register': (context) => const SignUpPage(), // Sign-up page route
        // '/upload': (context) =>   UploadCertificatePage(), // Upload certificate page route
<<<<<<< HEAD
        '/FundraiserPage': (context) => FundraiserPage(),
=======
        //'/certificate_list': (context) =>const CertificateListPage(tkmId: 220995),// Proper initialization for certificate list
>>>>>>> 81b1ac95a9117d92a77faa06b244c0b3801e2abc
        // '/tracked_activities': (context) =>  ActivityListPage(), // Activity list page route
        // '/edit_profile':(content)=>UserProfilePage(firstName: 'Julia', lastName: 'Smith', registerNo: '220995', email: 'sadhavpooja@gmail.com', rollNo: '59', year: '2nd',),
        //'/Settings':(content)=>const SettingPage(),
      },
    );
  }
}
