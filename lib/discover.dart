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

  final List<String> categories = [
    'All',
    'Men',
    'Women',
    'LGBTQ',
    'Accessories',
  ];

  final List<Map<String, dynamic>> allProducts = [
    // Men's Products
    {
      'id': 1,
      'title': 'Saint | Custom...',
      'price': 'B1,899',
      'image': 'assets/images/pant1.jpg',
      'fullTitle': 'Saint | Custom Hand Painted Black Jeans',
      'category': 'Men',
      'size': 'L',
      'description':
          'These jeans were inspired by the idea of angels and god. I hand-painted every detail to capture that energy, blending chaos and grace in each stroke. No two pieces are ever the same, and this one is truly one of a kind. Thank you for supporting handmade art and the stories we tell through it.',
      'isFavorite': false,
      'designer': 'handcukk',
      'rating': 4.9,
    },
    {
      'id': 2,
      'title': 'Smokewave P...',
      'price': 'B5,400',
      'image': 'assets/images/pant2.jpg',
      'fullTitle': 'Smokewave Pattern Custom Jeans',
      'category': 'Men',
      'size': 'M',
      'description':
          'Unique smokewave pattern hand-painted jeans. Each piece is meticulously crafted to create a one-of-a-kind artistic statement.',
      'isFavorite': false,
      'designer': 'TEETHYS',
      'rating': 4.8,
    },
    {
      'id': 3,
      'title': 'Galaxy Hoodie',
      'price': 'B3,200',
      'image': 'assets/images/hoodie1.jpg',
      'fullTitle': 'Galaxy Painted Hoodie',
      'category': 'Men',
      'size': 'XL',
      'description':
          'Cosmic galaxy design with vibrant colors. Perfect for standing out.',
      'isFavorite': false,
      'designer': 'ArtWear',
      'rating': 4.7,
    },
    {
      'id': 4,
      'title': 'Urban Street...',
      'price': 'B2,999',
      'image': 'assets/images/hoodie2.jpg',
      'fullTitle': 'Urban Street Art Hoodie',
      'category': 'Men',
      'size': 'L',
      'description':
          'Bold street art inspired design. Perfect for urban fashion lovers.',
      'isFavorite': false,
      'designer': 'UrbanCanvas',
      'rating': 4.6,
    },
    
    // Women's Products
    {
      'id': 5,
      'title': 'Floral Embroid...',
      'price': 'B2,800',
      'image': 'assets/images/shirt1.jpg',
      'fullTitle': 'Floral Embroidered Shirt',
      'category': 'Women',
      'size': 'M',
      'description':
          'Hand-embroidered floral patterns inspired by Thai traditional art.',
      'isFavorite': false,
      'designer': 'StitchDreams',
      'rating': 4.9,
    },
    {
      'id': 6,
      'title': 'Abstract Art...',
      'price': 'B3,500',
      'image': 'assets/images/hoodie3.jpg',
      'fullTitle': 'Abstract Art Hoodie',
      'category': 'Women',
      'size': 'S',
      'description':
          'Contemporary abstract art meets fashion. Unique piece for art enthusiasts.',
      'isFavorite': false,
      'designer': 'ArtWear',
      'rating': 4.8,
    },
    {
      'id': 7,
      'title': 'Vintage Denim...',
      'price': 'B4,200',
      'image': 'assets/images/pant1.jpg',
      'fullTitle': 'Vintage Denim Jacket',
      'category': 'Women',
      'size': 'M',
      'description':
          'Hand-painted vintage style denim jacket. Timeless piece.',
      'isFavorite': false,
      'designer': 'handcukk',
      'rating': 4.7,
    },
    {
      'id': 8,
      'title': 'Pastel Dream...',
      'price': 'B3,100',
      'image': 'assets/images/hoodie1.jpg',
      'fullTitle': 'Pastel Dream Hoodie',
      'category': 'Women',
      'size': 'S',
      'description':
          'Soft pastel colors with dreamy patterns. Perfect for everyday wear.',
      'isFavorite': false,
      'designer': 'TEETHYS',
      'rating': 4.6,
    },

    // LGBTQ Products
    {
      'id': 9,
      'title': 'Pride Painted...',
      'price': 'B3,800',
      'image': 'assets/images/hoodie2.jpg',
      'fullTitle': 'Pride Painted Hoodie',
      'category': 'LGBTQ',
      'size': 'L',
      'description':
          'Celebrate pride with this vibrant hand-painted design. Love is love.',
      'isFavorite': false,
      'designer': 'UrbanCanvas',
      'rating': 4.9,
    },
    {
      'id': 10,
      'title': 'Rainbow Spla...',
      'price': 'B4,500',
      'image': 'assets/images/pant2.jpg',
      'fullTitle': 'Rainbow Splash Jeans',
      'category': 'LGBTQ',
      'size': 'M',
      'description':
          'Bold rainbow splash design. Express yourself with pride.',
      'isFavorite': false,
      'designer': 'ArtWear',
      'rating': 4.8,
    },
    {
      'id': 11,
      'title': 'Unity Art Tee',
      'price': 'B2,200',
      'image': 'assets/images/shirt1.jpg',
      'fullTitle': 'Unity Art T-Shirt',
      'category': 'LGBTQ',
      'size': 'M',
      'description':
          'Unity and diversity in art form. Wear your pride.',
      'isFavorite': false,
      'designer': 'StitchDreams',
      'rating': 4.7,
    },

    // Accessories
    {
      'id': 12,
      'title': 'Custom Bead...',
      'price': 'B890',
      'image': 'assets/images/bracelet1.png',
      'fullTitle': 'Custom Beaded Bracelet',
      'category': 'Accessories',
      'size': 'One Size',
      'description':
          'Hand-crafted beaded bracelet with unique patterns.',
      'isFavorite': false,
      'designer': 'handcukk',
      'rating': 4.8,
    },
    {
      'id': 13,
      'title': 'Painted Cap',
      'price': 'B1,200',
      'image': 'assets/images/hoodie3.jpg',
      'fullTitle': 'Hand-Painted Baseball Cap',
      'category': 'Accessories',
      'size': 'Adjustable',
      'description':
          'Unique hand-painted cap. Stand out from the crowd.',
      'isFavorite': false,
      'designer': 'TEETHYS',
      'rating': 4.6,
    },
    {
      'id': 14,
      'title': 'Art Tote Bag',
      'price': 'B1,500',
      'image': 'assets/images/pant1.jpg',
      'fullTitle': 'Custom Art Tote Bag',
      'category': 'Accessories',
      'size': 'Large',
      'description':
          'Durable canvas tote with custom art. Eco-friendly and stylish.',
      'isFavorite': false,
      'designer': 'ArtWear',
      'rating': 4.7,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (_selectedCategory == 'All') {
      return allProducts;
    }
    return allProducts
        .where((product) => product['category'] == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategories(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  _buildFeaturedSection(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Trending Now', 'See all'),
                  const SizedBox(height: 16),
                  _buildProductsGrid(context),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Discover',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.grey[700],
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search custom pieces...',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
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
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return GestureDetector(
      onTap: () {
        // Navigate to featured collection
      },
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5B4CC4), Color(0xFF7C6FD9)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 24,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Collection',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Turn Your\nFashion Into\nArt Piece',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Explore Now',
                      style: TextStyle(
                        color: Color(0xFF6366F1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -30,
              bottom: -20,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            // See all action
          },
          child: Text(
            action,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsGrid(BuildContext context) {
    final products = filteredProducts;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(context, products[index]);
      },
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with favorite icon
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
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
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        product['isFavorite'] = !product['isFavorite'];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Icon(
                        product['isFavorite']
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: product['isFavorite']
                            ? Colors.red
                            : Colors.grey[600],
                        size: 16,
                      ),
                    ),
                  ),
                ),
                if (product['rating'] != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFFBBF24),
                            size: 12,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            product['rating'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Product info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        if (product['designer'] != null)
                          Text(
                            'by ${product['designer']}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['price'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}