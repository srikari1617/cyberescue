import 'dart:convert';
import 'package:flutter/services.dart';

Future<String> getChatbotReply(String userInput) async {
  final files = [
    'assets/ChatBot_Intents/greetings_custom_usersays_en.json',
    'assets/ChatBot_Intents/jokes_yes_usersays_en.json',
    'assets/ChatBot_Intents/quotes_no_usersays_en.json',
  ];

  for (final file in files) {
    final content = await rootBundle.loadString(file);
    final List<dynamic> examples = jsonDecode(content);

    for (final example in examples) {
      final textData = example['data'][0]['text'].toString().toLowerCase();
      if (userInput.toLowerCase().contains(textData)) {
        if (file.contains('Greetings'))
          return "Hello! How can I help you today?";
        if (file.contains('Jokes'))
          return "Why did the computer go to therapy? Because it had too many bytes!";
        if (file.contains('quotes')) return "Keep going, you're doing great.";
      }
    }
  }

  return "Don't worry. I will always be here for you! XOXO";
}
