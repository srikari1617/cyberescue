// import 'package:flutter/material.dart';
// import '../services/chatbot_service.dart'; // Import ChatbotService

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   // final ChatbotService _chatbotService = ChatbotService();
//   List<Map<String, String>> _messages = []; // To store conversation messages

//   // Function to handle sending message and getting response
//   void _sendMessage() async {
//     if (_controller.text.isEmpty) return;

//     String userMessage = _controller.text;
//     setState(() {
//       _messages.add({'sender': 'user', 'message': userMessage});
//     });

//     // Get the chatbot's response
//     String chatbotResponse =
//         // await _chatbotService.getChatbotResponse(userMessage);

//     setState(() {
//       _messages.add({'sender': 'chatbot', 'message': chatbotResponse});
//     });

//     _controller.clear(); // Clear the input field after sending the message
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cyberbullying Chatbot'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               reverse: true, // To show the most recent message at the bottom
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 var message = _messages[index];
//                 return ListTile(
//                   title: Align(
//                     alignment: message['sender'] == 'user'
//                         ? Alignment.centerRight
//                         : Alignment.centerLeft,
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: message['sender'] == 'user'
//                             ? Colors.blueAccent
//                             : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         message['message']!,
//                         style: TextStyle(
//                           color: message['sender'] == 'user'
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
