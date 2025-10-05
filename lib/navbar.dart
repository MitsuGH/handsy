import 'package:flutter/material.dart';
import 'profile.dart';
import 'favorite.dart';
import 'discover.dart';
import 'home.dart';

class CustomizePage extends StatelessWidget {
  const CustomizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              const Text(
                'Customize',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const Spacer(),

              // Placeholder content
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.palette, color: Color(0xFF6366F1), size: 48),
                    SizedBox(height: 12),
                    Text(
                      'Customize Page',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Create your custom pieces',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin {
  int _selectedIndex = 4; // Start on Profile tab instead of Home (index 0)
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Widget> _pages = [
    const HomePage(),
    const DiscoverPage(),
    const CustomizePage(),
    const FavoritePage(),
    const ProfilePage(), // This will be the starting page
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      _animationController.forward().then((_) {
        setState(() {
          _selectedIndex = index;
        });
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(Icons.home_outlined, Icons.home, 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(
                  Icons.search_outlined,
                  Icons.search,
                  1,
                ),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(
                  Icons.palette_outlined,
                  Icons.palette,
                  2,
                ),
                label: 'Customize',
              ),
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(
                  Icons.favorite_outline,
                  Icons.favorite,
                  3,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(Icons.person_outline, Icons.person, 4),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(
              0xFF8B5CF6,
            ), // Updated to your brand color
            unselectedItemColor: Colors.grey[600],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            onTap: _onItemTapped,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon(
    IconData inactiveIcon,
    IconData activeIcon,
    int index,
  ) {
    final isSelected = _selectedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(isSelected ? 2.0 : 0.0),
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Icon(
          isSelected ? activeIcon : inactiveIcon,
          size: isSelected ? 26 : 24,
        ),
      ),
    );
  }
}
