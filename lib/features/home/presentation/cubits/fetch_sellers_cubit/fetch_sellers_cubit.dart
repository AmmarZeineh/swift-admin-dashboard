import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/entities/seller_entity.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/repos/home_repo.dart';

part 'fetch_sellers_state.dart';

class FetchSellersCubit extends Cubit<FetchSellersState> {
  FetchSellersCubit(this.homeRepo) : super(FetchSellersInitial());
  final HomeRepo homeRepo;

  Future<void> fetchSellers() async {
    emit(FetchSellersLoading());
    final failureOrSellers = await homeRepo.getSellers();
    failureOrSellers.fold(
      (failure) => emit(FetchSellersFailure(failure.message)),
      (sellers) => emit(FetchSellersSuccess(sellers)),
    );
  }

  Future<void> acceptSeller(SellerEntity sellerEntity) async {
    await homeRepo.acceptSeller(sellerEntity);
    fetchSellers();
  }

  Future<void> rejectSeller(SellerEntity sellerEntity) async {
    try {
      await homeRepo.rejectSeller(sellerEntity);
      fetchSellers();
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
