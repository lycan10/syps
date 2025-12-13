import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sips/screens/home/home.dart';
import '../../service/app_provider.dart';
import '../../theme/theme.dart';
import '../../components/ad_banner.dart';

class ParticipantInputPage extends StatefulWidget {
  const ParticipantInputPage({super.key});

  @override
  State<ParticipantInputPage> createState() => _ParticipantInputPageState();
}

class _ParticipantInputPageState extends State<ParticipantInputPage> {
  final TextEditingController _nameController = TextEditingController();

  void _addPlayer() {
    final name = _nameController.text.trim();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    if (name.isNotEmpty && !appProvider.players.contains(name)) {
      appProvider.addPlayer(name);
      _nameController.clear();
    }
  }

  void _editPlayer(int index, String currentName) {
    TextEditingController editController = TextEditingController(
      text: currentName,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Edit Name",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Enter name"),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newName = editController.text.trim();
                if (newName.isNotEmpty) {
                  Provider.of<AppProvider>(
                    context,
                    listen: false,
                  ).updatePlayer(index, newName);
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showClearConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Clear All?",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: const Text("Are you sure you want to remove all players?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).clearPlayers();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Clear All"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final players = appProvider.players;

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
            actions: [
              if (players.isNotEmpty)
                IconButton(
                  onPressed: _showClearConfirmation,
                  icon: const Icon(
                    Icons.delete_sweep_rounded,
                    color: Colors.red,
                  ),
                  tooltip: "Clear All",
                ),
            ],
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
                              vertical: 14,
                              horizontal: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: ThemeClass.greyColor2,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: ThemeClass.dirtyColor,
                                width: 2,
                              ),
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
                            vertical: 14,
                            horizontal: 18,
                          ),
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
                    child:
                        players.isEmpty
                            ? Center(
                              child: Text(
                                "No players added yet!",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: ThemeClass.greyColor,
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemCount: players.length,
                              itemBuilder: (context, index) {
                                final player = players[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ThemeClass.dirtyColor.withValues(
                                      alpha: 0.08,
                                    ),
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
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit_rounded,
                                            color: ThemeClass.icebreakerColor,
                                          ),
                                          onPressed:
                                              () => _editPlayer(index, player),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.close_rounded,
                                            color: ThemeClass.greyColor,
                                          ),
                                          onPressed:
                                              () => appProvider.removePlayer(
                                                player,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),

                  // Banner Ad
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: AdBanner(),
                  ),

                  // Start Button
                  SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            players.length >= 2
                                ? () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(
                                        milliseconds: 600,
                                      ),
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => const Home(),
                                      transitionsBuilder: (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        return SharedAxisTransition(
                                          animation: animation,
                                          secondaryAnimation:
                                              secondaryAnimation,
                                          transitionType:
                                              SharedAxisTransitionType
                                                  .scaled, // options: horizontal, vertical, scaled
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeClass.dirtyColor,
                          disabledBackgroundColor: ThemeClass.greyColor2
                              .withValues(alpha: 0.4),
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
      },
    );
  }
}
