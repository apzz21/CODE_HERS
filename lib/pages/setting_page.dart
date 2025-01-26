import 'package:flutter/material.dart';

// The SettingPage widget itself
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _MySettingPage();
}

class _MySettingPage extends State<SettingPage> {
  // Initial theme mode (light or dark)
  ThemeMode _themeMode = ThemeMode.light;

  // Whether notifications are enabled or not
  bool _notificationsEnabled = true;

  final List<Color> gradientColors = [
    const Color.fromARGB(255, 141, 204, 238),
    const Color.fromARGB(255, 238, 174, 206),
    const Color.fromARGB(255, 236, 118, 175),
    const Color.fromARGB(255, 224, 162, 243),
    const Color.fromARGB(255, 227, 162, 192),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientColors[0],
              gradientColors[1],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Even smaller title font size
                ),
              ),
              // Notification Setting
              SwitchListTile(
                title: const Text("Enable Notifications"),
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: gradientColors[2], // Change color when activated
                inactiveTrackColor: gradientColors[1], // Change inactive color
              ),
              const Divider(
                color: Color.fromARGB(255, 200, 225, 251),
              ),
              // Theme Switcher (Light/Dark Mode)
              ListTile(
                title: const Text("Theme Mode"),
                trailing: Switch(
                  value: _themeMode == ThemeMode.dark,
                  onChanged: (bool value) {
                    setState(() {
                      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                    });
                  },
                  activeColor: gradientColors[2], // Change color when activated
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 200, 225, 251),
              ),
              // Privacy Policy Link
              ListTile(
                title: const Text("Privacy Policy"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  // Privacy Policy Page (unchanged)
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 141, 204, 238),
              const Color.fromARGB(255, 238, 174, 206),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "This is the privacy policy page. Here you can describe the privacy practices of your app. "
                  "You can add more text, links, and other content related to your privacy policy here.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 550),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
