part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class AddProduct extends ProductEvent {
  final Map<String, dynamic> data;

  AddProduct(this.data);

}
class EditProduct extends ProductEvent {
  final Map<String, dynamic> data;

  EditProduct(this.data);
}
class DeleteProduct extends ProductEvent {}
class ListProduct extends ProductEvent {}
class DetailProduct extends ProductEvent {}
