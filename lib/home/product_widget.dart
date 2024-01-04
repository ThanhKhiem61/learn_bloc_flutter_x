import 'package:flutter/material.dart';
import 'package:khiem_flutter3/home/home_bloc.dart';
import 'package:khiem_flutter3/home/model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

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
          Text(productDataModel.price.toString()+" Nghìn Đồng",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(
              onPressed: () {
                homeBloc.add(HomeProductCarButtonClickedEvent(
                    clickedProduct: productDataModel));
              },
              icon: Icon(Icons.shopping_bag_outlined)),
        ],
      ),
    );
  }
}
