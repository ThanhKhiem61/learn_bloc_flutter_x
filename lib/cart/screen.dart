import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khiem_flutter3/cart/cart_bloc.dart';
import 'package:khiem_flutter3/cart/cart_widget.dart';
import 'package:khiem_flutter3/home/product_widget.dart';

import '../data/cart_items.dart';
import '../data/cart_items.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ Hàng"),
        centerTitle: true,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if(state is CartRemoveSuccessState){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Xóa Thành Công "),
              duration: Duration(seconds: 2),
            ));
          }
        },
        builder: (context, state) {
              if(state is CartSuccessState && state.cartItems.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartWidget(
                          productDataModel: state.cartItems[index],
                          cartBloc: cartBloc);
                    });
              }
              return const Center(child: Text("Trống",style: TextStyle(color: Colors.black,fontSize: 40),),);
        },
      ),
    );
  }
}
