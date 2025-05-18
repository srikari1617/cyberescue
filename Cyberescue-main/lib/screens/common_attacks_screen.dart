import 'package:flutter/material.dart';
import 'package:cyberescue/screens/request_page.dart';

class CommonAttacksScreen extends StatefulWidget {
  @override
  _CommonAttacksScreenState createState() => _CommonAttacksScreenState();
}

class _CommonAttacksScreenState extends State<CommonAttacksScreen>
    with SingleTickerProviderStateMixin {
  final Map<String, Map<String, String>> _attacks = {
    'Phishing Attack': {
      'description':
          'Phishing involves sending fraudulent emails or messages to trick individuals into sharing sensitive information like passwords or credit card details.',
      'legalActions':
          'Phishing is punishable under Section 66D of the IT Act, 2000, for impersonation. Violators can face imprisonment of up to 3 years and/or a fine.',
      'steps':
          '1. Avoid clicking on suspicious links in emails or messages.\n2. Report phishing attempts to your email provider.\n3. File a complaint at your local cybercrime office.',
      'icon': 'email',
    },
    'Social Engineering Attack': {
      'description':
          'Social engineering manipulates individuals into divulging confidential information, often by pretending to be a trustworthy entity.',
      'legalActions':
          'Social engineering tactics may violate Section 66C and Section 66D of the IT Act for identity theft and impersonation. Complaints can be lodged with the Cyber Crime Cell.',
      'steps':
          '1. Verify requests for personal information independently.\n2. Educate yourself about common social engineering tactics.\n3. Report incidents to the concerned authorities.',
      'icon': 'people',
    },
    'Ransomware Attack': {
      'description':
          'Ransomware is a malicious software that locks your data and demands payment for its release.',
      'legalActions':
          'Ransomware attacks are punishable under Section 43 and Section 66 of the IT Act, 2000. It is also categorized as extortion under Section 384 of the Indian Penal Code.',
      'steps':
          '1. Disconnect your device from the internet immediately.\n2. Do not pay the ransom as it encourages more attacks.\n3. Contact cybersecurity experts and report the incident to cybercrime authorities.',
      'icon': 'lock',
    },
    'Spoofing': {
      'description':
          'Spoofing involves disguising communication (email, calls, etc.) to appear as though its coming from a trusted source.',
      'legalActions':
          'Spoofing is covered under Section 66C of the IT Act, which penalizes identity theft. Violators can face up to 3 years of imprisonment and/or a fine.',
      'steps':
          '1. Use secure and verified communication channels.\n2. Avoid sharing sensitive information unless sure of the source.\n3. Report the incident to the relevant authorities.',
      'icon': 'masks',
    },
    'SIM Card Swapping Attack': {
      'description':
          'SIM swapping allows attackers to take control of your phone number to intercept calls and messages, often to access financial accounts.',
      'legalActions':
          'Such attacks fall under Sections 66C and 66D of the IT Act for identity theft and impersonation. Complaints can also be filed under banking fraud laws.',
      'steps':
          '1. Contact your mobile service provider to lock your SIM.\n2. Inform your bank to secure your accounts.\n3. File a cybercrime report immediately.',
      'icon': 'sim_card',
    },
    'Vishing Attack': {
      'description':
          'Vishing (voice phishing) uses phone calls to trick victims into revealing personal and financial details.',
      'legalActions':
          'Vishing is penalized under Section 66D of the IT Act for impersonation and cheating. You can file a complaint with your telecom service provider or cybercrime portal.',
      'steps':
          '1. Do not disclose sensitive details over phone calls.\n2. Verify the callers identity before responding.\n3. Report suspicious calls to your service provider and authorities.',
      'icon': 'phone',
    },
    'Password Attack': {
      'description':
          'Password attacks aim to gain unauthorized access to accounts by cracking or stealing passwords.',
      'legalActions':
          'Password theft is punishable under Section 43 and Section 66 of the IT Act, 2000, for unauthorized access and data theft.',
      'steps':
          '1. Change your password immediately if compromised.\n2. Enable two-factor authentication for added security.\n3. Report unauthorized access to the service provider and cybercrime authorities.',
      'icon': 'password',
    },
    'Cyber Bullying': {
      'description':
          'Cyberbullying involves using digital platforms like social media or messaging apps to harass or harm someone emotionally or mentally.',
      'legalActions':
          'Cyberbullying is punishable under Section 67 of the IT Act, which prohibits publishing offensive content online. It can also be addressed under IPC Sections 507 (criminal intimidation) and 509 (outraging modesty).',
      'steps':
          '1. Block and report the bully on the platform.\n2. Take screenshots as evidence.\n3. File a complaint with the Cyber Crime Cell or at https://cybercrime.gov.in/.',
      'icon': 'sentiment_very_dissatisfied',
    },
  };

  String? _selectedAttack;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData _getIconForAttack(String attack) {
    switch (_attacks[attack]!['icon']) {
      case 'email':
        return Icons.email_outlined;
      case 'people':
        return Icons.people_outline;
      case 'lock':
        return Icons.lock_outline;
      case 'masks':
        return Icons.masks;
      case 'sim_card':
        return Icons.sim_card_outlined;
      case 'phone':
        return Icons.phone_outlined;
      case 'password':
        return Icons.password_outlined;
      case 'sentiment_very_dissatisfied':
        return Icons.sentiment_very_dissatisfied_outlined;
      default:
        return Icons.security_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Common Attacks',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // Show info about this screen
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('About Common Attacks',
                      style: TextStyle(color: Color(0xFF4CAF50))),
                  content: Text(
                    'This section helps you understand various cyber attacks, legal implications, and steps to take if you become a victim.',
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close',
                          style: TextStyle(color: Color(0xFF4CAF50))),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select an Attack Type:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF388E3C),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFBBDEBB)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedAttack,
                      hint: Text(
                        'Select an Attack',
                        style: TextStyle(color: Color(0xFF66BB6A)),
                      ),
                      isExpanded: true,
                      icon:
                          Icon(Icons.arrow_drop_down, color: Color(0xFF66BB6A)),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAttack = newValue;
                          // Restart animation when new attack is selected
                          _animationController.reset();
                          _animationController.forward();
                        });
                      },
                      items: _attacks.keys
                          .map<DropdownMenuItem<String>>((String attack) {
                        return DropdownMenuItem<String>(
                          value: attack,
                          child: Row(
                            children: [
                              Icon(
                                _getIconForAttack(attack),
                                color: Color(0xFF66BB6A),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Text(
                                attack,
                                style: TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_selectedAttack != null)
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: SingleChildScrollView(
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF66BB6A).withOpacity(0.15),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    _getIconForAttack(_selectedAttack!),
                                    color: Color(0xFF388E3C),
                                    size: 30,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      _selectedAttack!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoSection(
                                    'Description',
                                    _attacks[_selectedAttack]!['description']!,
                                    Icons.info_outline,
                                  ),
                                  Divider(
                                      height: 30,
                                      thickness: 1,
                                      color: Color(0xFFE8F5E9)),
                                  _buildInfoSection(
                                    'Legal Actions',
                                    _attacks[_selectedAttack]!['legalActions']!,
                                    Icons.gavel_outlined,
                                  ),
                                  Divider(
                                      height: 30,
                                      thickness: 1,
                                      color: Color(0xFFE8F5E9)),
                                  _buildInfoSection(
                                    'Steps to Follow',
                                    _attacks[_selectedAttack]!['steps']!,
                                    Icons.checklist_outlined,
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: Icon(Icons.report_outlined),
                                        label: Text('Report Attack'),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RequestPage(
                                                        userType: 'user')),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF4CAF50),
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (_selectedAttack == null)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.security_outlined,
                          size: 80,
                          color: Color(0xFFAED581),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Select an attack type to learn more',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF689F38),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Stay informed, stay safe',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CCC65),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show emergency contacts or help
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Contacts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildContactItem(
                      'National Cyber Crime Reporting Portal', '1930'),
                  _buildContactItem('Women Helpline', '1091'),
                  _buildContactItem('Police', '100'),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Close',
                        style: TextStyle(color: Color(0xFF4CAF50)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: Color(0xFF4CAF50),
        child: Icon(Icons.phone_forwarded_outlined, color: Colors.white),
        elevation: 4,
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Color(0xFF4CAF50),
              size: 22,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF388E3C),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFDCEDC8),
              width: 1,
            ),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF33691E),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(String name, String number) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8F5E9),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                number,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF66BB6A),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.call_outlined,
              color: Color(0xFF4CAF50),
            ),
            onPressed: () {
              // Handle call functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $number...'),
                  backgroundColor: Color(0xFF4CAF50),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
