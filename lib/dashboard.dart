import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'database/database_helper.dart';
import 'product_list.dart'; // Ensure this import is correct

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await DatabaseHelper().getProducts();
      setState(() {
        _products = products ?? []; // Ensure it's not null
      });
    } catch (e) {
      _showSnackBar(context, 'Failed to load products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            fontFamily: 'DynaPuff', // Use DynaPuff font
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF8D6E63),
        automaticallyImplyLeading: false, // Prevents the back arrow from showing
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildImage(),
            _buildMenuButton(),
            _buildProductList(),
            _buildIconRow(),
          ],
        ),
      ),
      backgroundColor: Color(0xFFFFCC80),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tempat Makan Yang Paling Enak Itu Cuma Ada Disini',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.brown[800],
            fontFamily: 'DynaPuff',
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Wekidiくん Merupakan Restoran Fast Food Yang Baru Saja Buka Pada Tanggal 01/11/2022 Di Isekai...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.brown[600],
            fontFamily: 'DynaPuff',
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildImage() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/images/PaimonWekidi.png',
          width: 380,
          height: 380,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8D6E63),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductList(),
            ),
          );
        },
        child: Text(
          'Menu Produk',
          style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'DynaPuff'),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product['name'] ?? 'Unknown Product'),
            subtitle: Text(product['description'] ?? 'No Description'),
            leading: Image.asset(product['image_path'] ?? 'assets/images/default.png'), // Provide a default image
            onTap: () {
              // Tampilkan deskripsi produk
            },
          );
        },
      ),
    );
  }

  Widget _buildIconRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10), // Padding for the icon row
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the icon row
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.brown[800], size: 30),
            onPressed: () {
              _makeWhatsAppCall('+6285156504046', context);
            },
          ),
          IconButton(
            icon: Icon(Icons.message, color: Colors.brown[800], size: 30),
            onPressed: () {
              _sendWhatsAppMessage('+6285156504046', context);
            },
          ),
          IconButton(
            icon: Icon(Icons.location_on, color: Colors.brown[800], size: 30),
            onPressed: () {
              _launchMaps('https://www.google.com/maps', context);
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.brown[800], size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.brown[800], size: 30),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _makeWhatsAppCall(String phoneNumber, BuildContext context) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      _showSnackBar(context, 'Could not launch WhatsApp');
    }
  }

  Future<void> _sendWhatsAppMessage(String phoneNumber, BuildContext context) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber?text=Hallo, Saya Ingin Memesan Burger Wekidi...');
    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      _showSnackBar(context, 'Could not send message via WhatsApp');
    }
  }

  Future<void> _launchMaps(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showSnackBar(context, 'Could not launch Maps');
    }
  }
}
