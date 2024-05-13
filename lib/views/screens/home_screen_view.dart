import 'package:bag_app/Models/bag_item_model.dart';
import 'package:bag_app/views/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:bag_app/Controllers/shopping_cart_controller.dart';
import 'package:bag_app/views/app_alert_dialog.dart';
import 'home_screen_bottom_layout.dart';
import 'home_screen_shopping_card_layout.dart';
import 'home_screen_title_layout.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late int totalPrice;
  late ShoppingCartController cartController;
  late double screenHeight, screenWidth;

  @override
  void initState() {
    cartController = ShoppingCartController();
    totalPrice = cartController.calculateTotalPrice(contents);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return (orientation == Orientation.portrait)
              ? portraitView(orientation)
              : landScapeView(orientation);
        },
      ),
    );
  }

  Widget portraitView(
    Orientation orientation,
  ) =>
      Container(
        //portraitView
        margin: const EdgeInsets.all(10.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeScreenTitle(),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contents.length,
                itemBuilder: (context, index) => ShoppingCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  orientation: orientation,
                  index: index,
                  increaseQuantity: () => increaseQuantity(index, orientation),
                  decreaseQuantity: () => decreaseQuantity(index),
                ),
              ),
            ),
            HomeScreenBottomLayout(
              orientation: orientation,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              totalPrice: totalPrice,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
                    content: "Congratulations! Your purchase was a success!!"));
              },
            )
          ],
        ),
      );

  Widget landScapeView(Orientation orientation) => Container(
        //landScape View
        margin: const EdgeInsets.all(10.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    child: HomeScreenTitle(),
                  ),
                  Expanded(
                    flex: 6,
                    child: ListView.builder(
                      itemCount: contents.length,
                      itemBuilder: (context, index) => ShoppingCard(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        orientation: orientation,
                        index: index,
                        increaseQuantity: () =>
                            increaseQuantity(index, orientation),
                        decreaseQuantity: () => decreaseQuantity(index),
                      ),
                    ),
                  )
                ],
              ),
            ),
            HomeScreenBottomLayout(
              orientation: orientation,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              totalPrice: totalPrice,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  showSnackBar(
                      content:
                          "Congratulations! Your purchase was a success!!"),
                );
              },
            ),
          ],
        ),
      );

  void increaseQuantity(int index, Orientation orientation) {
    totalPrice = cartController.increaseQuantity(totalPrice, index,contents);
    if (contents[index].quantity == 5) {
      showAlertDialog(index, orientation);
    }
    setState(() {});
  }

  void decreaseQuantity(int index) {
    totalPrice = cartController.decreaseQuantity(totalPrice, index,contents);
    setState(() {});
  }

  void showAlertDialog(int index, Orientation orientation) {
    showDialog(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          title: "Congratulations!",
          content:
              "You have added \n5 ${contents[index].dressName.toString()}\n in your bag!",
          orientation: orientation,
        );
      },
    );
  }
}
