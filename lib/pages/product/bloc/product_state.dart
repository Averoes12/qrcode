part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductStateInitial extends ProductState {}
final class ProductStateSuccess extends ProductState {}
final class ProductStateError extends ProductState {
  ProductStateError(this.message);

  final String message;
}
final class ProductStateLoading extends ProductState {}
