import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _username = '';
  String _password = '';

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Simpan username dan password ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _name);
      await prefs.setString('username', _username);
      await prefs.setString('password', _password);

      // Menampilkan notifikasi pendaftaran berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pendaftaran berhasil!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigasi ke layar login setelah registrasi berhasil
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF2A65A),
              Color(0xFFD76D2E),
              Color(0xFF7B3E19),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.person_add, color: Colors.white, size: 80),
                  SizedBox(height: 20),
                  Text(
                    'Create an Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'DynaPuff'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Register to get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70, fontFamily: 'DynaPuff'),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.brown[800]),
                      filled: true,
                      fillColor: Colors.orange[100],
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.brown[800], fontFamily: 'DynaPuff'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                    onChanged: (value) => _name = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline, color: Colors.brown[800]),
                      filled: true,
                      fillColor: Colors.orange[100],
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.brown[800], fontFamily: 'DynaPuff'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter your username' : null,
                    onChanged: (value) => _username = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.brown[800]),
                      filled: true,
                      fillColor: Colors.orange[100],
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.brown[800], fontFamily: 'DynaPuff'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    obscureText: true,
                    validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
                    onChanged: (value) => _password = value,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: _register,
                    child: Text('Register', style: TextStyle(fontSize: 18, fontFamily: 'DynaPuff')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
