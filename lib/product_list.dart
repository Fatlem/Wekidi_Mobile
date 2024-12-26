import 'package:flutter/material.dart';
import 'model/product.dart';
import 'cart.dart';
import 'dashboard.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Map<String, dynamic>> cartItems = [];
  final List<Product> products = [
    Product(
      name: 'Barbarian Burger',
      description: 'Spicy Burger With Onion Ring And Blaster Beef.',
      price: 60000,
      imageUrl: 'assets/images/BarbarianBurger4.png',
    ),
    Product(
      name: 'Chibi Burger',
      description: 'Delicious burger with unique flavors.',
      price: 25000,
      imageUrl: 'assets/images/ChibiBurger2.png',
    ),
    Product(
      name: 'Melted Burger',
      description: 'Melted cheese and savory beef.',
      price: 40000,
      imageUrl: 'assets/images/MeltedBurger3.png',
    ),
    Product(
      name: 'Melted LOL Burger',
      description: 'A fun twist on the classic burger.',
      price: 40000,
      imageUrl: 'assets/images/MeltedLOLBurger1.png',
    ),
  ];

  List<int> quantities = List.filled(4, 0); // Initialize quantities

  void addToCart(Product product, int quantity) {
    for (var item in cartItems) {
      if (item['product'] == product) {
        item['quantity'] += quantity;
        return;
      }
    }
    cartItems.add({'product': product, 'quantity': quantity});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Produk', style: TextStyle(fontFamily: 'DynaPuff')),
        backgroundColor: Color(0xFF8D6E63), // Burger-themed color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigasi kembali ke halaman Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()), // Ganti dengan nama halaman dashboard Anda
            );
          },
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8, // Controls card height ratio
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(
            onTap: () {
              // Navigate to product description page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDescription(product: product),
                ),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DynaPuff',
                          ),
                        ),
                        Text(
                          product.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'DynaPuff',
                            color: Colors.brown[600],
                          ),
                        ),
                        Text(
                          'Rp ${product.price}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700],
                            fontFamily: 'DynaPuff',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantities[index] > 0) quantities[index]--;
                                });
                              },
                            ),
                            Text(
                              quantities[index].toString(),
                              style: TextStyle(fontFamily: 'DynaPuff'),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantities[index]++;
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (quantities[index] > 0) {
                              addToCart(product, quantities[index]);
                              setState(() {
                                quantities[index] = 0; // Reset quantity
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Ditambahkan ke keranjang')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8D6E63),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Tambahkan ke Keranjang',
                            style: TextStyle(fontFamily: 'DynaPuff', fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Color(0xFF8D6E63),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(cartItems: cartItems),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  'Keranjang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DynaPuff',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFCC80),
    );
  }
}

class ProductDescription extends StatelessWidget {
  final Product product;

  ProductDescription({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: TextStyle(fontFamily: 'DynaPuff'), // Use custom font
        ),
        backgroundColor: Color(0xFF8D6E63), // Burger-themed color
      ),
      body: Stack(
        children: [
          // Fullscreen image with slight upward shift
          Positioned(
            top: -40, // Adjusted upward position of the image
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)), // Rounded corners for the image
              child: Image.asset(
                product.imageUrl, // Use the image from assets
                fit: BoxFit.cover, // Maintain image aspect ratio
                height: 360, // Slightly increased height for better visibility
              ),
            ),
          ),
          // Overlay with padding for description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                SizedBox(height: 300), // Space for the image
                // Displaying the product description container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // Slightly less transparent for better visibility
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 10, // Soft shadow
                        offset: Offset(0, 5), // Position of the shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0), // Padding for text
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'DynaPuff', // Use custom font
                          color: Colors.brown[600], // Color to match theme
                        ),
                      ),
                      SizedBox(height: 12.0), // More space before the price
                      Text(
                        'Rp ${product.price}', // Displaying the price
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DynaPuff', // Use custom font
                          color: Colors.green[700], // Color to match theme
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFCC80), // Matching burger-inspired background
    );
  }
}
