// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class ChatbotService {
//   final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

//   Future<String> getChatbotResponse(String userMessage) async {
//     if (apiKey.isEmpty) {
//       return 'API key is missing!';
//     }

//     final response = await http.post(
//       Uri.parse('https://api.openai.com/v1/completions'),
//       headers: {
//         'Authorization': 'Bearer $apiKey',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "model": "text-davinci-003",
//         "prompt": userMessage,
//         "max_tokens": 150,
//         "temperature": 0.7,
//       }),
//     );

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       return data['choices'][0]['text'].toString().trim();
//     } else {
//       return 'Failed to get response';
//     }
//   }
// }
