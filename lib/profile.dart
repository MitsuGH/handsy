import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false;

  // Sample data - replace with actual user data
  final List<String> userPosts = [
    'assets/images/shirt1.jpg',
    'assets/images/hoodie1.jpg',
    'assets/images/ring1.jpg',
    'assets/images/pant1.jpg',
    'assets/images/pant2.jpg',
    'assets/images/necklace1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileInfo(),
                    _buildBioSection(),
                    _buildActionButtons(),
                    const SizedBox(height: 20),
                    _buildPostsGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24), // Balance the right icon
          const Text(
            'johncm',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              // Menu action
            },
            icon: const Icon(Icons.more_horiz, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ), // Increased horizontal padding
      child: Row(
        children: [
          // Profile picture with floating border
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: const EdgeInsets.all(2.0), // Added white space
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White space between image and border
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 30),

          // Stats
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('20', 'Posts'),
                _buildStatColumn('2', 'Followers'),
                _buildStatColumn('6', 'Following'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B5CF6), // Updated purple color
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0), // Increased padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'John Chuerman',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Clothing brand owner and designer',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              children: const [
                TextSpan(text: 'Followed by '),
                TextSpan(
                  text: 'lilmitzzz',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              children: const [
                TextSpan(
                  text: 'believer_apparel.com',
                  style: TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: '2 other links',
                  style: TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ), // Increased padding
      child: Row(
        children: [
          // Follow/Unfollow button
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFollowing = !isFollowing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFollowing
                      ? Colors.grey[200]
                      : const Color(0xFF8B5CF6), // Updated purple color
                  foregroundColor: isFollowing ? Colors.black : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isFollowing ? 'Following' : 'Follow',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Message button
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 32,
              child: OutlinedButton(
                onPressed: () {
                  // Message action
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.grey[300]!, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Message',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: userPosts.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Image.asset(userPosts[index], fit: BoxFit.cover),
        );
      },
    );
  }
}
