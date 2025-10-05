import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> favoriteItems = [
    {
      'title': 'Custom hand...',
      'designer': 'handcukk',
      'image': 'assets/images/hoodie2.jpg', // Updated image
    },
    {
      'title': 'Smokewave P...',
      'designer': 'TEETHYS',
      'image': 'assets/images/hoodie3.jpg', // Updated image
    },
    {
      'title': 'Saint | Custo...',
      'designer': 'handcukk',
      'image': 'assets/images/bracelet1.png', // Updated image
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  // Title with count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'My Favorites',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '(${favoriteItems.length})',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Search bar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[500],
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Filter/sort action
                          },
                          icon: Icon(
                            Icons.tune,
                            color: Colors.grey[600],
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // First row with 2 items
                    Row(
                      children: [
                        Expanded(
                          child: _buildFavoriteItem(
                            favoriteItems[0]['title']!,
                            favoriteItems[0]['designer']!,
                            favoriteItems[0]['image']!,
                            context,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildFavoriteItem(
                            favoriteItems[1]['title']!,
                            favoriteItems[1]['designer']!,
                            favoriteItems[1]['image']!,
                            context,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Second row with 1 item (left aligned)
                    Row(
                      children: [
                        Expanded(
                          child: _buildFavoriteItem(
                            favoriteItems[2]['title']!,
                            favoriteItems[2]['designer']!,
                            favoriteItems[2]['image']!,
                            context,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Container()), // Empty space to maintain layout
                      ],
                    ),
                    
                    const SizedBox(height: 100), // Bottom spacing
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(
    String title,
    String designer,
    String imagePath,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image container with favorite icon
        Stack(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to placeholder if image fails to load
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Heart icon
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color.fromARGB(255, 255, 15, 15),
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Title and designer info with larger button
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    designer,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Larger view button that spans the height of both text lines
            Container(
              width: 50,
              height: 50, // Made larger to align with both text lines
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.white,
                size: 20, // Slightly larger icon
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}