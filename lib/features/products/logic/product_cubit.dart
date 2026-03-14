import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../data/models/product_model.dart';
import '../data/repos/product_repo.dart';
import 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  final ProductRepo _productRepo;

  ProductCubit(this._productRepo) : super(ProductInitial());

  static const String allCategory = 'All';

  Future<void> loadProducts() async {
    emit(ProductLoading());
    try {
      await _productRepo.seedProducts(); // seeds if Firestore is empty
      final products = await _productRepo.getProducts();
      emit(ProductLoaded(
        allProducts: products,
        filtered: products,
        selectedCategory: allCategory,
      ));
    } on Exception catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  // ── Search ────────────────────────────────────────────────────────────────
  void search(String query) {
    final current = state;
    if (current is! ProductLoaded) return;

    final q = query.toLowerCase().trim();
    final filtered = current.allProducts.where((p) {
      final matchesQuery =
          q.isEmpty || p.name.toLowerCase().contains(q) || p.category.toLowerCase().contains(q);
      final matchesCategory = current.selectedCategory == allCategory ||
          p.category == current.selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    emit(current.copyWith(filtered: filtered));
  }

  void filterByCategory(String category) {
    final current = state;
    if (current is! ProductLoaded) return;

    final filtered = category == allCategory
        ? current.allProducts
        : current.allProducts.where((p) => p.category == category).toList();

    emit(current.copyWith(
      filtered: filtered,
      selectedCategory: category,
    ));
  }

  List<String> getCategories(List<ProductModel> products) {
    final cats = products.map((p) => p.category).toSet().toList();
    return [allCategory, ...cats];
  }
}