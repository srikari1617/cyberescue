import 'package:flutter/material.dart';

class SubmittedRequests extends StatelessWidget {
  final List<Map<String, String>> submittedRequests;

  const SubmittedRequests({Key? key, required this.submittedRequests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submitted Requests', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: submittedRequests.isEmpty
          ? const Center(child: Text('No requests submitted yet', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: submittedRequests.length,
              itemBuilder: (context, index) {
                final request = submittedRequests[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Request ID: ${request['id']}', // ✅ Display the ID
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
                        const SizedBox(height: 5),
                        Text('Issue: ${request['issue']}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text('Category: ${request['category']}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 5),
                        Text('File: ${request['file']}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 5),
                        Text(
                          'Status: ${request['status']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: request['status'] == 'Resolved'
                                ? Colors.green
                                : request['status'] == 'In Progress'
                                    ? Colors.orange
                                    : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
