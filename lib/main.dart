import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const ShoppingCartScreen(),
    );
  }
}

// Model untuk data produk
class Product {
  final String id;
  final String name;
  final String brand;
  final int price;
  final String imageUrl;
  int likes;
  bool isLiked;
  int quantity;
  bool isSelected;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.likes = 0,
    this.isLiked = false,
    this.quantity = 1,
    this.isSelected = false,
  });
}

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  String? productMessage;

  // Data awal produk
  List<Product> products = [
    Product(
      id: '1',
      name: 'Wireless Headphone',
      brand: 'Sony WH-CH520',
      price: 350000,
      imageUrl: 'asset/images/headphone.png',
      likes: 12,
    ),
    Product(
      id: '2',
      name: 'Laptop ASUS Vivobook',
      brand: 'ASUS',
      price: 7500000,
      imageUrl: 'asset/images/laptop.png',
      likes: 8,
    ),
    Product(
      id: '3',
      name: 'Wireless Mouse',
      brand: 'Logitech M330',
      price: 250000,
      imageUrl: 'asset/images/mouse.jpg',
      likes: 5,
    ),
  ];

  // Helper untuk format Rupiah
  String formatRupiah(int amount) {
    String priceStr = amount.toString();
    String result = '';
    int count = 0;
    for (int i = priceStr.length - 1; i >= 0; i--) {
      result = priceStr[i] + result;
      count++;
      if (count == 3 && i != 0) {
        result = '.$result';
        count = 0;
      }
    }
    return 'Rp $result';
  }

  // Menghitung total barang
  int get totalItems {
    int total = 0;
    for (var product in products) {
      total += product.quantity;
    }
    return total;
  }

  // Menghitung total harga
  int get totalPrice {
    int total = 0;
    for (var product in products) {
      total += (product.price * product.quantity);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'My Cart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Belanja lebih mudah setiap hari',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        leading: const Icon(Icons.shopping_cart, color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          if (productMessage != null) _buildProductMessage(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(product);
              },
            ),
          ),
          _buildBottomCheckoutBar(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Kategori'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Akun'),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      // Interaksi 1: Tap - Highlight produk
      onTap: () {
        setState(() {
          for (final item in products) {
            item.isSelected = false;
          }
          product.isSelected = !product.isSelected;
        });
      },
      // Interaksi 2: Double Tap - Menambah like dan mengubah warna ikon
      onDoubleTap: () {
        setState(() {
          product.isLiked = !product.isLiked;
          product.likes += product.isLiked ? 1 : -1;
        });
      },
      // Interaksi 3: Long Press - Menampilkan pesan di atas daftar produk
      onLongPress: () {
        setState(() {
          productMessage = '${product.name} telah dipilih';
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: product.isSelected ? Colors.blue : Colors.grey.shade300,
            width: product.isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    product.brand,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(product.price),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            product.isLiked ? Icons.favorite : Icons.favorite_border,
                            color: product.isLiked ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.likes.toString(),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              color: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              constraints: const BoxConstraints(
                                minWidth: 30,
                                minHeight: 30,
                              ),
                              onPressed: () {
                                if (product.quantity > 0) {
                                  setState(() {
                                    product.quantity--;
                                  });
                                }
                              },
                            ),
                            Text(
                              product.quantity.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              color: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              constraints: const BoxConstraints(
                                minWidth: 30,
                                minHeight: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  product.quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductMessage() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Produk dipilih!\n$productMessage',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70, size: 18),
            tooltip: 'Tutup pesan',
            onPressed: () {
              setState(() {
                productMessage = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckoutBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total ($totalItems produk)',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                Text(
                  formatRupiah(totalPrice),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}