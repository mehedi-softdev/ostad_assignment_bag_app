import '../Models/bag_item_model.dart';

class ShoppingCartController {
  int calculateTotalPrice(List<BagItemModel> contents) {
    int totalPrice = 0;
    for (BagItemModel data in contents) {
      totalPrice += data.dressPrice;
    }
    return totalPrice;
  }

  int increaseQuantity(int totalPrice, int index,List<BagItemModel> contents ) {
    if (contents[index].quantity < 5) {
      contents[index].quantity++;
      totalPrice += contents[index].dressPrice;
    }
    return totalPrice;
  }

  int decreaseQuantity(int totalPrice, int index, List<BagItemModel> contents) {
    if (contents[index].quantity > 1) {
      contents[index].quantity--;
      totalPrice -= contents[index].dressPrice;
    }
    return totalPrice;
  }

}
