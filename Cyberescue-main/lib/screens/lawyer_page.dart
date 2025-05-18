import 'package:flutter/material.dart';

class LawyerPage extends StatefulWidget {
  final List<Map<String, String>> submittedRequests;

  LawyerPage({required this.submittedRequests});

  @override
  _LawyerPageState createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
  String? _searchId;

  void _acceptRequest(String requestId) {
    setState(() {
      for (var request in widget.submittedRequests) {
        if (request['id'] == requestId && request['status'] == 'Submitted') {
          request['status'] = 'Accepted by Lawyer';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredRequests = widget.submittedRequests;

    // If search ID is entered, filter the requests
    if (_searchId != null && _searchId!.isNotEmpty) {
      filteredRequests = widget.submittedRequests
          .where((request) => request['id'] == _searchId)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Lawyer Requests'), backgroundColor: Colors.green),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Search by Request ID
            TextField(
              decoration: InputDecoration(
                labelText: 'Search by Request ID',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchId = value;
                });
              },
            ),
            SizedBox(height: 10),

            // Display Requests
            Expanded(
              child: filteredRequests.isEmpty
                  ? Center(child: Text('No requests found'))
                  : ListView.builder(
                      itemCount: filteredRequests.length,
                      itemBuilder: (context, index) {
                        final request = filteredRequests[index];

                        return Card(
                          child: ListTile(
                            title: Text(request['issue'] ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Category: ${request['category']}'),
                                Text('Request ID: ${request['id']}'),
                                Text('Status: ${request['status']}'),
                              ],
                            ),
                            trailing: request['status'] == 'Submitted'
                                ? ElevatedButton(
                                    onPressed: () {
                                      _acceptRequest(request['id']!);
                                    },
                                    child: Text('Accept'),
                                  )
                                : Text('Accepted', style: TextStyle(color: Colors.green)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
