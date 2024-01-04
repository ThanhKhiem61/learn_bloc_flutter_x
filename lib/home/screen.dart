import 'package:flutter/material.dart';
import 'package:khiem_flutter3/cart/screen.dart';
import 'package:khiem_flutter3/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khiem_flutter3/home/model.dart';
import 'package:khiem_flutter3/home/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeProductItemCartedActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Thêm Vào Giỏ Hàng Thành Công "),
              duration: Duration(seconds: 3),
            ));
          } else if (state is HomeNavigateToCartPageActionState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  title: Text("Khiem"),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ),
                body: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                          productDataModel: successState.products[index],
                          homeBloc: homeBloc);
                    }),
              );
            case HomeErrorState:
              return Scaffold(
                body: Text("Error"),
              );
            default:
              return Container(
                child: Text("we"),
              );
          }
        });
  }
}
