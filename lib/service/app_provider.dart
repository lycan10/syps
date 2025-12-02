import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  List<String> _players = [];

  List<String> get players => _players;

  void addPlayer(String name) {
    if (name.trim().isEmpty) return;
    _players.add(name);
    notifyListeners();
  }

  void removePlayer(String name) {
    _players.remove(name);
    notifyListeners();
  }

  void clearPlayers() {
    _players.clear();
    notifyListeners();
  }

  void setPlayers(List<String> players) {
    _players = players;
    notifyListeners();
  }
}
