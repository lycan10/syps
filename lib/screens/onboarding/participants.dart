import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sips/screens/home/home.dart';
import '../../service/app_provider.dart';
import '../../theme/theme.dart';

class ParticipantInputPage extends StatefulWidget {
  const ParticipantInputPage({super.key});

  @override
  State<ParticipantInputPage> createState() => _ParticipantInputPageState();
}

class _ParticipantInputPageState extends State<ParticipantInputPage> {
  final TextEditingController _nameController = TextEditingController();
  final List<String> _players = [];

  void _addPlayer() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty && !_players.contains(name)) {
      setState(() {
        _players.add(name);
      });
      _nameController.clear();
    }
  }

  void _removePlayer(String name) {
    setState(() {
      _players.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Who's Playing?",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ThemeClass.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // Instruction Text
              Text(
                "Add your friends to the list and get ready to sip responsibly 🍸",
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: ThemeClass.greyColor,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),

              // Input Field
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Enter a name",
                        hintStyle: GoogleFonts.nunitoSans(
                          color: ThemeClass.greyColor2,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              color: ThemeClass.greyColor2, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              color: ThemeClass.dirtyColor, width: 2),
                        ),
                      ),
                      onSubmitted: (_) => _addPlayer(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addPlayer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeClass.dirtyColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Player List
              Expanded(
                child: _players.isEmpty
                    ? Center(
                  child: Text(
                    "No players added yet!",
                    style: textTheme.bodyMedium?.copyWith(
                      color: ThemeClass.greyColor,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: _players.length,
                  itemBuilder: (context, index) {
                    final player = _players[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: ThemeClass.dirtyColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        title: Text(
                          player,
                          style: GoogleFonts.poppins(
                            color: ThemeClass.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: ThemeClass.greyColor),
                          onPressed: () => _removePlayer(player),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Start Button
              SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _players.length >= 2
                        ? () {
                      final appProvider = Provider.of<AppProvider>(context, listen: false);
                      appProvider.setPlayers(_players); // Save players globally

                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 600),
                          pageBuilder: (context, animation, secondaryAnimation) =>
                          const Home(),
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
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeClass.dirtyColor,
                      disabledBackgroundColor:
                      ThemeClass.greyColor2.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Start the Fun 🎉",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ThemeClass.whiteColor,
                      ),
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
