part of 'producto_bloc.dart';

abstract class ProductoState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductoInitial extends ProductoState {}

class ProductoLoading extends ProductoState {}

class ProductoLoaded extends ProductoState {
  final List<Product> producto;
  ProductoLoaded(this.producto);
}

class ProductoError extends ProductoState {
  final String error;
  ProductoError(this.error);
}
