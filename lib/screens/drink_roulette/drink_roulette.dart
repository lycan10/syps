import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../components/ad_banner.dart';
import '../../service/ad_service.dart';
import '../../service/app_provider.dart';
import '../../theme/theme.dart';

class DrinkRoulettePage extends StatefulWidget {

  final Color color;

  const DrinkRoulettePage({super.key, required this.color});


  @override
  State<DrinkRoulettePage> createState() => _DrinkRoulettePageState();
}

class _DrinkRoulettePageState extends State<DrinkRoulettePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  final Random _random = Random();

  String _selectedPlayer = "Tap spin to find out! 🍸";
  bool _isSpinning = false;

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _canSpinAgain = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        setState(() {
          _isSpinning = false;
          _canSpinAgain = true; // Allow spin again after spin completes
        });
      }
    });

    _loadInterstitialAd();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    AdService().loadRewardedAd(
      onAdLoaded: (ad) {
        _rewardedAd = ad;
      },
      onAdFailedToLoad: (error) {
        debugPrint('RewardedAd failed to load: $error');
      },
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        // User earned reward: Spin again!
        _spinRoulette();
        // Load next rewarded ad
        _loadRewardedAd();
      });
      _rewardedAd = null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ad not ready yet. Try again in a moment!")),
      );
      _loadRewardedAd(); // Try loading again if it wasn't ready
    }
  }

  void _loadInterstitialAd() {
    AdService().loadInterstitial(
      onAdLoaded: (ad) {
        _interstitialAd = ad;
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _proceedWithNavigation();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            _proceedWithNavigation();
          },
        );
      },
      onAdFailedToLoad: (error) {
        debugPrint('InterstitialAd failed to load: $error');
      },
    );
  }

  void _proceedWithNavigation() {
    final players =
    Provider.of<AppProvider>(context, listen: false).players;

    if (players.isNotEmpty) {
      final random = players[_random.nextInt(players.length)];
      Navigator.pop(context, random);
    } else {
      Navigator.pop(context, "No players yet 😅");
    }
  }

  void _spinRoulette() {
    final players = Provider.of<AppProvider>(context, listen: false).players;

    if (players.isEmpty) {
      setState(() {
        _selectedPlayer = "Add players first 🍹";
      });
      return;
    }

    setState(() {
      _isSpinning = true;
      _selectedPlayer = "Spinning...";
      _canSpinAgain = false;
    });

    _controller.repeat(); // start spinning continuously

    Future.delayed(const Duration(seconds: 3), () {
      _controller.stop(canceled: false); // stop spinning

      final bool isGroup = _random.nextInt(100) < 20; // 20% group chance
      String selected;

      if (isGroup) {
        selected = "Everyone 🍻";
      } else {
        selected = players[_random.nextInt(players.length)];
      }

      setState(() {
        _selectedPlayer = selected;
        _isSpinning = false;
      });
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color;

    return Scaffold(
      backgroundColor: Color.alphaBlend(Colors.black.withValues(alpha: 0.9), color),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                "Drink Roulette 🎯",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 60),

              // Spinning Wheel
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _rotation,
                    builder: (context, child) {
                      // Rotate the shadow slightly relative to the wheel rotation
                      final double shadowOffset = 6 + 4 * sin(_rotation.value * 3); // oscillates between 2-10 px
                      final double shadowBlur = 12 + 4 * cos(_rotation.value * 2);  // oscillates blur

                      return Transform.rotate(
                        angle: _rotation.value,
                        child: Container(
                          height: 220,
                          width: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: color, width: 6),
                            gradient: RadialGradient(
                              colors: [
                                color.withValues(alpha: 0.3),
                                color.withValues(alpha: 0.05)
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.3),
                                blurRadius: shadowBlur,
                                offset: Offset(0, shadowOffset),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "🍸",
                              style: TextStyle(
                                fontSize: 64,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                ),
              ),

              const SizedBox(height: 40),

              // Selected Player
              Text(
                _selectedPlayer,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: ThemeClass.whiteColor,
                ),
              ),

              const SizedBox(height: 50),

              // Spin Button
              ElevatedButton(
                onPressed: _isSpinning
                    ? null
                    : () {
                  if (_selectedPlayer == "Tap spin to find out! 🍸" ||
                      _selectedPlayer == "Spinning..." ||
                      _selectedPlayer == "Add players first 🍹") {
                    // Still in spin state → start spinning
                    _spinRoulette();
                  } else {
                    if (_interstitialAd != null) {
                      _interstitialAd!.show();
                      _interstitialAd = null; // Clear reference
                    } else {
                      _proceedWithNavigation();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                ),
                child: Text(
                  _isSpinning
                      ? ""
                      : (_selectedPlayer == "Tap spin to find out! 🍸" ||
                      _selectedPlayer == "Spinning..." ||
                      _selectedPlayer == "Add players first 🍹")
                      ? "SPIN 🍹"
                      : "NEXT 👉",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              if (_canSpinAgain && _selectedPlayer != "Tap spin to find out! 🍸") ...[
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: _showRewardedAd,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: Text(
                    "Spin Again (Watch Ad)",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],



              const SizedBox(height: 20),
              const AdBanner(),
            ],
          ),
        ),
      ),
    );
  }
}
