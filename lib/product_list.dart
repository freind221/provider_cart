import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_cart/cart_model.dart';
import 'package:provider_cart/cart_provider.dart';
import 'package:provider_cart/db_helper.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper dbHelper = DBHelper();
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg',
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg',
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg',
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612',
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612',
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612',
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612',
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          Center(
            child: Badge(
                badgeContent: const Text(
                  '0',
                  style: TextStyle(color: Colors.white),
                ),
                animationDuration: const Duration(microseconds: 500),
                child: const Icon(Icons.shopping_cart)),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: productName.length,
          itemBuilder: ((context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                            height: 100,
                            width: 100,
                            image:
                                NetworkImage(productImage[index].toString())),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName[index].toString(),
                                textScaleFactor: 1.2,
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                productUnit[index].toString() +
                                    ' ' +
                                    r"$" +
                                    productPrice[index].toString(),
                                textScaleFactor: 1.2,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            dbHelper.insert(Cart(
                                id: index,
                                productName: productName[index].toString(),
                                initialPrice: productPrice[index],
                                image: productImage[index],
                                unitTag: productUnit[index]));
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey,
                            ),
                            child: const Center(
                                child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}