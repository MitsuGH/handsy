import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'onboard.dart';
import 'auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Account created successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );

        // Navigate to onboard screen on successful sign up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardScreen()),
        );
      }
    } on AuthException catch (e) {
      _showErrorMessage(e.message);
    } catch (e) {
      _showErrorMessage('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Updated gradient background (matching sign_in.dart)
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                transform: GradientRotation(45 * 3.14 / 180),
              ),
            ),
          ),

          // White curved container
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
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
                // Back button
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

                // Create Account text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Create\nAccount',
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

                const SizedBox(height: 80),

                // Form section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),

                          // Name field with validation
                          TextFormField(
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              if (value.trim().length < 2) {
                                return 'Name must be at least 2 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.grey[400],
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF6366F1)),
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Email field with validation
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
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
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF6366F1)),
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Password field with validation
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[400],
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[400],
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF6366F1)),
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),

                          const SizedBox(height: 48),

                          // Sign Up button with loading state
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _signUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                disabledBackgroundColor: Colors.grey[300],
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      'Sign Up',
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

                          // Log In button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
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
                                'Log In',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}