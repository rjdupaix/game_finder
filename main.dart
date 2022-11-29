

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Game Finder',
      home: Landing(),
    );
  }
}

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  Widget build(BuildContext context) {
    Widget gamesRow = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Talisman',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage(title: 'Talisman',)),
                );
              },
              icon: Icon(Icons.arrow_forward_ios),
            )
          ],
        )
    );
    return MaterialApp(
      title: 'Game Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Game FInder"),
        ),
        body: Column(
          children: [
            gamesRow,
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  String selectedTab = "";
  static const String INFO = "info";
  static const String CONTACT = "contact";
  static late final Function(String) selected;

  List<String> searchTerms = [
    "Talisman",
    "Exploding Kittens",
    "Catan",
    "Dominion",
    "Star Wars: Rebellion",
    "Betrayal at House on the Hill",
    "Mansions of Madness",
    "Monopoly",
    "Skull King",
    "Magic: The Gathering",
    "Dungeons and Dragons"
  ];
  //first overwrite to
  //clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    // REturn game page widget
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    selectedTab = INFO;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: selectedTab == INFO
                      ? const BoxDecoration(border: Border(bottom: BorderSide()))
                      : null,
                    child: const Text("Group Info"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    VoidCallbackAction();
                    selectedTab = CONTACT;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: selectedTab == CONTACT
                      ? const BoxDecoration(border: Border(bottom: BorderSide()))
                      : null,
                    child: Text("Contact Info"),
                  ),
                ),
              ],
            ),
          )
        ],
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    if (query != '') {
      for (var fruit in searchTerms) {
        if (fruit.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(fruit);
        }
      }
      if (matchQuery.isEmpty) {
        matchQuery.add("Sorry, we could not find that game");
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            close(context, null);
            //query = result;
          },
        );
        //return GamePage();
      },
    );
  }
}

class GamePage extends StatelessWidget {
  final String title;

  GamePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('About ' + title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutInfo(title: title,)),
              );
            }
          ),
          ListTile(
            title: Text('Games Near You'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CloseGames()),
              );
            }
          ),
        ],
      )
    );
  }
}

class AboutInfo extends StatelessWidget {
  final String title;

  AboutInfo({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About ' + title),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Talisman is a very good game"),
          ),
        ],
      ),
    );
  }
}


class CloseGames extends StatelessWidget {
  const CloseGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games Near You'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Game 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactInfo()),
              );
            },
          ),
          ListTile(
            title: Text('Game 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactInfo()),
              );
            },
          ),
          ListTile(
            title: Text('Game 3'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactInfo()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Info'),
      ),
      body: ListTile(
        title: Text('123-456-7890'),
      ),
    );
  }
}



/*

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GamePage> createState() => _GamePageState(title, title: '');
}

class _GamePageState extends State<GamePage> {
  final String title;

  _GamePageState(String title, {required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Page",),
      ),
      body: const Center(
        child: Text("Hello World")
      ),
    );
  }
}*/
