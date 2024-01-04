part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

//ấn vào để thêm vào giỏ hàng
class HomeProductCarButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCarButtonClickedEvent({required this.clickedProduct});
}

//ấn vào để đến giỏ hàng
class HomeCartButtonNavigateEvent extends HomeEvent {}
