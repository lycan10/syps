import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sips/screens/onboarding/participants.dart';
import '../../theme/theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App Logo or Name
              Column(
                children: [
                  Text(
                    "🍸 Sips",
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      color: ThemeClass.dirtyColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Your night just got a lot more interesting.",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: ThemeClass.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // Fun illustration or bottle graphic (you can replace this with an asset)
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/images/welcome3.png",
                    height: 175,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Welcome Text
              Column(
                children: [
                  Text(
                    "Welcome to Sips!",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: ThemeClass.blackColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Choose your vibe, gather your crew, and let the fun begin. "
                        "Remember — play bold, laugh loud, and sip responsibly. 🍹",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: ThemeClass.textColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Start Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeClass.dirtyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const ParticipantInputPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.scaled, // options: horizontal, vertical, scaled
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Let’s Get Sippin’ 🍻",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ThemeClass.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
