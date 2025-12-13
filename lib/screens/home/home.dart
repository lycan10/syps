import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sips/screens/question_page/question_page.dart';
import '../../components/ad_banner.dart';
import '../../theme/theme.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final categories = [
      {
        "title": "Dirty",
        "color": ThemeClass.dirtyColor,
        "emoji": "🍑",
        "tagline": "Flirty, bold, and a little wild."
      },
      {
        "title": "Icebreaker",
        "color": ThemeClass.icebreakerColor,
        "emoji": "❄️",
        "tagline": "Get talking, get laughing, get sippin’."
      },
      {
        "title": "Ladies’ Night",
        "color": ThemeClass.ladiesNightColor,
        "emoji": "💅",
        "tagline": "Spill the tea. Rule the night."
      },
      {
        "title": "Boys Being Boys",
        "color": ThemeClass.boysColor,
        "emoji": "🍻",
        "tagline": "No rules. Just vibes and chaos."
      },
      {
        "title": "Love Affair",
        "color": ThemeClass.loveAffairColor,
        "emoji": "❤️",
        "tagline": "For couples who dare."
      },
    ];

    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Choose Your Vibe",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ThemeClass.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the Questions Page with the selected category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionsPage(
                            category: cat["title"].toString(), // you can pass real player list here
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: (cat["color"] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: cat["color"] as Color,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                        child: Row(
                          children: [
                            // Emoji Icon
                            Text(
                              cat["emoji"].toString(),
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(width: 18),

                            // Category Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cat["title"].toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: cat["color"] as Color,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    cat["tagline"].toString(),
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: ThemeClass.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Arrow Icon
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: cat["color"] as Color,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const AdBanner(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
