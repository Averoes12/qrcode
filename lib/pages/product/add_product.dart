import 'package:flutter/material.dart';
import 'package:qrcode_app/pages/auth/bloc/auth_bloc.dart';
import 'package:qrcode_app/pages/product/bloc/product_bloc.dart';
import 'package:qrcode_app/routes/router.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController productCode = TextEditingController();
    final TextEditingController productName = TextEditingController();
    final TextEditingController productQty = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: productCode,
              decoration: const InputDecoration(
                  label: Text("Product Code"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  )
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: productName,
              decoration: const InputDecoration(
                  label: Text("Product Name"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  )
              ),
            ),
            const SizedBox(height: 24,),
            TextFormField(
              controller: productQty,
              decoration: const InputDecoration(
                  label: Text("Quantity"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  )
              ),
            ),
            const SizedBox(height: 24,),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateSuccess) {
                  context.goNamed(Routes.home);
                } else if (state is ProductStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if(state is !ProductStateLoading){
                      Map<String, dynamic> data = {
                        "code": productCode.text,
                        "name": productName.text,
                        "qty": int.parse(productQty.text)
                      };
                      context.read<ProductBloc>().add(
                          AddProduct(data)
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      )
                  ),
                  child: state is ProductStateLoading ?
                    const CircularProgressIndicator() :
                  const Text("Submit")
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
