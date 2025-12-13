import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  List<String> _players = [];
  static const String _playersKey = 'players_list';

  List<String> get players => _players;

  AppProvider() {
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    _players = prefs.getStringList(_playersKey) ?? [];
    notifyListeners();
  }

  Future<void> _savePlayers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_playersKey, _players);
  }

  void addPlayer(String name) {
    if (name.trim().isEmpty) return;
    _players.add(name);
    _savePlayers();
    notifyListeners();
  }

  void removePlayer(String name) {
    _players.remove(name);
    _savePlayers();
    notifyListeners();
  }

  void clearPlayers() {
    _players.clear();
    _savePlayers();
    notifyListeners();
  }

  void updatePlayer(int index, String newName) {
    if (index >= 0 && index < _players.length && newName.trim().isNotEmpty) {
      _players[index] = newName;
      _savePlayers();
      notifyListeners();
    }
  }

  void setPlayers(List<String> players) {
    _players = players;
    _savePlayers();
    notifyListeners();
  }
}
