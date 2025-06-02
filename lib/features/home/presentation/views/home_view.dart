import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_web_admin_dashboard/core/services/get_it_service.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/repos/home_repo.dart';
import 'package:swift_web_admin_dashboard/features/home/presentation/cubits/fetch_sellers_cubit/fetch_sellers_cubit.dart';
import 'package:swift_web_admin_dashboard/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'home-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => FetchSellersCubit(getIt.get<HomeRepo>()),
          child: HomeViewBodyBlocBuilder(),
        ),
      ),
    );
  }
}

class HomeViewBodyBlocBuilder extends StatelessWidget {
  const HomeViewBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSellersCubit, FetchSellersState>(
      builder: (context, state) {
        if (state is FetchSellersSuccess) {
          return HomeViewBody(sellersList: state.sellersList);
        } else {}
        return ModalProgressHUD(
          inAsyncCall: state is FetchSellersLoading,
          child: HomeViewBody(sellersList: []),
        );
      },
    );
  }
}
