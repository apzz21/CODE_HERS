import 'dart:async'; // For periodic updates
import 'dart:math'; // For randomizing quotes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pet_haven/model/gemini_model.dart'; // Import your service file

class ChatPageG extends StatefulWidget {
  const ChatPageG({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageG> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService geminiService = GeminiService(); // No API key needed here
  final List<Map<String, String>> _messages = []; // List to store chat messages

  final List<Color> gradientColors = [
    const Color.fromARGB(255, 141, 204, 238),
    const Color.fromARGB(255, 238, 174, 206),
    const Color.fromARGB(255, 236, 118, 175),
    const Color.fromARGB(255, 224, 162, 243),
    const Color.fromARGB(255, 227, 162, 192),
  ];

  // List of interesting pet care-related quotes for randomization
  final List<String> _interestingQuotes = [
    "How can I make my dog feel more loved today?",
    "What’s the best way to comfort a stressed cat?",
    "Do birds like listening to music?",
    "How do I know if my pet is happy and healthy?",
    "What are some creative ways to play with my dog indoors?",
  ];

  // Randomizing the quotes
  String _currentQuote = "";
  late Timer _quoteTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _currentQuote = getRandomQuote();
    _startQuoteTimer();
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _quoteTimer.cancel();
    super.dispose();
  }

  String getRandomQuote() {
    final random = Random();
    return _interestingQuotes[random.nextInt(_interestingQuotes.length)];
  }

  void _startQuoteTimer() {
    _quoteTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isTyping) {
        setState(() {
          _currentQuote = getRandomQuote();
        });
      }
    });
  }

  Future<void> _sendMessage() async {
    String prompt = _controller.text;
    if (prompt.isNotEmpty) {
      setState(() {
        _messages.add({"role": "user", "text": prompt}); // Add user message
      });

      // Clear the input field
      _controller.clear();

      // Get the response from the Gemini service
      String responseText = await geminiService.generateResponse(prompt);

      setState(() {
        _messages.add({"role": "bot", "text": responseText}); // Add bot response
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientColors[0],
              gradientColors[1],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Title aligned to the left
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chat with Pet Pal",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),
            if (!_isTyping)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Here’s something to get you started:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.pets, size: 50, color: const Color.fromARGB(255, 230, 144, 213)),
                        const SizedBox(width: 10),
                        Icon(Icons.pets, size: 50, color: const Color.fromARGB(255, 177, 128, 226)),
                        const SizedBox(width: 10),
                        Icon(Icons.pets, size: 50, color: Colors.pinkAccent),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _currentQuote,
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];
                  final isUser = message["role"] == "user";

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser
                            ? gradientColors[2]
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MarkdownBody(
                        data: message["text"] ?? '',
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            color: isUser ? Colors.white : gradientColors[4],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Ask about pet care, love, or fun facts!',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: gradientColors[2],
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
