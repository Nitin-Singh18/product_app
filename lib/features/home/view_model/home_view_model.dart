import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/product.dart';
import '../../../data/repositories/product_repository.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) {
    final repository = ref.watch(productRepositoryProvider);
    return HomeViewModel(repository);
  },
);

class HomeViewModel extends StateNotifier<HomeState> {
  final ProductRepository _repository;

  HomeViewModel(this._repository)
      : super(
          const HomeState(
            products: AsyncLoading(),
            categories: {},
            popularDeals: [],
          ),
        ) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await _repository.fetchProducts();
      final categories = _getCategoriesWithImages(products);
      final popularDeals = _getHighRatedProducts(products: products);
      state = state.copyWith(
        products: AsyncData(products),
        categories: categories,
        popularDeals: popularDeals,
      );
    } catch (error) {
      state = state.copyWith(products: AsyncError(error, StackTrace.current));
    }
  }

  Map<String, String> _getCategoriesWithImages(List<Product> products) {
    final categoryImageMap = <String, String>{};

    for (var product in products) {
      if (!categoryImageMap.containsKey(product.category)) {
        categoryImageMap[product.category] = product.image;
      }
    }
    return categoryImageMap;
  }

  List<Product> filterProductsByCategory({
    required String category,
  }) {
    return state.products.value!
        .where((product) => product.category == category)
        .toList();
  }

  List<Product> _getHighRatedProducts({
    required List<Product> products,
    double minRating = 4.5,
  }) {
    return products
        .where((product) => product.rating.rate > minRating)
        .toList();
  }
}

class HomeState {
  final AsyncValue<List<Product>> products;
  final Map<String, String> categories;
  final List<Product> popularDeals;

  const HomeState({
    required this.products,
    required this.categories,
    required this.popularDeals,
  });

  HomeState copyWith({
    AsyncValue<List<Product>>? products,
    Map<String, String>? categories,
    List<Product>? popularDeals,
  }) =>
      HomeState(
        products: products ?? this.products,
        categories: categories ?? this.categories,
        popularDeals: popularDeals ?? this.popularDeals,
      );
}
