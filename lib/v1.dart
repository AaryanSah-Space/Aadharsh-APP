import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';
import 'screens/grocery_game_screen.dart';

void showCelebration(BuildContext context, String message) {
  speak(message);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.7, end: 1.2),
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.emoji_events,
                  size: 90,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void main() {
  runApp(const LifeLearningApp());
}

final FlutterTts tts = FlutterTts();
String currentLanguage = "en-US"; // default English
final Map<int, Map<String, String>> numberWords = {
  1: {"en": "one", "hi": "एक", "ne": "एक"},
  2: {"en": "two", "hi": "दो", "ne": "दुई"},
  3: {"en": "three", "hi": "तीन", "ne": "तीन"},
  4: {"en": "four", "hi": "चार", "ne": "चार"},
  5: {"en": "five", "hi": "पाँच", "ne": "पाँच"},
  6: {"en": "six", "hi": "छह", "ne": "छ"},
  7: {"en": "seven", "hi": "सात", "ne": "सात"},
  8: {"en": "eight", "hi": "आठ", "ne": "आठ"},
  9: {"en": "nine", "hi": "नौ", "ne": "नौ"},
  10: {"en": "ten", "hi": "दस", "ne": "दस"},
  // we’ll expand gradually up to 100
};



Future<void> speak(String text) async {
  await tts.setLanguage(currentLanguage);
  await tts.setSpeechRate(0.45);
  await tts.setPitch(1.0);
  await tts.speak(text);
}

class LifeLearningApp extends StatelessWidget {
  const LifeLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Life Learning',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0E0E10),
      ),
      home: const HomeScreen(),
    );
  }
}

/// ================= HOME =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Life Learning"),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
      onSelected: (value) {
        currentLanguage = value;

        if (value == "en-US") {
          speak("English selected");
        } else if (value == "hi-IN") {
          speak("हिंदी चुनी गई");
        } else if (value == "ne-NP") {
          speak("नेपाली भाषा चयन गरियो");
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: "en-US", child: Text("English")),
        PopupMenuItem(value: "hi-IN", child: Text("हिंदी")),
        PopupMenuItem(value: "ne-NP", child: Text("नेपाली")),
      ],
    ),
  ],
),

      body: GridView.count(
        padding: const EdgeInsets.all(24),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          HomeCard(
            icon: Icons.restaurant,
            label: "Food",
            color: Colors.orangeAccent,
            onTap: () {
              speak("Food");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ItemScreen(
                    title: "Food",
                    color: Colors.orangeAccent,
                    items: ["Rice", "Bread", "Water"],
                    icons: [
                      Icons.lunch_dining,
                      Icons.bakery_dining,
                      Icons.local_drink
                    ],
                  ),
                ),
              );
            },
          ),
          HomeCard(
            icon: Icons.directions_bus,
            label: "Travel",
            color: Colors.blueAccent,
            onTap: () {
              speak("Travel");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ItemScreen(
                    title: "Travel",
                    color: Colors.blueAccent,
                    items: ["Bus", "Train", "Taxi"],
                    icons: [
                      Icons.directions_bus,
                      Icons.train,
                      Icons.local_taxi
                    ],
                  ),
                ),
              );
            },
          ),
          HomeCard(
            icon: Icons.shopping_cart,
            label: "Shopping",
            color: Colors.greenAccent,
            onTap: () {
              speak("Shopping");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GroceryGameScreen(
                    language: currentLanguage,
                  ),
                ),
              );
           },
          ),

          HomeCard(
            icon: Icons.currency_rupee,
            label: "Money",
            color: Colors.tealAccent,
            onTap: () {
              speak("Money");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoneyScreen(),
                ),
              );
            },
          ),
          HomeCard(
            icon: Icons.numbers,
            label: "Counting",
            color: Colors.purpleAccent,
            onTap: () {
              speak("Counting");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CountingScreen(),
                ),
              );
            },
          ),   
        ],
      ),
    );
  }
}

/// ================= HOME CARD =================
class HomeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: color),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

/// ================= ITEM SCREEN =================
class ItemScreen extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> items;
  final List<IconData> icons;

  const ItemScreen({
    super.key,
    required this.title,
    required this.color,
    required this.items,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.black),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => speak(items[index]),
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons[index], size: 56, color: color),
                  const SizedBox(height: 10),
                  Text(items[index], style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ================= MONEY SCREEN =================
class MoneyScreen extends StatefulWidget {
  const MoneyScreen({super.key});

  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  final Random random = Random();
  late Map<String, dynamic> targetNote;

  final notes = [
  {"value": 5, "image": "assets/notes/rs_5.jpg"},
  {"value": 10, "image": "assets/notes/rs_10.jpg"},
  {"value": 20, "image": "assets/notes/rs_20.jpg"},
  {"value": 50, "image": "assets/notes/rs_50.jpg"},
  {"value": 100, "image": "assets/notes/rs_100.jpg"},
  {"value": 500, "image": "assets/notes/rs_500.jpg"},
  {"value": 1000, "image": "assets/notes/rs_1000.jpg"},
];

  
  @override
  void initState() {
    super.initState();
    _pickRandomNote();
  }

  void _pickRandomNote() {
    targetNote = notes[random.nextInt(notes.length)];
    speak("Tap ${targetNote['value']} rupees");
    setState(() {});
  }

  void _checkAnswer(int tappedValue) {
    if (tappedValue == targetNote['value']) {
  showCelebration(
    context,
    currentLanguage == "hi-IN"
        ? "बहुत बढ़िया!"
        : currentLanguage == "ne-NP"
            ? "धेरै राम्रो!"
            : "Great job!",
  );
      _pickRandomNote();
    } else {
      speak(
        currentLanguage == "hi-IN"
            ? "फिर कोशिश करें"
            : currentLanguage == "ne-NP"
                ? "फेरि प्रयास गर्नुहोस्"
                : "Try again",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Practice"),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () => _checkAnswer(note['value'] as int),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
  note['image'] as String,
  fit: BoxFit.cover,
  width: double.infinity,
),

                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rs ${note['value']}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


/// ================= COUNTING SCREEN =================
class CountingScreen extends StatefulWidget {
  const CountingScreen({super.key});

  @override
  State<CountingScreen> createState() => _CountingScreenState();
}

class _CountingScreenState extends State<CountingScreen> {
  int start = 1;              // 1–10, 11–20 ...
  int correctToday = 0;       // daily goal counter
  late int targetNumber;      // number to tap
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _pickRandomTarget();
    _speakTarget();
  }

  void _pickRandomTarget() {
    targetNumber = start + random.nextInt(10);
  }

  void _speakTarget() {
    if (currentLanguage == "hi-IN") {
      speak("टैप करें $targetNumber");
    } else if (currentLanguage == "ne-NP") {
      speak("$targetNumber ट्याप गर्नुहोस्");
    } else {
      speak("Tap $targetNumber");
    }
  }

  List<int> get currentNumbers =>
      List.generate(10, (index) => start + index);

  void nextPage() {
    if (start < 91) {
      setState(() {
        start += 10;
        _pickRandomTarget();
      });
      _speakTarget();
    }
  }

  void previousPage() {
    if (start > 1) {
      setState(() {
        start -= 10;
        _pickRandomTarget();
      });
      _speakTarget();
    }
  }

  void onNumberTap(int number) {
    if (number == targetNumber) {
      setState(() {
        correctToday++;
        _pickRandomTarget();
      });

      if (currentLanguage == "hi-IN") {
        speak("अच्छा किया");
      } else if (currentLanguage == "ne-NP") {
        speak("राम्रो भयो");
      } else {
        speak("Good job");
      }

      if (correctToday >= 10) {
  showCelebration(
    context,
    currentLanguage == "hi-IN"
        ? "आज का लक्ष्य पूरा हुआ!"
        : currentLanguage == "ne-NP"
            ? "आजको लक्ष्य पूरा भयो!"
            : "Daily goal completed!",
  );
}
 else {
        _speakTarget();
      }
    } else {
      speak(currentLanguage == "hi-IN"
          ? "फिर कोशिश करें"
          : currentLanguage == "ne-NP"
              ? "फेरि प्रयास गर्नुहोस्"
              : "Try again");
    }
  }
void showCelebration(BuildContext context, String message) {
  speak(message);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.8, end: 1.2),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.emoji_events,
                  size: 80,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counting $start - ${start + 9}"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Daily progress
          Text(
            "Today: $correctToday / 10",
            style: const TextStyle(fontSize: 18),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: currentNumbers.length,
              itemBuilder: (context, index) {
                final number = currentNumbers[index];
                return GestureDetector(
                  onTap: () => onNumberTap(number),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        number.toString(),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: previousPage,
                  child: const Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: nextPage,
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

