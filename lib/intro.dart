import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'navbar.dart'; // Import navbar instead of individual pages

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6366F1), // Indigo-500
              Color(0xFF8B5CF6), // Violet-500
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // HANDSY Logo
                const Text(
                  'HANDSY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),

                const Spacer(),

                // Hand Icon
                Center(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset(
                      'assets/images/hand-icon.png',
                      color: Colors.white, // This will tint the icon white
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                // Title and Subtitle
                const Text(
                  'Customized Fashion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'One-of-a-kind, just like you.',
                  style: TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 60),

                // Login Buttons
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6366F1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SignUpScreen(), // Changed from SignInScreen
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Sign Up', // Changed from 'Log In'
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Updated gradient background
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                transform: GradientRotation(
                  45 * 3.14 / 180,
                ), // 45 degrees in radians
              ),
            ),
          ),

          // Adjusted white curved container position
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28, // Adjusted position
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button with more padding
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),

                // Welcome Back text with adjusted spacing
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome\nBack',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80), // Increased spacing
                // Form section inside white container
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 32.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // Email field
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey[400],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32), // Increased spacing
                        // Password field
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.grey[400],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Add forgot password functionality
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: const Color(0xFF6C5CE7),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 48), // Increased spacing
                        // Log In button - FIXED TO NAVIGATE TO NAVBAR
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to MainNavigation instead of FavoritePage
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainNavigation(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6366F1),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Or divider
                        const Text(
                          'or',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),

                        const SizedBox(height: 24),

                        // Sign Up button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF6C5CE7)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF6C5CE7),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
