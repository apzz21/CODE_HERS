import 'package:flutter/material.dart';
import 'package:pet_haven/pages/home_page.dart';
import 'package:pet_haven/pages/login_page.dart';
import 'package:pet_haven/pages/user_settings_page.dart';

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
      title: 'pet_heven',

      initialRoute: '/', // Set the initial route to login page
      routes: {
        '/': (context) => LoginPage (), // Login page route
        '/home': (context) => const DashboardPage(), // Home page route
       '/userspage': (context) =>UserSettingsPage(), // Sign-up page route
        // '/upload': (context) =>   UploadCertificatePage(), // Upload certificate page route
        //'/certificate_list': (context) =>const CertificateListPage(tkmId: 220995),// Proper initialization for certificate list
        // '/tracked_activities': (context) =>  ActivityListPage(), // Activity list page route
        // '/edit_profile':(content)=>UserProfilePage(firstName: 'Julia', lastName: 'Smith', registerNo: '220995', email: 'sadhavpooja@gmail.com', rollNo: '59', year: '2nd',),
        //'/Settings':(content)=>const SettingPage(),
      },
    );
  }
}

