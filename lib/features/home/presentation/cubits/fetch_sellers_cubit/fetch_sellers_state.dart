part of 'fetch_sellers_cubit.dart';

@immutable
sealed class FetchSellersState {}

final class FetchSellersInitial extends FetchSellersState {}

final class FetchSellersLoading extends FetchSellersState {}

final class FetchSellersFailure extends FetchSellersState {
  final String errMessage;

  FetchSellersFailure(this.errMessage);
}

final class FetchSellersSuccess extends FetchSellersState {
  final List<SellerEntity> sellersList;

  FetchSellersSuccess(this.sellersList);
}
