import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detail Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: QrImageView(
                data: product['code'],
                size: 200,
                version: QrVersions.auto,
              ),
            ),
            const SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Product Code", style: TextStyle(fontWeight: FontWeight.bold),),
                Text(product['code'])
              ],
            ),
            const SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold),),
                Text(product['name'])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold),),
                Text(product['qty'].toString())
              ],
            )
          ],
        ),
      ),
    );
  }
}
