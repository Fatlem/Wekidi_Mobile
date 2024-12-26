import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/product.dart';
import 'database/database_helper.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  Cart({required this.cartItems});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (widget.cartItems[index]['quantity'] > 1) {
        widget.cartItems[index]['quantity']--;
      } else {
        _removeItem(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;

    // Calculate total price
    widget.cartItems.forEach((item) {
      totalAmount += item['product'].price * item['quantity'];
    });

    // Format totalAmount to Rupiah
    final formattedTotal = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(totalAmount);

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja', style: TextStyle(fontFamily: 'DynaPuff')),
        backgroundColor: Color(0xFF8D6E63), // Burger-themed color for AppBar
        elevation: 0,
      ),
      body: SafeArea(
        child: widget.cartItems.isEmpty
            ? Center(
          child: Text(
            'Keranjang Anda kosong',
            style: TextStyle(fontSize: 20, color: Colors.grey[400], fontFamily: 'DynaPuff'),
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            final item = widget.cartItems[index];
            Product product = item['product'];
            int quantity = item['quantity'];

            return Dismissible(
              key: UniqueKey(),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _removeItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} dihapus dari keranjang'),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                                fontFamily: 'DynaPuff', // Use DynaPuff font
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Rp ${NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: '',
                                decimalDigits: 0,
                              ).format(product.price * quantity)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'DynaPuff', // Use DynaPuff font
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline, color: Color(0xFF8D6E63)),
                            onPressed: () => _decreaseQuantity(index),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DynaPuff', // Use DynaPuff font
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, color: Color(0xFF8D6E63)),
                            onPressed: () {
                              setState(() {
                                widget.cartItems[index]['quantity']++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedTotal,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8D6E63), // Burger-themed color for total
                    fontFamily: 'DynaPuff', // Use DynaPuff font
                  ),
                ),
                ElevatedButton(
                  onPressed: widget.cartItems.isEmpty
                      ? null
                      : () {
                    Navigator.pushNamed(
                      context,
                      '/checkout',
                      arguments: widget.cartItems,
                    );
                  },
                  child: Text('Checkout', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8D6E63), // Button color matching the theme
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
