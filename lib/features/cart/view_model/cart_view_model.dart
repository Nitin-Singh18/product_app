import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/product.dart';
import '../model/cart_item.dart';

class CartViewModel extends StateNotifier<CartState> {
  CartViewModel() : super(const CartState(cartItems: [], itemCount: 0));

  // Add product to the cart
  void addProduct(Product product) {
    final cartItems = List<CartItem>.from(state.cartItems);
    final existingIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      // If the product already exists, increase its quantity
      cartItems[existingIndex] = CartItem(
        product: cartItems[existingIndex].product,
        quantity: cartItems[existingIndex].quantity + 1,
      );
      state = state.copyWith(cartItems: cartItems);
    } else {
      state = state.copyWith(
          cartItems: [...state.cartItems, CartItem(product: product)]);
    }
    updateTotalItemCount();
  }

  void updateTotalItemCount() {
    final count = state.cartItems.fold(0, (sum, item) => sum + item.quantity);
    state = state.copyWith(itemCount: count);
  }

  // Remove product from the cart or decrease its quantity
  void removeProduct(Product product) {
    final cartItems = List<CartItem>.from(state.cartItems);
    final existingIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      if (cartItems[existingIndex].quantity > 1) {
        // Decrease quantity if more than 1
        cartItems[existingIndex] = CartItem(
          product: cartItems[existingIndex].product,
          quantity: cartItems[existingIndex].quantity - 1,
        );
        state = state.copyWith(cartItems: cartItems);
      } else {
        final updatedCart =
            cartItems.where((item) => item.product.id != product.id).toList();
        // Remove the product if quantity is 1
        state = state.copyWith(cartItems: updatedCart);
      }
    }
    updateTotalItemCount();
  }

  // Check if a product is in the cart
  int getProductQuantity(int productId) {
    final existingIndex =
        state.cartItems.indexWhere((item) => item.product.id == productId);
    return existingIndex >= 0 ? state.cartItems[existingIndex].quantity : 0;
  }
}

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(),
);

class CartState {
  final List<CartItem> cartItems;
  final int itemCount;

  const CartState({required this.cartItems, required this.itemCount});

  CartState copyWith({
    List<CartItem>? cartItems,
    int? itemCount,
  }) =>
      CartState(
        cartItems: cartItems ?? this.cartItems,
        itemCount: itemCount ?? this.itemCount,
      );
}
