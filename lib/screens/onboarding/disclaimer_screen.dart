import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sips/screens/onboarding/welcome_page.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  void _exitApp() {
    exit(0); // Works on Android, exits on iOS (Apple allows splash exits)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Disclaimer & Age Verification'),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),

        child: Column(
          children: [
            const Icon(Icons.warning_amber_rounded, size: 64),
            const SizedBox(height: 20),

            Text(
              '''
This application is intended for entertainment purposes only.

The app does not promote or encourage unsafe behavior. Please play responsibly.

By continuing, you acknowledge that you have read and agree to this disclaimer.
              ''',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            const Text(
              'You must be 21 years or older to use this app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 22),

            const Text(
              'Are you 21 years of age or older?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WelcomePage(),
                        ),
                      );
                    },
                    child: const Text('Yes'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _exitApp,
                    child: const Text('No'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
