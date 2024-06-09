import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:qrcode_app/models/product/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Product>> streamProducts() async* {
    yield* firestore
        .collection("products")
        .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson()
    ).snapshots();
  }

  ProductBloc() : super(ProductStateInitial()) {
    on<AddProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());
        var result = await firestore.collection("products").add(event.data);
        await firestore.collection("products").doc(result.id).update(
          {
            "uid": result.id
          }
        );
        emit(ProductStateSuccess());
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message.toString() ?? "Failed to added product"));
      } catch (e){
        emit(ProductStateError(e.toString() ?? "Failed to added product"));
      }
    });
    on<EditProduct>((event, emit) {

    });
    on<DeleteProduct>((event, emit){

    });
  }
}
