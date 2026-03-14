import 'package:equatable/equatable.dart';
import '../data/models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> allProducts;
  final List<ProductModel> filtered;
  final String selectedCategory;

  const ProductLoaded({
    required this.allProducts,
    required this.filtered,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [allProducts, filtered, selectedCategory];

  ProductLoaded copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? filtered,
    String? selectedCategory,
  }) =>
      ProductLoaded(
        allProducts: allProducts ?? this.allProducts,
        filtered: filtered ?? this.filtered,
        selectedCategory: selectedCategory ?? this.selectedCategory,
      );
}

class ProductFailure extends ProductState {
  final String message;
  const ProductFailure(this.message);
  @override
  List<Object?> get props => [message];
}