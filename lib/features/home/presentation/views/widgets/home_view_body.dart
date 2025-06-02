import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_web_admin_dashboard/core/utils/app_font_styles.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/entities/seller_entity.dart';
import 'package:swift_web_admin_dashboard/features/home/presentation/cubits/fetch_sellers_cubit/fetch_sellers_cubit.dart';
import 'package:swift_web_admin_dashboard/features/home/presentation/views/widgets/seller_details_widget.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.sellersList});
  final List<SellerEntity> sellersList;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.read<FetchSellersCubit>().fetchSellers();
          },
          child: Text('Users', style: AppTextStyles.w400_18),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.sellersList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SellerDetailsWidget(
                  sellerEntity: widget.sellersList[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
