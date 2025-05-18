import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'clients_options_screen.dart';
import '../screens/common_attacks_screen.dart';
import '../screens/contact_lawyers_screen.dart';
import '../screens/faqs_screens.dart';
import '../screens/chat_screen.dart';
import '../screens/lawyer_page.dart';
import '../services/chatbot_service.dart';
import '../screens/comfort_chatbot.dart';

import 'dart:math' as math;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Enhanced animated background
          LightAnimatedBackgroundEffect(),
          
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  // Logo area (top 40% of screen)
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: FadeTransition(
                        opacity: _fadeInAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo icon
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF4CAF50).withOpacity(0.4),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.shield,
                                size: 60,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                            SizedBox(height: 24),
                            
                            // Title with enhanced typography
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Color(0xFF388E3C),
                                  Color(0xFF66BB6A),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                'Cyberescue',
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            
                            // Tagline with improved styling
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F9F5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(0xFF4CAF50).withOpacity(0.3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Secure Your Digital World',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2E7D32),
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Buttons area (bottom 60% of screen)
                  Expanded(
                    flex: 6,
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Short feature highlights
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildFeatureItem(Icons.lock_outline, 'Protection'),
                                _buildFeatureItem(Icons.speed_outlined, 'Performance'),
                                _buildFeatureItem(Icons.visibility_off_outlined, 'Privacy'),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          
                          // Sign Up Button with enhanced styling
                          _buildGlowingButton(
                            'Sign Up',
                            Color(0xFF4CAF50),
                            Colors.white,
                            () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                  transitionDuration: Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          
                          // Login Button with subtle styling
                          _buildOutlinedButton(
                            'Login',
                            () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                  transitionDuration: Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                          
                          // Bottom spacer for better layout
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: Color(0xFF81C784).withOpacity(0.3), width: 1),
          ),
          child: Icon(
            icon,
            color: Color(0xFF43A047),
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF424242),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  
  Widget _buildGlowingButton(String text, Color color, Color textColor, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
  
  Widget _buildOutlinedButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF66BB6A), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF388E3C),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

// Animated background effect with light theme
class LightAnimatedBackgroundEffect extends StatefulWidget {
  @override
  _LightAnimatedBackgroundEffectState createState() => _LightAnimatedBackgroundEffectState();
}

class _LightAnimatedBackgroundEffectState extends State<LightAnimatedBackgroundEffect> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  
  @override
  void initState() {
    super.initState();
    
    _controller1 = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    )..repeat();
    
    _controller2 = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF8FDF8),
                Color(0xFFEDF7ED),
                Color(0xFFF5F9F5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        
        // Animated circles
        AnimatedBuilder(
          animation: _controller1,
          builder: (context, child) {
            return Stack(
              children: [
                // Top left circle
                Positioned(
                  top: -120 + (20 * math.sin(_controller1.value * math.pi)),
                  left: -100 + (10 * math.cos(_controller1.value * math.pi * 2)),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFFA5D6A7).withOpacity(0.2),
                          Color(0xFFA5D6A7).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Bottom right circle
                Positioned(
                  bottom: -120 + (15 * math.sin(_controller2.value * math.pi)),
                  right: -100 + (10 * math.cos(_controller2.value * math.pi * 2)),
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFF81C784).withOpacity(0.15),
                          Color(0xFF81C784).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Small accent circles
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  right: -40 + (20 * math.sin(_controller2.value * math.pi)),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFF66BB6A).withOpacity(0.1),
                          Color(0xFF66BB6A).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        
        // Light pattern overlay for tech effect
        Opacity(
          opacity: 0.6,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.imgur.com/h9qEPHL.png'),
                fit: BoxFit.cover,
                opacity: 0.02,
              ),
            ),
          ),
        ),
      ],
    );
  }
}