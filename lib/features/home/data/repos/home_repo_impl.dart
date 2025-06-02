import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:swift_web_admin_dashboard/core/errors/failure.dart';
import 'package:swift_web_admin_dashboard/core/services/backend_endpoints.dart';
import 'package:swift_web_admin_dashboard/core/services/database_service.dart';
import 'package:swift_web_admin_dashboard/features/home/data/models/seller_model.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/entities/seller_entity.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/repos/home_repo.dart';

import '../../../../app_keys.dart';

class HomeRepoImpl implements HomeRepo {
  final DataBaseService dataBaseService;

  HomeRepoImpl(this.dataBaseService);

  @override
  Future<Either<Failure, List<SellerEntity>>> getSellers() async {
    try {
      final result = await dataBaseService.getData(
        path: BackendEndpoints.pendingSellers,
      );

      final List<SellerEntity> sellersList =
          result
              .map<SellerEntity>(
                (item) => SellerModel.fromJson(item).toEntity(),
              )
              .toList();

      return Right(sellersList);
    } catch (e) {
      log('getSellers error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptSeller(SellerEntity sellerEntity) async {
    try {
      await dataBaseService.addData(
        path: BackendEndpoints.users,
        data: {
          'name': sellerEntity.userName,
          'email': sellerEntity.email,
          'phone': sellerEntity.phoneNumber,
          'address': sellerEntity.storeAddress,
          'user_type': 'seller',
          'id': sellerEntity.id,
        },
      );
      await dataBaseService.addData(
        path: BackendEndpoints.sellers,
        data: {
          'store_name': sellerEntity.storeName,
          'user_id': sellerEntity.id,
          'image_url': sellerEntity.image,
        },
      );

      await dataBaseService.deleteData(
        path: BackendEndpoints.pendingSellers,
        id: sellerEntity.id,
        column: 'id',
      );

      return Right(null);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, void>> rejectSeller(SellerEntity sellerEntity) async {
    try {
      await dataBaseService.addData(
        path: BackendEndpoints.rejectedSellers,
        data: {'email': sellerEntity.email},
      );
      await dataBaseService.deleteData(
        path: BackendEndpoints.pendingSellers,
        id: sellerEntity.id,
        column: 'id',
      );
      final response = await http.delete(
        Uri.parse(
          'https://ogvjqmzxwuvgzbzrwmxc.supabase.co/auth/v1/admin/users/${sellerEntity.id}',
        ),
        headers: {
          'apikey': AppKeys.admin,
          'Authorization': 'Bearer ${AppKeys.admin}',
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log('User deleted successfully.');
        return Right(null);
      } else {
        log('Failed to delete user: ${response.body}');
        return left(ServerFailure(response.body));
      }
    } catch (e) {
      log('Failed to delete user: ${e.toString()}');
      return left(ServerFailure(e.toString()));
    }
  }
}
