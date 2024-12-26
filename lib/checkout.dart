import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'thankyou.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments from the navigator
    final List<Map<String, dynamic>> cartItems = ModalRoute.of(context)!
        .settings
        .arguments as List<Map<String, dynamic>>;
    double totalAmount = 0;

    // Calculate total price
    cartItems.forEach((item) {
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
        title: Text('Checkout', style: TextStyle(fontFamily: 'DynaPuff')),
        backgroundColor: Color(0xFF8D6E63), // Matching the theme color
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFCC80), Color(0xFFFFAB40)], // Warm colors to match the theme
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pembayaran:',
                      style: TextStyle(fontSize: 20, color: Colors.brown[800], fontFamily: 'DynaPuff'),
                    ),
                    Text(
                      formattedTotal,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                        fontFamily: 'DynaPuff',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                _buildTextField(
                  controller: nameController,
                  labelText: 'Nama',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: cardController,
                  labelText: 'Nomor Kartu Kredit',
                  icon: Icons.credit_card,
                  isNumber: true,
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Validasi input sebelum melanjutkan
                      if (nameController.text.isEmpty || cardController.text.isEmpty) {
                        // Tampilkan pesan kesalahan jika ada kolom yang kosong
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap isi semua kolom!')),
                        );
                        return; // Hentikan eksekusi jika ada kolom yang kosong
                      }

                      // Logic for payment processing
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pembayaran Berhasil!')),
                      );

                      // Reset the form fields
                      nameController.clear();
                      cardController.clear();

                      // Navigate to Thank You screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ThankYouScreen()),
                      );
                    },
                    icon: Icon(Icons.check_circle_outline, color: Colors.brown[800]),
                    label: Text('Bayar', style: TextStyle(fontSize: 18, fontFamily: 'DynaPuff')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.brown[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      elevation: 5,
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

  Widget _buildTextField({
    required String labelText,
    required IconData icon,
    required TextEditingController controller,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[600], fontFamily: 'DynaPuff'),
        prefixIcon: Icon(icon, color: Colors.brown[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(fontFamily: 'DynaPuff'),
    );
  }
}