import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'favorites_manager.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _searchController = TextEditingController();
  final FavoritesManager _favoritesManager = FavoritesManager();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _trendingKey = GlobalKey();
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
      'title': 'Saint Custom Jeans',
      'price': 'B1,899',
      'image': 'assets/images/pant1.jpg',
      'fullTitle': 'Saint | Custom Hand Painted Black Jeans',
      'category': 'Men',
      'size': 'L',
      'description':
          'These jeans were inspired by the idea of angels and god. I hand-painted every detail to capture that energy, blending chaos and grace in each stroke. No two pieces are ever the same, and this one is truly one of a kind. Thank you for supporting handmade art and the stories we tell through it.',
      'designer': 'handcukk',
      'rating': 4.9,
    },
    {
      'id': 2,
      'title': 'Sun and Moon jeans',
      'price': 'B5,400',
      'image': 'assets/images/moon-jean.png',
      'fullTitle': 'Sun and Moon | Custom hand painted jeans',
      'category': 'Men',
      'size': 'M',
      'description':
          'The design is inspired by the sum and moon animatronics from Five Nights At Freddy.',
      'designer': 'handcukk',
      'rating': 4.8,
    },
    {
      'id': 3,
      'title': 'Jesus is Lord Hoodie',
      'price': 'B3,200',
      'image': 'assets/images/hoodie1.jpg',
      'fullTitle': 'Jesus is Lord Hoodie',
      'category': 'Men',
      'size': 'XL',
      'description':
          'Jesus is Lord themed hoodie with intricate hand-painted design. A bold statement piece for faith and fashion.',
      'designer': 'ArtWear',
      'rating': 4.7,
    },
    {
      'id': 4,
      'title': 'Rise In Hell',
      'price': 'B2,999',
      'image': 'assets/images/orange-skull-sweater.jpg',
      'fullTitle': 'Urban Canvas | Rise In Hell Sweater',
      'category': 'Men',
      'size': 'L',
      'description':
          'No flesh, no corpse, but soul',
      'designer': 'UrbanCanvas',
      'rating': 4.6,
    },
    
    // Women's Products
    {
      'id': 5,
      'title': 'Snow White Sweater',
      'price': 'B2,800',
      'image': 'assets/images/snowwhite-jacket.jpg',
      'fullTitle': 'Woahmen | Snow White hand painted jacket',
      'description':
          'Snow White themed hand-painted jacket with elegant design. A fairy tale come to life in fashion.',
      'designer': 'Woahmen',
      'rating': 4.9,
    },
    {
      'id': 6,
      'title': 'Harajuku Hand Hoodie',
      'price': 'B3,500',
      'image': 'assets/images/harajuku-hoodie.jpg',
      'fullTitle': 'Japanese Harajuku Hand Painted Hoodie',
      'category': 'Women',
      'size': 'S',
      'description':
          'Harajuku style hand-painted hoodie with vibrant colors and bold designs.',
      'designer': 'ArtWear',
      'rating': 4.8,
    },
    {
      'id': 7,
      'title': 'POWERFUL Women Vintage Jeans',
      'price': 'B4,200',
      'image': 'assets/images/cute-jean.jpg',
      'fullTitle': 'POWERFUL Women Vintage Jeans',
      'category': 'Women',
      'size': 'M',
      'description':
          'Women empowerment themed vintage jeans with unique hand-painted design.',
      'designer': 'Woahmen',
      'rating': 4.7,
    },

    // LGBTQ Products
    {
      'id': 9,
      'title': 'Pride Painted Jacket',
      'price': 'B3,800',
      'image': 'assets/images/lgbtq-jacket.jpg',
      'fullTitle': 'Pride Painted Hoodie',
      'category': 'LGBTQ',
      'size': 'L',
      'description':
          'Celebrate pride with this vibrant hand-painted design. Love is love.',
      'designer': 'GaySlay',
      'rating': 4.9,
    },

    // Accessories
    {
      'id': 12,
      'title': 'Faith Over Fear Bracelet',
      'price': 'B890',
      'image': 'assets/images/bracelet1.png',
      'fullTitle': 'Faith Over Fear Custom Silver Bracelet',
      'category': 'Accessories',
      'size': 'One Size',
      'description':
          'Silver bracelet inspired by the power of believes in the Bible.',
      'designer': 'Lord of All',
      'rating': 4.8,
    },
    {
      'id': 13,
      'title': 'Jesus Ring',
      'price': 'B1,200',
      'image': 'assets/images/ring1.jpg',
      'fullTitle': 'Custom made Jesus silver ring',
      'category': 'Accessories',
      'size': 'One Size',
      'description':
          'One of one silver ring with Jesus face engraved. Unique and meaningful.',
      'designer': 'Lord of All',
      'rating': 4.6,
    },
    {
      'id': 14,
      'title': 'Art Tote Bag',
      'price': 'B1,500',
      'image': 'assets/images/art-bag.jpg',
      'fullTitle': 'Custom Art Tote Bag',
      'category': 'Accessories',
      'size': 'Large',
      'description':
          'Durable canvas tote with custom art. Eco-friendly and stylish.',
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
                controller: _scrollController,
                padding: const EdgeInsets.all(24.0),
                children: [
                  _buildFeaturedSection(),
                  const SizedBox(height: 32),
                  Container(
                    key: _trendingKey,
                    child: _buildSectionHeader('Trending Now', 'See all'),
                  ),
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
              onPressed: () {},
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
        // Scroll to trending section
        final RenderBox? renderBox = _trendingKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final offset = renderBox.localToGlobal(Offset.zero).dy;
          _scrollController.animateTo(
            _scrollController.offset + offset - 100,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 220, // Increased from 180 to 220
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
                  const SizedBox(height: 20), // Increased from 16 to 20 for more space
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
            // Artist image on the right
            Positioned(
              right: 0,
              top: 20,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  'assets/images/artist.png',
                  height: 200,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    );
                  },
                ),
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
                  color: Colors.white.withOpacity(0.05),
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
          onTap: () {},
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
    return AnimatedBuilder(
      animation: _favoritesManager,
      builder: (context, child) {
        final isFavorite = _favoritesManager.isFavorite(product['id']);
        
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
                          _favoritesManager.toggleFavorite(product);
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavorite 
                                    ? 'Removed from favorites' 
                                    : 'Added to favorites',
                              ),
                              backgroundColor: Colors.black87,
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
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
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: isFavorite
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
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}