import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'favorites_manager.dart';
import 'product_service.dart';

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
  final ProductService _productService = ProductService();
  
  String _selectedCategory = 'All';
  List<Map<String, dynamic>> allProducts = [];
  bool isLoading = true;

  final List<String> categories = [
    'All',
    'Men',
    'Women',
    'LGBTQ',
    'Accessories',
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Load products from Firestore
  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final products = await _productService.getAllProducts();
      setState(() {
        allProducts = products;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

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
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6366F1),
                      ),
                    )
                  : allProducts.isEmpty
                      ? _buildEmptyState()
                      : ListView(
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new items',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
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
        height: 220,
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
                  const SizedBox(height: 20),
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
        // Convert ID to string to handle both int and String types
        final productId = product['id'].toString();
        final isFavorite = _favoritesManager.isFavorite(productId);
        
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
                        child: Image.network(
                          product['image'] ?? '',
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
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: const Color(0xFF6366F1),
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
                              product['title'] ?? 'Untitled',
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
                              product['price'] ?? 'B0',
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