import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: Text(
          'Thankyu',
          style: TextStyle(fontFamily: 'DynaPuff'),
        ),
        backgroundColor: Color(0xFF8D6E63), // Matching theme color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFCC80),
              Color(0xFFFFAB40),
            ], // Background gradient colors
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0), // Adding padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Paimon.png', // Replace with your image
                  height: 450,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  'Terima Kasih telah berbelanja di Wekidi! くん',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'DynaPuff',
                    color: Colors.brown[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to dashboard
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  child: Text(
                    'Home Page',
                    style: TextStyle(fontFamily: 'DynaPuff'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.brown[800],
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
