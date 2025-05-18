import 'package:flutter/material.dart';

class FaqsScreen extends StatefulWidget {
  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> faqs = [
    {
      'question': 'What is Cyberescue and how does it help victims?',
      'answer': 'Cyberescue is a comprehensive platform designed to support victims of cybercrime by connecting them with legal experts and providing insights about their legal rights and available remedies. Our mission is to empower victims with knowledge and resources to help them navigate the complexities of cybercrime incidents.',
      'icon': Icons.shield_outlined,
      'category': 'General',
    },
    {
      'question': 'What types of cybercrime does Cyberescue address?',
      'answer': 'Cyberescue addresses various types of cybercrime, including but not limited to phishing, identity theft, ransomware attacks, online harassment, cyberbullying, social engineering, SIM swapping, vishing, password theft, and other forms of digital fraud or exploitation.',
      'icon': Icons.security_outlined,
      'category': 'General',
    },
    {
      'question': 'What are the key features of the Cyberescue app?',
      'answer': 'Cyberescue offers several key features including:\n\n• Secure authentication to protect your privacy\n• AI-powered chatbot for immediate assistance with cyberbullying issues\n• Directory of verified legal experts specializing in cybercrime\n• Step-by-step guidance for reporting various cybercrimes\n• Educational resources about cyber laws and victim rights\n• Secure document storage for case-related information\n• Community forum for peer support\n• Emergency contact information for immediate assistance',
      'icon': Icons.stars_outlined,
      'category': 'Features',
    },
    {
      'question': 'Is my information safe with Cyberescue?',
      'answer': 'Absolutely. At Cyberescue, we prioritize your privacy and data security. We use state-of-the-art encryption methods to protect your personal information and case details. Our platform is designed with a "security-first" approach, and we never share your data with third parties without your explicit consent.',
      'icon': Icons.lock_outlined,
      'category': 'Security',
    },
    {
      'question': 'When should I use the Cyberescue app?',
      'answer': 'You should use Cyberescue as soon as you suspect you\'ve been a victim of cybercrime or when you need guidance on addressing a cyber-related issue. Early intervention can be crucial in mitigating damage and preserving evidence. However, Cyberescue is also valuable for preventive education and for understanding your rights in the digital space.',
      'icon': Icons.help_outline,
      'category': 'Usage',
    },
    {
      'question': 'How do I connect with legal experts through Cyberescue?',
      'answer': 'Cyberescue provides a verified directory of legal experts specializing in cybercrime and digital law. You can browse profiles based on expertise, location, and language. Once you find a suitable expert, you can request a consultation directly through the app. All listed experts are vetted for credentials and experience in handling cybercrime cases.',
      'icon': Icons.person_outline,
      'category': 'Legal',
    },
    {
      'question': 'What should I do immediately after experiencing cybercrime?',
      'answer': '1. Document everything: Take screenshots and save all relevant information.\n2. Do not delete evidence or communication with the perpetrator.\n3. Change passwords for compromised accounts using a secure device.\n4. Report the incident to the relevant platform where it occurred.\n5. Use Cyberescue to understand your reporting options and legal rights.\n6. Contact appropriate authorities based on the guidance provided.',
      'icon': Icons.timer_outlined,
      'category': 'Emergency',
    },
    {
      'question': 'Is Cyberescue available in my country?',
      'answer': 'Cyberescue is currently available in India, with plans to expand to other countries soon. While the app focuses on Indian cyber laws and regulations, many of the resources and educational materials can be valuable to users worldwide. Our directory of legal experts is currently limited to professionals practicing in India.',
      'icon': Icons.public_outlined,
      'category': 'Availability',
    },
    {
      'question': 'What are the necessary disclaimers about using Cyberescue?',
      'answer': 'Cyberescue is a connecting platform and educational resource that does not provide legal advice directly. The information provided should not substitute professional legal counsel. Always verify credentials before engaging with listed contacts. In case of emergencies, contact local law enforcement immediately. While we vet our listed experts, Cyberescue is not responsible for the services provided by these independent professionals.',
      'icon': Icons.warning_amber_outlined,
      'category': 'Legal',
    },
    {
      'question': 'How does the AI chatbot work for cyberbullying assistance?',
      'answer': 'Our AI chatbot is designed to provide immediate support and guidance for victims of cyberbullying. It helps assess your situation, provides emotional support, suggests immediate actions to take, and directs you to appropriate resources. While the chatbot offers valuable assistance, it complements rather than replaces human expertise for complex cases.',
      'icon': Icons.chat_outlined,
      'category': 'Features',
    },
  ];

  Map<String, bool> _categoryExpanded = {};
  Map<String, List<int>> _faqsByCategory = {};
  late AnimationController _animationController;
  String _searchQuery = '';
  List<int> _filteredIndices = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    
    // Initialize categories
    _processFaqs();
    
    // Initialize all filtered indices
    _filterFaqs();
  }
  
  void _processFaqs() {
    // Group FAQs by category
    _faqsByCategory = {};
    for (int i = 0; i < faqs.length; i++) {
      final category = faqs[i]['category'] as String;
      if (!_faqsByCategory.containsKey(category)) {
        _faqsByCategory[category] = [];
        _categoryExpanded[category] = false;
      }
      _faqsByCategory[category]!.add(i);
    }
  }
  
  void _filterFaqs() {
    if (_searchQuery.isEmpty) {
      // Show all FAQs when no search
      _filteredIndices = List.generate(faqs.length, (index) => index);
    } else {
      // Filter FAQs based on search query
      _filteredIndices = [];
      for (int i = 0; i < faqs.length; i++) {
        if (faqs[i]['question']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            faqs[i]['answer']!.toLowerCase().contains(_searchQuery.toLowerCase())) {
          _filteredIndices.add(i);
        }
      }
    }
    // Reset category expansion when filtering
    if (_searchQuery.isNotEmpty) {
      _categoryExpanded.forEach((key, value) {
        _categoryExpanded[key] = true;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<String> get _categories => _faqsByCategory.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Frequently Asked Questions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.contact_support_outlined, color: Colors.white),
            onPressed: () {
              // Show additional support options
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Need More Help?', 
                      style: TextStyle(color: Color(0xFF4CAF50))),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'If you couldn\'t find the answer to your question, please contact us:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      _buildContactMethod(Icons.email_outlined, 'support@cyberescue.org'),
                      _buildContactMethod(Icons.phone_outlined, '+91 123-456-7890'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close', style: TextStyle(color: Color(0xFF4CAF50))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF5F9F5)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _filterFaqs();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search FAQs...',
                    prefixIcon: Icon(Icons.search, color: Color(0xFF66BB6A)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Color(0xFF66BB6A)),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _filterFaqs();
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _filteredIndices.isEmpty
                  ? _buildNoResultsFound()
                  : _searchQuery.isNotEmpty
                      ? _buildFilteredResults()
                      : _buildCategorizedFaqs(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Suggestion form or feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Submit your questions or feedback'),
              backgroundColor: Color(0xFF4CAF50),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              action: SnackBarAction(
                label: 'SUBMIT',
                textColor: Colors.white,
                onPressed: () {
                  // Handle submission form
                },
              ),
            ),
          );
        },
        backgroundColor: Color(0xFF4CAF50),
        child: Icon(Icons.question_answer_outlined, color: Colors.white),
        elevation: 4,
      ),
    );
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_outlined,
            size: 80,
            color: Color(0xFFAED581),
          ),
          SizedBox(height: 20),
          Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF689F38),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Try different keywords or browse all FAQs',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF9CCC65),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _filterFaqs();
              });
            },
            child: Text('View All FAQs'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CAF50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilteredResults() {
    return ListView.builder(
      itemCount: _filteredIndices.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final faqIndex = _filteredIndices[index];
        return _buildFaqItem(faqIndex);
      },
    );
  }

  Widget _buildCategorizedFaqs() {
    return ListView.builder(
      itemCount: _categories.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final category = _categories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _categoryExpanded[category] = !(_categoryExpanded[category] ?? false);
                });
              },
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(category),
                      color: Color(0xFF388E3C),
                    ),
                    SizedBox(width: 12),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF388E3C),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      (_categoryExpanded[category] ?? false)
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Color(0xFF66BB6A),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: Container(height: 0),
              secondChild: Column(
                children: _faqsByCategory[category]!.map((faqIndex) {
                  return _buildFaqItem(faqIndex);
                }).toList(),
              ),
              crossFadeState: (_categoryExpanded[category] ?? false)
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
            ),
            if (index < _categories.length - 1)
              Divider(
                color: Color(0xFFE8F5E9),
                thickness: 1.5,
                height: 32,
              ),
          ],
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'General':
        return Icons.info_outline;
      case 'Features':
        return Icons.featured_play_list_outlined;
      case 'Security':
        return Icons.security_outlined;
      case 'Usage':
        return Icons.help_outline;
      case 'Legal':
        return Icons.gavel_outlined;
      case 'Emergency':
        return Icons.emergency_outlined;
      case 'Availability':
        return Icons.public_outlined;
      default:
        return Icons.question_answer_outlined;
    }
  }

  Widget _buildFaqItem(int index) {
    final faq = faqs[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Remove divider
          ),
          child: ExpansionTile(
            leading: Icon(
              faq['icon'] as IconData,
              color: Color(0xFF4CAF50),
            ),
            title: Text(
              faq['question'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF2E7D32),
              ),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  faq['answer'],
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFF33691E),
                  ),
                ),
              ),
            ],
            childrenPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildContactMethod(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF4CAF50)),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }
}