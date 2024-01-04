import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:khiem_flutter3/data/cart_items.dart';
import 'package:khiem_flutter3/data/product_data.dart';
import 'package:khiem_flutter3/home/model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductCarButtonClickedEvent>(homeProductCarButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeProductCarButtonClickedEvent(
      HomeProductCarButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Thêm Vào Giỏ Hàng Thành Công');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Chuyển đến Giỏ Hàng');
    emit(HomeNavigateToCartPageActionState());
  }
}
