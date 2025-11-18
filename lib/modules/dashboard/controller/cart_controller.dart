import 'package:get/get.dart';
import 'package:penoft_machine_test/modules/dashboard/model/materials_list_datum/datum.dart';

class CartItem {
  final MaterialListModel material;
  int quantity;

  CartItem({
    required this.material,
    this.quantity = 1,
  });

  double get totalPrice {
    final price = double.tryParse(material.price ?? '0') ?? 0.0;
    return price * quantity;
  }
}

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  // Get total cart count
  int get totalCount {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Get total cart price
  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Check if material is in cart
  bool isInCart(MaterialListModel material) {
    return cartItems.any((item) => item.material.title == material.title);
  }

  // Get quantity of material in cart
  int getQuantity(MaterialListModel material) {
    final item = cartItems.firstWhereOrNull(
      (item) => item.material.title == material.title,
    );
    return item?.quantity ?? 0;
  }

  // Add material to cart
  void addToCart(MaterialListModel material) {
    final existingItem = cartItems.firstWhereOrNull(
      (item) => item.material.title == material.title,
    );

    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItem(material: material, quantity: 1));
    }
  }

  // Remove material from cart
  void removeFromCart(MaterialListModel material) {
    final existingItem = cartItems.firstWhereOrNull(
      (item) => item.material.title == material.title,
    );

    if (existingItem != null) {
      if (existingItem.quantity > 1) {
        existingItem.quantity--;
      } else {
        cartItems.remove(existingItem);
      }
    }
  }

  // Remove item completely from cart
  void removeItemCompletely(MaterialListModel material) {
    cartItems.removeWhere((item) => item.material.title == material.title);
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
  }
}

final cartController = Get.put(CartController());

