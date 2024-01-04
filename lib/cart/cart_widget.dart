import 'package:flutter/material.dart';
import 'package:khiem_flutter3/cart/cart_bloc.dart';
import 'package:khiem_flutter3/home/model.dart';

class CartWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(productDataModel.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(productDataModel.price.toString() + " Nghìn Đồng",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(
              onPressed: () {

                cartBloc.add(CartRemoveFromCartEvent(
                    productDataModel: productDataModel));
              },

              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
