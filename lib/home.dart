import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'marko',
      'handle': '@marko_customarts',
      'time': '2h',
      'text': 'Just finished this custom galaxy-painted denim jacket! The colors shift from deep purple to cosmic blue. Each piece tells a story.',
      'image': 'assets/images/galaxy-jacket.png',
      'likes': 124,
      'retweets': 18,
      'comments': 34,
      'avatar': 'assets/images/marko.jpg',
      'isLiked': false,
    },
    {
      'username': 'UrbanCanvas',
      'handle': '@urban_canvas',
      'time': '5h',
      'text': 'Hand-painted streetwear is the future! No two pieces are ever the same. That\'s the beauty of custom fashion.',
      'image': 'assets/images/colorful-jacket.jpg',
      'likes': 89,
      'retweets': 12,
      'comments': 15,
      'avatar': 'assets/images/urban-canvas.jpg',
      'isLiked': true,
    },
    {
      'username': 'StitchDreams',
      'handle': '@stitch_dreams',
      'time': '8h',
      'text': 'New embroidery technique I\'ve been working on. These floral patterns are inspired by traditional Thai art. Available for custom orders!',
      'image': 'assets/images/thai-suit.jpg',
      'likes': 256,
      'retweets': 45,
      'comments': 67,
      'avatar': 'assets/images/stitch.jpg',
      'isLiked': false,
    },
  ];

  final List<Map<String, String>> stories = [
    {'name': 'Add', 'avatar': '', 'isAdd': 'true'},
    {'name': 'handcukk', 'avatar': 'assets/images/handcukk.jpg', 'isAdd': 'false'},
    {'name': 'TEETHYS', 'avatar': 'assets/images/teethys.jpg', 'isAdd': 'false'},
    {'name': 'ArtWear', 'avatar': 'assets/images/artwear.jpg', 'isAdd': 'false'},
    {'name': 'UrbanArt', 'avatar': 'assets/images/urban.jpg', 'isAdd': 'false'},
    {'name': 'Styleco', 'avatar': 'assets/images/styleco.png', 'isAdd': 'false'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStories(),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return _buildPost(posts[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'HANDSY',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 99, 102, 241),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStories() {
  return Container(
    height: 110, // Increased from 100 to prevent overflow
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stories.length,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemBuilder: (context, index) {
        final story = stories[index];
        final isAdd = story['isAdd'] == 'true';
        
        return Container(
          width: 72,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isAdd ? null : const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  border: isAdd ? Border.all(color: Colors.grey[300]!, width: 2) : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(isAdd ? 0 : 2.5),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isAdd ? Colors.grey[100] : Colors.white,
                    ),
                    child: isAdd
                        ? Icon(Icons.add, color: Colors.grey[600], size: 28)
                        : Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipOval(
                              child: Image.asset(
                                story['avatar']!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.person, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                story['name']!,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    ),
  );
}

  Widget _buildPost(Map<String, dynamic> post, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post header
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      post['avatar'],
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Icon(Icons.person, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post['username'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 4),
                            if (index == 0)
                              const Icon(
                                Icons.verified,
                                color: Color(0xFF6366F1),
                                size: 16,
                              ),
                          ],
                        ),
                        Text(
                          '${post['handle']} · ${post['time']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Post text
              Text(
                post['text'],
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Post image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  post['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: const Icon(Icons.image, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    Icons.chat_bubble_outline,
                    post['comments'].toString(),
                    Colors.grey[600]!,
                  ),
                  _buildActionButton(
                    Icons.repeat,
                    post['retweets'].toString(),
                    Colors.grey[600]!,
                  ),
                  _buildActionButton(
                    post['isLiked'] ? Icons.favorite : Icons.favorite_outline,
                    post['likes'].toString(),
                    post['isLiked'] ? Colors.red : Colors.grey[600]!,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share_outlined,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey[200]),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String count, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          count,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}