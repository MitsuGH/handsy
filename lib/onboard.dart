import 'package:flutter/material.dart';
import 'navbar.dart'; // Import navbar instead of profile directly

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardPage> _pages = [
    OnboardPage(
      title: 'One-of-a-Kind Creations',
      description:
          'Shop exclusive handmade and personalized items, crafted with love by independent creators.',
      image: 'assets/images/dress-icon.png',
    ),
    OnboardPage(
      title: 'Support Local &\nIndependent Designers',
      description:
          'Every purchase empowers real artists and makers—your choice fuels creativity and sustainability.',
      image: 'assets/images/paint-icon.png',
    ),
    OnboardPage(
      title: 'Made Just for You',
      description:
          'Customize your order, chat with creators, and get items that truly reflect your style.',
      image: 'assets/images/designer-icon.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Connected curved backgrounds for each page
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: CustomPaint(
              painter: ConnectedWavePainter(currentPage: _currentPage),
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 60),

              // HANDSY logo and description - properly aligned
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Hand icon image
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/images/hand-icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // HANDSY title with increased size
                    Text(
                      'HANDSY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            28, // Increased from 24 to match other text sizes
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Separating line that spans from H to Y
                    Container(
                      width:
                          180, // Approximate width to span from H to Y of "HANDSY"
                      height: 2,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(height: 16),

                    // Description with increased size and constrained width
                    SizedBox(
                      width:
                          180, // Same width as the line to ensure text doesn't extend beyond
                      child: Text(
                        'Unique, custom pieces—made for you, not the masses.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize:
                              16, // Increased from 14 to match other text sizes
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // PageView content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return OnboardContent(page: _pages[index]);
                  },
                ),
              ),

              // Page indicators
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF6366F1)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              // Get Started button - only show on last page
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _currentPage == _pages.length - 1 ? 80 : 0,
                child: _currentPage == _pages.length - 1
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // FIXED: Navigate to MainNavigation (with navbar) instead of ProfilePage directly
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainNavigation(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6366F1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardPage {
  final String title;
  final String description;
  final String image;

  OnboardPage({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardContent extends StatelessWidget {
  final OnboardPage page;

  const OnboardContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
      ), // Increased horizontal padding for better white space
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Image positioned in the center
          SizedBox(
            height: 280,
            width: double.infinity,
            child: Image.asset(page.image, fit: BoxFit.contain),
          ),

          const SizedBox(height: 50),

          // Title with better spacing
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ), // Additional padding for text
            child: Text(
              page.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Description with better white space utilization
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ), // More generous padding
            child: Text(
              page.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

class ConnectedWavePainter extends CustomPainter {
  final int currentPage;

  ConnectedWavePainter({required this.currentPage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Same shape for all pages - using the middle page design
    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.55));

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.35);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.45,
      size.width * 0.5,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.35,
      0,
      size.height * 0.45,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ConnectedWavePainter &&
        oldDelegate.currentPage != currentPage;
  }
}
