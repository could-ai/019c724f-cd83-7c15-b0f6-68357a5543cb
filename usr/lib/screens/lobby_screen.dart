import 'package:flutter/material.dart';
import 'dart:async';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  bool _isTeleporting = false;
  
  // Mock list of players in the lobby
  final List<String> _players = [
    "Player 1 (Host)",
    "Player 2",
    "Player 3",
    "You",
  ];

  void _teleportToGame() {
    setState(() {
      _isTeleporting = true;
    });

    // Simulate a delay for "teleporting"
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isTeleporting = false;
      });
      Navigator.pushNamed(context, '/game');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Lobby'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.deepPurple.shade100],
          ),
        ),
        child: _isTeleporting
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.deepPurple),
                    const SizedBox(height: 20),
                    Text(
                      "Teleporting to game...",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Waiting for players...",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const LinearProgressIndicator(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _players.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple.shade200,
                              child: Icon(Icons.person, color: Colors.deepPurple.shade800),
                            ),
                            title: Text(
                              _players[index],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: index == 3 
                                ? const Chip(label: Text("Ready"), backgroundColor: Colors.greenAccent)
                                : const Chip(label: Text("Ready"), backgroundColor: Colors.greenAccent),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _teleportToGame,
                        icon: const Icon(Icons.bolt),
                        label: const Text(
                          "TELEPORT TO GAME",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
