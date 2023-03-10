// ignore: file_names
import "package:flutter/material.dart";
import "package:food_delivery/models/cart.dart";
import "package:food_delivery/models/food.dart";
import "package:get/get.dart";

class CartService extends ChangeNotifier {
  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

  void addToCart(Food food, int quantity) {
    if (_cart.any((element) => element.food.id == food.id)) {
      int index = _cart
          .indexOf(_cart.firstWhere((element) => element.food.id == food.id));
      Cart c = _cart[index];
      _cart.removeAt(index);
      _cart.insert(index, Cart(food: c.food, quantity: c.quantity + quantity));
      Get.closeAllSnackbars();
      Get.snackbar(
        "Food add",
        "you have added the ${food.name} ${quantity}x to the cart (${c.quantity + quantity})",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 900),
      );
    } else {
      _cart.add(Cart(food: food, quantity: quantity));
      Get.snackbar(
        "Food add",
        "you have added the ${food.name} ${quantity}x to the cart (${quantity.toString()})",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 900),
      );
    }
    notifyListeners();
  }

  void increaseQuantity(Food food) {
    if (_cart.any((element) => element.food.id == food.id)) {
      int index = _cart
          .indexOf(_cart.firstWhere((element) => element.food.id == food.id));
      Cart c = _cart[index];
      _cart.removeAt(index);
      _cart.insert(index, Cart(food: c.food, quantity: c.quantity + 1));

      // stop current snackbars
      Get.closeAllSnackbars();
      Get.snackbar(
        "Food increament",
        "you have increased the quantity of ${food.name} to the cart (${c.quantity + 1})",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 900),
      );
    } else {
      _cart.add(Cart(food: food, quantity: 1));
      Get.closeAllSnackbars();
      Get.snackbar(
        "Food added",
        "you have added the ${food.name} to the cart (1)",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 900),
      );
    }
    notifyListeners();
  }

  void setCart(List<Cart> cart) {
    _cart.clear();
    _cart.addAll(cart);
    notifyListeners();
  }

  void decreaseQuantity(Food food) {
    if (_cart.any((element) => element.food.id == food.id)) {
      if (_cart.firstWhere((element) => element.food.id == food.id).quantity ==
          1) {
        int index = _cart
            .indexOf(_cart.firstWhere((element) => element.food.id == food.id));
        _cart.removeAt(index);
        Get.closeAllSnackbars();
        Get.snackbar(
          "Food deleted",
          "you have deleted the ${food.name} from the cart",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(milliseconds: 900),
        );
      } else {
        int index = _cart
            .indexOf(_cart.firstWhere((element) => element.food.id == food.id));
        Cart c = _cart[index];
        _cart.removeAt(index);
        _cart.insert(index, Cart(food: c.food, quantity: c.quantity - 1));
        Get.closeAllSnackbars();
        Get.snackbar(
          "Food decreament",
          "you have decreased the quantity of ${food.name} to the cart (${c.quantity - 1})",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(milliseconds: 900),
        );
      }
    }
    notifyListeners();
  }

  void removeFromCart(Food food) {
    if (_cart.any((element) => element.food.id == food.id)) {
      _cart.firstWhere((element) => element.food.id == food.id).quantity--;
      if (_cart.firstWhere((element) => element.food.id == food.id).quantity ==
          0) {
        _cart.removeWhere((element) => element.food.id == food.id);
      }
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;
    for (var element in _cart) {
      total += element.food.price * element.quantity;
    }
    return total;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  List<Cart> getCart() {
    return _cart;
  }

  int getQuantity(Food food) {
    if (_cart.any((element) => element.food.id == food.id)) {
      return _cart.firstWhere((element) => element.food.id == food.id).quantity;
    } else {
      return 0;
    }
  }
}
