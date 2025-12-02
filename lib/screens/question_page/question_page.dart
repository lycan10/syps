import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../service/app_provider.dart';
import '../../theme/theme.dart';
import '../drink_roulette/drink_roulette.dart';

class QuestionsPage extends StatefulWidget {
  final String category;

  const QuestionsPage({super.key, required this.category});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late List<String> _questions;
  late List<String> _groupQuestions;
  int _currentIndex = 0;
  String _displayedPlayer = "";
  final Random _random = Random();
  bool _firstQuestion = true;

  @override
  void initState() {
    super.initState();
    _questions = _getQuestionsForCategory(widget.category);
    _groupQuestions = _getGroupQuestions();

    // Show the first question WITHOUT triggering roulette
    _setNextQuestion(first: true);
  }

  /// Individual questions for each category
  List<String> _getQuestionsForCategory(String category) {
    switch (category) {
      case "Dirty":
        return [
    "What's the hottest place on your body that you'd like me to lick?",
    "What's the naughtiest thing you've ever done?",
    "What's the most embarrassing thing that's happened to you while having sex?",
    "What's the kinkiest thing you've ever tried?",
    "What's your favorite sex position?",
    "What's the most erotic thing someone has ever said to you?",
    "What's the naughtiest thing you've ever done with a partner?",
    "What's the most erotic thing you've ever seen?",
    "What's the hottest thing you've ever done with a partner?",
    "What's the naughtiest place you've ever had sex?",
    "What's the most embarrassing thing that's happened to you during sex?",
    "What's the kinkiest thing you've ever wanted to try?",
    "What's the most erotic thing you've ever heard?",
    "What's the naughtiest thing you've ever done alone?",
    "What's the hottest thing you've ever imagined?",
    "What's the most embarrassing thing you've ever done during sex?",
    "What's the kinkiest thing you've ever done with a partner?",
    "What's the most erotic thing you've ever seen?",
    "What's the naughtiest thing you've ever wanted to do?",
    "What's the most embarrassing thing that's happened to you while having sex?",
          "Never have I ever...licked someone's toes during sex.",
          "Never have I ever...had a threesome.",
          "Never have I ever...tried anal sex.",
          "Never have I ever...used a sex toy.",
          "Never have I ever...gone to a sex shop.",
          "Never have I ever...had a one-night stand.",
          "Never have I ever...had a threesome.",
          "Never have I ever...had a threesome with a couple.",
          "Never have I ever...used a vibrator.",
          "What's the sexiest piece of clothing you own and why?",
          "Describe your ideal foreplay in detail.",
          "What's a sound you or your partner makes during sex that really turns you on?",
          "If you could have sex anywhere in the world, where would it be?",
          "What's the most adventurous thing you've ever tried in the bedroom?",
          "What's the most erotic movie or scene you've ever watched?",
          "What's a body part you find incredibly attractive that isn't typically focused on?",
          "What's a fantasy you haven't shared with anyone yet?",
          "What's your favorite non-sexual touch that makes you feel sexy or desired?",
          "What's the dirtiest thing you've ever whispered to a partner?",
          "What scent or smell instantly puts you in the mood?",
          "How do you like to be teased?",
          "What's one thing your partner (or a future partner) could do to completely surprise and excite you sexually?",
          "Never have I ever...gone to a strip club.",
          "Never have I ever...had a threesome with a stranger.",
          "Never have I ever...had a threesome with a partner's ex.",
          "Never have I ever...had a threesome with a group of people.",
          "Never have I ever...had a threesome with a celebrity.",
          "Never have I ever...had a threesome with a coworker.",
          "Never have I ever...had a threesome with a friend."
        ];
      case "Icebreaker":
        return [
          "Tell your most embarrassing story or take 2 sips.",
          "What’s something people always get wrong about you?",
          "What’s your go-to karaoke song — sing a line or drink.",
          "If you could trade lives with anyone for a day, who would it be?",
          "Compliment the person next to you or sip once.",
          "What’s one thing on your bucket list you haven’t done yet?",
          "What’s a random fun fact about you?",
          "Who was your childhood celebrity crush?",
          "What’s your guilty pleasure song?",
          "If you could have dinner with any celebrity, who would you choose?",
          "Describe your mood right now with a movie title.",
          "What’s a weird or hidden talent you have?",
          "If your life had a theme song, what would it be?",
          "What’s one word your best friend would use to describe you?",
          "What’s a hobby you’ve always wanted to try?",
          "What’s the funniest thing that ever happened to you while drunk?",
          "What’s a nickname you’ve had — and why?",
          "If you were a drink, what would you be called?",
          "What food could you eat every single day?",
          "If you had to live in another decade, which one would you pick?",
          "What’s the most random skill you have?",
          "If you could teleport anywhere right now, where would you go?",
          "What’s the strangest compliment you’ve ever gotten?",
          "What’s something you’ve done that you’re secretly proud of?",
          "What’s your go-to comfort movie or show?",
          "What’s one thing you’d tell your younger self?",
          "If you could instantly master one language, which would it be?",
          "What’s a bad habit you can’t seem to break?",
          "What’s your signature drink order?",
          "What’s the last thing that made you laugh way too hard?",
          "What’s the weirdest thing in your search history?",
          "What’s your current obsession (show, food, app, etc.)?",
          "If you could relive one day from your past, what would it be?",
          "What’s a song that instantly boosts your mood?",
          "What’s something you’ve done that felt completely out of character?",
          "What’s your favorite way to spend a lazy day?",
          "If you had to give a TED Talk, what would your topic be?",
          "What’s something you’re really good at that people don’t know?",
          "What’s the boldest thing you’ve ever done on impulse?",
          "What’s a small thing that instantly makes your day better?",
          "What’s your love language?",
          "What’s one thing that instantly gives you the ick?",
          "If you could get a one-time free luxury purchase, what would it be?",
          "What’s one thing you’ve always wanted to learn but haven’t yet?",
          "Describe yourself in three emojis.",
          "What’s your biggest irrational fear?",
          "What’s one memory that always makes you smile?",
          "What’s a goal you’re secretly working toward?",
          "What’s a phrase or quote you live by?",
          "What’s one thing people would never guess about you?",
          "What’s something you do that instantly makes you feel confident?",
        ];

      case "Ladies’ Night":
        return [
          "Rate your last date from 1–10 and tell us why.",
          "Show your most recent selfie or take 2 sips.",
          "Describe your type in three words.",
          "What’s your biggest dating red flag?",
          "What’s the most extra thing you’ve ever done for love?",
          "Share a secret about your crush or drink twice.",
          "What’s your go-to move when you’re flirting?",
          "Who was your first serious crush?",
          "What’s one thing you’d never admit on a first date?",
          "What’s a text you regret sending?",
          "If your ex had to describe you in one word, what would it be?",
          "What’s your signature outfit when you want to feel unstoppable?",
          "Who’s most likely to get the most attention when you all go out?",
          "What’s the most ridiculous lie you’ve ever told to get out of something?",
          "What’s your most iconic girls’ night memory?",
          "What’s something you’ve done that your friends would be shocked to hear?",
          "Who in your contacts could ruin your life if they leaked your texts?",
          "What’s your current obsession — a person, show, or trend?",
          "What’s your go-to drink on a night out?",
          "What’s one thing you’ll *never* do again after that one time?",
          "If you could swap wardrobes with one celebrity, who would it be?",
          "What’s one thing you always overthink?",
          "What’s your biggest ‘delulu’ fantasy right now?",
          "Who’s the biggest drama magnet among your friends?",
          "What’s your biggest ick when it comes to dating?",
          "What’s the worst or funniest DM you’ve ever received?",
          "What’s something you’ve done out of pure pettiness?",
          "If your love life were a movie, what would the title be?",
          "What’s a secret you kept from your parents growing up?",
          "What’s one thing you always judge people for?",
          "What’s your drunk alter ego’s name?",
          "What’s a bad habit you’re working on breaking?",
          "If you had to text your crush right now, what would you say?",
          "What’s the most embarrassing thing you’ve done for attention?",
          "What’s one fashion trend you’ll never try again?",
          "Who’s most likely to send the first text after a date — you or them?",
          "What’s the wildest thing in your Notes app?",
          "What’s a compliment that always gets to you?",
          "What’s your favorite thing about yourself?",
          "What’s something you’ve learned about friendship this year?",
          "What’s one thing you’d tell your younger self about dating?",
          "What’s your biggest girl boss moment so far?",
          "What’s the best relationship advice you’ve ever gotten?",
          "What’s the worst one?",
          "What’s one thing that instantly gives you butterflies?",
          "What’s your love language — really?",
          "What’s one thing you wish people would stop assuming about you?",
          "Who’s the best secret-keeper in your friend group?",
          "What’s your most iconic comeback or clapback moment?",
          "What’s your current ‘main character’ energy vibe?",
          "What’s one thing that makes you feel truly unstoppable?",
        ];

      case "Boys Being Boys":
        return [
          "Rate your last date from 1–10 and be honest.",
          "What’s the boldest thing you’ve ever said to impress someone?",
          "What’s the most ridiculous thing you’ve done for attention?",
          "Who’s the biggest flirt in your friend group?",
          "Have you ever ghosted someone? Be real.",
          "What’s your most embarrassing drunk story?",
          "What’s the worst text you’ve ever sent to the wrong person?",
          "Who’s the first person you’d call if you got arrested?",
          "What’s a secret you’ve never told your boys?",
          "Have you ever been caught lying to a girl?",
          "What’s your biggest ‘player fail’ moment?",
          "What’s your guilty pleasure song or movie?",
          "What’s the dumbest way you’ve ever spent money?",
          "Who’s most likely to get roasted in the group chat?",
          "What’s one thing you can’t admit to your ex?",
          "What’s a bad habit you’ll never quit?",
          "What’s your ‘go-to’ move when flirting?",
          "What’s the most embarrassing thing you’ve done in front of a crush?",
          "What’s the most expensive thing you regret buying?",
          "What’s your drunk alter ego like?",
          "Have you ever lied about your job or income?",
          "Who’s the worst at keeping secrets?",
          "What’s something you did that you hope no one ever finds out?",
          "Who in your group would win in a fight — and who’d talk their way out of it?",
          "What’s your most legendary night out story?",
          "What’s a red flag you always ignore?",
          "What’s your biggest flex?",
          "What’s your go-to excuse when you mess up?",
          "What’s your most questionable haircut phase?",
          "Who’s most likely to get kicked out of a bar first?",
          "What’s your worst date story?",
          "What’s the weirdest DM you’ve ever received?",
          "What’s your all-time ‘bro code’ rule?",
          "What’s the pettiest reason you’ve stopped talking to someone?",
          "What’s one thing you always brag about?",
          "Who’s the biggest troublemaker in your group?",
          "Who’s most likely to fall for a dare?",
          "What’s one thing you’d never tell your mom?",
          "Who takes the longest to reply to texts?",
          "What’s something you wish you were better at?",
          "What’s your biggest L of the year so far?",
          "Who’s the smoothest talker in your group?",
          "What’s a wild night story you only tell when drunk?",
          "Who’s the best wingman you’ve ever had?",
          "What’s the worst pickup line you’ve ever tried?",
          "What’s your definition of a ‘good time’?",
          "Who’s most likely to text their ex first?",
          "Who’s the most competitive among your friends?",
          "What’s your proudest ‘boy math’ moment?",
          "If your life were a meme, which one would it be?",
          "What’s your ultimate hangover cure?",
        ];

      case "Love Affair":
        return [
          "What was your first impression of your partner?",
          "Who made the first move?",
          "When did you realize you were falling for them?",
          "What’s your partner’s most attractive feature?",
          "What’s a small thing they do that always makes you smile?",
          "Describe your partner in three words.",
          "Who apologizes first after an argument?",
          "What’s your favorite memory together?",
          "What song reminds you of them?",
          "Who said 'I love you' first?",
          "What’s the most romantic thing you’ve ever done?",
          "If your relationship were a movie, what would its title be?",
          "What’s your favorite way to show affection?",
          "Who gets jealous more easily?",
          "What’s something your partner does that secretly turns you on?",
          "What’s your partner’s love language?",
          "What’s one thing you’ve learned from your relationship?",
          "What’s your dream date night?",
          "What’s something new you want to try together?",
          "If you could relive one day with your partner, which would it be?",
          "Who’s more likely to say ‘sorry’ first?",
          "What’s your partner’s favorite meal or drink?",
          "Who’s more romantic?",
          "What’s your partner’s biggest green flag?",
          "If your partner were a flavor, what would they be?",
          "Who’s the better texter?",
          "What’s one thing you’d never change about them?",
          "What’s a secret fantasy you’d share only with your partner?",
          "What’s your favorite thing to do together on lazy days?",
          "What’s one way your partner has changed you for the better?",
          "What’s your go-to cuddle position?",
          "Who’s more likely to start a fight?",
          "What’s one thing your partner doesn’t know you love about them?",
          "If you could spend a weekend anywhere together, where would you go?",
          "Who’s the better kisser?",
          "Who plans better surprises?",
          "What’s a small gesture that always melts your heart?",
          "Who’s the more spontaneous one?",
          "What’s one song lyric that describes your relationship?",
          "Who’s more likely to cry during a movie?",
          "What’s something you’ve both grown through together?",
          "What’s the funniest moment you’ve shared as a couple?",
          "What’s something that always makes you miss them?",
          "What’s your ideal Valentine’s Day together?",
          "What’s your favorite thing to wake up to when you’re with them?",
          "Who’s more stubborn during arguments?",
          "What’s one compliment you don’t give them enough?",
          "What’s your definition of true love?",
          "If you had to write them a love note in 5 words, what would it say?",
          "What’s something they do that makes you blush?",
          "If your love was a drink, what would it be called?",
        ];

      default:
        return ["Something went wrong. Cheers anyway 🥂"];
    }
  }

  /// Fun group challenges for all players
  List<String> _getGroupQuestions() {
    return [
      "Everyone take a sip! 🍻",
      "If you’ve ever been late to something important, drink!",
      "Never have I ever flirted with a friend’s sibling.",
      "Never have I ever gone back to someone I swore I was done with.",
      "Never have I ever liked someone else while in a relationship.",
      "Never have I ever been caught checking someone out.",
      "Never have I ever pretended to like someone just to be polite.",
      "Never have I ever kissed more than one person in one night.",
      "Never have I ever sent a flirty selfie on purpose.",
      "Never have I ever ignored a text on purpose to seem mysterious.",
      "Never have I ever said I was ‘fine’ when I absolutely wasn’t.",
      "Never have I ever hooked up with someone and regretted it the next day."
          "Everyone wearing black takes a sip.",
      "Never have I ever been caught flirting at work.",
      "Never have I ever gone through someone’s phone.",
      "Never have I ever said ‘I love you’ when I didn’t mean it.",
      "Never have I ever dated two people at the same time.",
      "Never have I ever lied about being busy to avoid a date.",
      "Never have I ever gone back to an ex.",
      "Never have I ever had a crush on someone taken.",
      "Never have I ever sent a risky text and instantly regretted it.",
      "The last person to raise their hand drinks twice!",
      "Cheers! Everyone drinks together 🍸",
      "Never have I ever texted my ex after midnight.",
      "Never have I ever gone on a date just for free food.",
      "Never have I ever had a crush on a friend’s boyfriend.",
      "Never have I ever slid into someone’s DMs first.",
      "Never have I ever ghosted someone.",
      "If you’ve ever lied to get out of trouble, drink!",
      "Everyone with a phone on the table, sip!",
      "If you’ve ever had a hangover, drink!",
      "Never have I ever kissed someone I shouldn’t have.",
      "Never have I ever stalked someone’s ex online.",
      "Never have I ever given someone a fake name.",
      "Never have I ever snooped through someone’s messages.",
      "Never have I ever posted something just to make someone jealous.",
      "Never have I ever flirted my way out of trouble.",
      "Never have I ever fallen for someone I knew was bad for me."
          "The tallest person chooses someone to drink!",
      "Group toast: shout 'Sips!' and everyone drinks 🥂",
      "Everyone who’s ever stalked an ex online — take a sip.",
      "Take a sip if you’ve ever sent a text you wish you could unsend.",
      "Drink if you’ve ever been the ‘toxic one’ in a situation.",
      "If you’ve ever said ‘it’s complicated,’ drink twice.",
      "Everyone who’s ever had a sneaky link — take a sip.",
      "If you’ve ever caught feelings when you said you wouldn’t, drink.",
      "If you’ve ever gone through someone’s phone, drink twice.",
      "Drink if your ex still watches your stories.",
      "Everyone who’s ever flirted for free food or drinks — take a sip.",
      "If you’ve ever texted your ex after a few drinks, just drink now.",
      "Everyone who’s ever had a rebound — sip once.",
      "If you’ve ever liked someone’s old photo by accident — drink!",
      "Take a sip if you’ve ever had a ‘situation-ship’.",
      "Take a sip if you've ever sent an embarrassing drunk text.",
      "Take a sip if you've ever been banned from a public place (bar, store, gym, etc.).",
      "Take a sip if you have a big secret you keep from your parents (or family).",
      "Take a sip if you've ever left a terrible review for a product or service online.",
      "Take a sip if you've ever been caught singing badly by a friend or stranger.",
      "Take a sip if you've purchased something ridiculous after seeing it on social media.",
      "Take a sip if you've overslept and missed something really important (work, flight, appointment).",
      "Take a sip if you regret a tattoo or piercing you currently have.",
      "Take a sip if you've posted something on social media and quickly deleted it out of embarrassment.",
      "Take a sip if you've seriously messed up a meal you were cooking for other people."
      "Everyone who’s ever lied about their location — drink.",
      "If you’ve ever sent a message you had to delete fast — sip.",
      "Everyone who’s ever said ‘I don’t care’ when they *did* — drink.",
      "If you’ve ever stalked your crush’s new flame, drink twice.",
      "Take a sip if you’ve ever made someone jealous on purpose.",
      "Everyone who’s ever said ‘I’m done’ but wasn’t — finish your drink.",
      "Drink if you know exactly who you’d text if you weren’t playing this game.",
    ];
  }

  /// Randomly choose between an individual or group question
  void _setNextQuestion({bool first = false}) async {
    final players = Provider.of<AppProvider>(context, listen: false).players;

    final bool isGroupQuestion =
        _random.nextInt(100) < 40; // 30% group question
    final bool goToRoulette =
        !first &&
        _random.nextInt(100) < 30; // 20% chance roulette, only after first

    String? lastPlayer = _displayedPlayer;

    // 🎲 Open roulette only after first question
    if (goToRoulette) {
      final selectedPlayer = await Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  DrinkRoulettePage(color: _getCategoryColor(widget.category)),
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

      if (selectedPlayer != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _displayedPlayer = selectedPlayer;
            _currentIndex = _random.nextInt(_questions.length);
          });
        });
      }
      return;
    }

    // 🧠 Normal question logic
    setState(() {
      if (isGroupQuestion || players.isEmpty) {
        _displayedPlayer = "Group Chaos 🍻";
        _currentIndex = _random.nextInt(_groupQuestions.length);
      } else {
        String randomPlayer;
        do {
          randomPlayer = players[_random.nextInt(players.length)];
        } while (randomPlayer == lastPlayer && players.length > 1);

        _displayedPlayer = randomPlayer;
        _currentIndex = _random.nextInt(_questions.length);
      }

      _firstQuestion = false; // mark first question as done
    });
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Dirty":
        return ThemeClass.dirtyColor;
      case "Icebreaker":
        return ThemeClass.icebreakerColor;
      case "Ladies’ Night":
        return ThemeClass.ladiesNightColor;
      case "Boys Being Boys":
        return ThemeClass.boysColor;
      case "Love Affair":
        return ThemeClass.loveAffairColor;
      default:
        return ThemeClass.blackColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(widget.category);

    final bool isGroup =
        _displayedPlayer == "Group Chaos 🍻"; // check current question type
    final String displayedQuestion =
        isGroup ? _groupQuestions[_currentIndex] : _questions[_currentIndex];

    return Scaffold(
      backgroundColor: color.withValues(alpha: 0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              Text(
                widget.category,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Players: $_displayedPlayer",
                style: GoogleFonts.nunitoSans(
                  fontSize: 15,
                  color: ThemeClass.greyColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Question Card
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: color, width: 2),
                  ),
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      displayedQuestion,
                      key: ValueKey(displayedQuestion),
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ThemeClass.whiteColor,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Next Button
              ElevatedButton(
                onPressed: _setNextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  "Next 🍸",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "← Back to Categories",
                  style: GoogleFonts.poppins(
                    color: color,
                    fontWeight: FontWeight.w500,
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
