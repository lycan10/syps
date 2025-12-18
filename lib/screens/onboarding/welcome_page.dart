import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sips/screens/onboarding/participants.dart';
import '../../service/ad_service.dart';
import '../../theme/theme.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    setState(() {
      _isAdLoading = true;
    });

    AdService().loadInterstitial(
      onAdLoaded: (ad) {
        _interstitialAd = ad;
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _navigateToParticipants();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            debugPrint('Interstitial ad failed to show: $error');
            _navigateToParticipants();
          },
        );
        setState(() {
          _isAdLoading = false;
        });
      },
      onAdFailedToLoad: (error) {
        debugPrint('InterstitialAd failed to load: $error');
        setState(() {
          _isAdLoading = false;
        });
      },
    );
  }

  void _navigateToParticipants() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                const ParticipantInputPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
      ),
    );
  }

  void _handleGetStarted() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    }
    _navigateToParticipants();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

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

              // Fun illustration or bottle graphic
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
                  onPressed: _handleGetStarted,
                  child: Text(
                    "Let's Get Sippin' 🍻",
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
