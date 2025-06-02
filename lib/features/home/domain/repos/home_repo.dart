import 'package:dartz/dartz.dart';
import 'package:swift_web_admin_dashboard/core/errors/failure.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/entities/seller_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<SellerEntity>>> getSellers();
  Future<Either<Failure, void>> acceptSeller(SellerEntity sellerEntity);
  Future<Either<Failure, void>> rejectSeller(SellerEntity sellerEntity);
}
