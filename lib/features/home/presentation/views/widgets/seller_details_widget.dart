import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/entities/seller_entity.dart';
import 'package:swift_web_admin_dashboard/features/home/presentation/cubits/fetch_sellers_cubit/fetch_sellers_cubit.dart';

class SellerDetailsWidget extends StatelessWidget {
  const SellerDetailsWidget({super.key, required this.sellerEntity});

  final SellerEntity sellerEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: CachedNetworkImage(
              placeholder: (context, url) {
                return Center(child: CircularProgressIndicator());
              },
              errorWidget: (context, url, error) {
                return Icon(Icons.error);
              },
              imageUrl: sellerEntity.image,
            ),
          ),
          SizedBox(width: 100),
          Expanded(child: Text(sellerEntity.userName)),
          Expanded(child: Text(sellerEntity.email)),
          Expanded(child: Text(sellerEntity.phoneNumber)),
          Expanded(child: Text(sellerEntity.storeAddress)),
          Expanded(child: Text(sellerEntity.storeName)),
          Expanded(
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<FetchSellersCubit>().acceptSeller(
                      sellerEntity,
                    );
                  },
                  icon: Icon(Icons.check, color: Colors.green),
                ),
                IconButton(
                  onPressed: () {
                     context.read<FetchSellersCubit>().rejectSeller(
                      sellerEntity,
                    );
                  },
                  icon: Icon(Icons.close, color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(width: 24),
        ],
      ),
    );
  }
}
