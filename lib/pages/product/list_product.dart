import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_app/models/product/product.dart';
import 'package:qrcode_app/pages/auth/bloc/auth_bloc.dart';
import 'package:qrcode_app/pages/product/bloc/product_bloc.dart';
import 'package:qrcode_app/routes/router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot<Product>>(
          stream: context.read<ProductBloc>().streamProducts(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(!snapshot.hasData){
              return const Center(
                child: Text("Nothing data found, add data first!"),
              );
            }
            if(snapshot.hasError){
              return const Center(
                child: Text("Something wrong occurred, Please try again later!"),
              );
            }

            List<Product> allProducts = [];
            for(var element in snapshot.data!.docs){
              allProducts.add(element.data());
            }

            return ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (context, index){
                Product product = allProducts[index];
                return GestureDetector(
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.code.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 4,),
                              Text(product.name.toString()),
                              const SizedBox(height: 4,),
                              Text("Total: ${product.qty}"),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: QrImageView(
                              data: product.code!,
                              size: 200,
                              version: QrVersions.auto,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    context.goNamed(Routes.detailProduct, queryParameters: {"code": product.code, "name": product.name, "qty": product.qty.toString()});
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
