import 'package:CODE_HERS/pages/fundraiser.dart';
import 'package:CODE_HERS/pages/home_page.dart';
import 'package:flutter/material.dart';

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
      title: 'Activity Point Tracker',

      initialRoute: '/', // Set the initial route to login page
      routes: {
        '/': (context) => DashboardPage(), // Login page route
        '/home': (context) => const DashboardPage(), // Home page route
        // '/register': (context) => const SignUpPage(), // Sign-up page route
        // '/upload': (context) =>   UploadCertificatePage(), // Upload certificate page route
        '/FundraiserPage': (context) => FundraiserPage(),
        // '/tracked_activities': (context) =>  ActivityListPage(), // Activity list page route
        // '/edit_profile':(content)=>UserProfilePage(firstName: 'Julia', lastName: 'Smith', registerNo: '220995', email: 'sadhavpooja@gmail.com', rollNo: '59', year: '2nd',),
        //'/Settings':(content)=>const SettingPage(),
      },
    );
  }
}
