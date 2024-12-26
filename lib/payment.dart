import 'package:flutter/material.dart';
import 'database/database_helper.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Nama')),
            TextField(decoration: InputDecoration(labelText: 'Total Harga')),
            ElevatedButton(
              onPressed: () {
                // Logic pembayaran
              },
              child: Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
