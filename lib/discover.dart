import 'package:flutter/material.dart';
import 'product_detail.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<String> categories = ['All', 'Men', 'Women', 'LGBTQ'];

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'title': 'Saint | Custom...',
      'price': 'B1,899',
      'image': 'assets/images/pant1.jpg',
      'fullTitle': 'Saint | Custom Hand Painted Black Jeans',
      'category': 'Jeans Men',
      'size': 'L',
      'description':
          'These jeans were inspired by the idea of angels and god. I hand-painted every detail to capture that energy, blending chaos and grace in each stroke. No two pieces are ever the same, and this one is truly one of a kind. Thank you for supporting handmade art and the stories we tell through it.',
      'isFavorite': false,
    },
    {
      'id': 2,
      'title': 'Smokewave P...',
      'price': 'B5,400',
      'image': 'assets/images/pant2.jpg',
      'fullTitle': 'Smokewave Pattern Custom Jeans',
      'category': 'Jeans Men',
      'size': 'M',
      'description':
          'Unique smokewave pattern hand-painted jeans. Each piece is meticulously crafted to create a one-of-a-kind artistic statement.',
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                _buildSearchBar(),

                const SizedBox(height: 24),

                // Categories
                _buildCategories(),

                const SizedBox(height: 24),

                // Hero card
                _buildHeroCard(context),

                const SizedBox(height: 32),

                // Popular Design section
                const Text(
                  'Popular Design',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                // Products grid
                _buildProductsGrid(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          suffixIcon: IconButton(
            onPressed: () {
              // Filter action
            },
            icon: Icon(Icons.tune, color: Colors.grey[700]),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = _selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to customize page or specific action
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5B4CC4), Color(0xFF7C6FD9)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            // Text content
            Positioned(
              left: 24,
              top: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Turn Your',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const Text(
                    'Fashion To',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const Text(
                    'Art Piece',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Customize',
                      style: TextStyle(
                        color: Color(0xFF6366F1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Image
            Positioned(
              right: -20,
              bottom: 0,
              child: Container(
                width: 180,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/artist.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildProductCard(context, products[0])),
        const SizedBox(width: 16),
        Expanded(child: _buildProductCard(context, products[1])),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with favorite icon
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
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
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    product['isFavorite']
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: product['isFavorite']
                        ? Colors.red
                        : Colors.grey[600],
                    size: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Product info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['price'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
