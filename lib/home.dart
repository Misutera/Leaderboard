import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leaderboard/howtojoin.dart';
import 'package:leaderboard/mappool.dart';

import 'classes.dart';
import 'leaderboard.dart';

class Home extends StatefulWidget {
  Home({super.key});

  // Edit stuff here! ===========================

  // Number of people that can qualify
  final int qualifiedQuota = 2;

  // Participants that joined this events
  final List<String> players = [
    // Tiramisu
    '76561198172457683',

    // Mentega
    'mentega',

    // Get
    '76561198083506351',

    // Enjiesu
    '76561198164724662'
  ];

  // Map pool
  final List<Qualifier> qualifiers = [
    // Powerful
    Qualifier(
        mapID: '18f6291', mapDifficulty: 'ExpertPlus', mapMode: 'Standard'),

    // Super Idol
    Qualifier(
        mapID: '1dcd791', mapDifficulty: 'ExpertPlus', mapMode: 'Standard'),

    // Ov Sacrament
    Qualifier(
        mapID: 'c32d91', mapDifficulty: 'ExpertPlus', mapMode: 'Standard'),

    // Ov Sacrament
    Qualifier(mapID: 'c32d71', mapDifficulty: 'Expert', mapMode: 'Standard'),

    // Silentphobia
    Qualifier(mapID: '1b7bf71', mapDifficulty: 'Expert', mapMode: 'Standard'),

    // HYPER ULTRA JACKPOT
    Qualifier(
        mapID: '39bc391', mapDifficulty: 'ExpertPlus', mapMode: 'Standard'),

    // HYPER ULTRA JACKPOT
    Qualifier(mapID: '39bc371', mapDifficulty: 'Expert', mapMode: 'Standard')
  ];

  // ===========================================

  @override
  State<Home> createState() => _HomeState();
}

Widget title(String qualifiedQuota) {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Top $qualifiedQuota Qualifies for VRGI\'s',
        ),
        const Text(
          'Beat Saber Tournament',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget leaderboardCard(
    List<User> users, int qualifiedQuota, String loadingText) {
  return Expanded(
    child: Center(
      child: SizedBox(
        width: 800,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Leaderboard(
            qualifiedQuota: qualifiedQuota,
            users: users,
            loadingText: loadingText,
          ),
        ),
      ),
    ),
  );
}

Widget buttons(
    BuildContext context, Map<String, Song> songs, List<Qualifier> qualifiers) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HowToJoinPage(),
                  ),
                );
              },
              child: const Text('How to enter')),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPool(
                              songs: songs,
                              qualifiers: qualifiers,
                            )));
              },
              child: const Text('Map Pool ->')),
        ),
      ],
    ),
  );
}

class _HomeState extends State<Home> {
  List<User> users = [];
  Map<String, Song> songs = {};

  String loadingText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title(widget.qualifiedQuota.toString()),
          buttons(context, songs, widget.qualifiers),
          leaderboardCard(users, widget.qualifiedQuota, loadingText),
        ],
      ),
    );
  }

  String apiURL = 'https://api.beatleader.xyz';

  void refresh() async {
    String error = '';

    // Get Map Datas
    setState(() {
      loadingText = 'Getting Map Data...';
    });
    print('Fetching Map Datas');
    List<Future> mapFutures = [];
    for (var entry in widget.qualifiers) {
      mapFutures.add(fetchMapDatas(entry));
    }
    await Future.wait(mapFutures);
    // =============

    // Get Player Datas
    setState(() {
      loadingText = 'Getting Player Datas...';
    });
    print('Fetching player datas');
    List<Future> playerFutures = [];
    for (var entry in widget.players) {
      playerFutures.add(fetchPlayerData(entry));
    }
    await Future.wait(playerFutures);
    // ============

    setState(() {
      loadingText = error.contains('Error') ? error : '';
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<String> fetchMapDatas(Qualifier entry) async {
    try {
      print('Sending: $apiURL/leaderboard/${entry.mapID}');
      final response =
          await http.get(Uri.parse('$apiURL/leaderboard/${entry.mapID}'));

      if (response.statusCode == 200) {
        //print('Results: ${response.body}');
        Map<String, dynamic> data = jsonDecode(response.body);
        Map<String, dynamic> songdata = data['song'];

        Song newChart = Song.fromJson(songdata);
        setState(() {
          songs[entry.mapID] = newChart;
          print('Total songs in charts: ${songs.length}');
          print(
              'Chart contains id of ${entry.mapID}: ${getSongInfo(entry.mapID)!.name}');
        });
      }
      return '';
    } catch (error) {
      print('Error while fetching map datas! $error');
      return 'Error! $error';
    }
  }

  Future<String> fetchPlayerData(String uid) async {
    try {
      print('Sending: $apiURL/player/$uid');
      final response = await http.get(Uri.parse('$apiURL/player/$uid'));

      if (response.statusCode == 200) {
        final playerJson = jsonDecode(response.body);

        int totalScore = 0;
        List<Future> futures = [];
        for (int i = 0; i < widget.qualifiers.length; i++) {
          String request =
              '$apiURL/player/$uid/scorevalue/${getSongInfo(widget.qualifiers[i].mapID)!.hash}/${widget.qualifiers[i].mapDifficulty}/${widget.qualifiers[i].mapMode}';
          futures.add(http.get(Uri.parse(request)).then((scoreResult) {
            if (scoreResult.statusCode == 200) {
              totalScore = totalScore + int.tryParse(scoreResult.body)!;
            } else {
              print('Error getting score for ${widget.qualifiers[i].mapID}');
            }
          }));
        }

        await Future.wait(futures);

        User newUser = User.fromJson(playerJson);

        newUser.qualifierScore = totalScore;

        setState(() {
          print('adding new user');
          users.add(newUser);
          users.sort((a, b) => b.qualifierScore.compareTo(a.qualifierScore));
        });
      } else {
        throw Exception('Failed to load Player data');
      }
      return '';
    } catch (error) {
      print('Error: $error');
      return 'Error! $error';
    }
  }

  Song? getSongInfo(String songID) {
    return songs[songID];
  }
}
