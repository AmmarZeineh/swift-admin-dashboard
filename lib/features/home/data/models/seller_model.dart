import 'package:swift_web_admin_dashboard/features/home/domain/entities/seller_entity.dart';

class SellerModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String storeName;
  final String storeAddress;
  final String role = 'seller';
  String image;

  SellerModel({
    required this.id,
    required this.image,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.storeName,
    required this.storeAddress,
  });

  toJson() => {
    'id': id,
    'name': userName,
    'email': email,
    'phone': phoneNumber,
    'store_name': storeName,
    'address': storeAddress,
    'imageUrl': image,
  };

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
    id: json['id'],
    userName: json['name'],
    email: json['email'],
    phoneNumber: json['phone'],
    storeName: json['store_name'],
    storeAddress: json['address'],
    image: json['imageUrl'],
  );

  factory SellerModel.fromEntity(SellerEntity sellerEntity) => SellerModel(
    id: sellerEntity.id,
    userName: sellerEntity.userName,
    email: sellerEntity.email,
    phoneNumber: sellerEntity.phoneNumber,
    storeName: sellerEntity.storeName,
    storeAddress: sellerEntity.storeAddress,
    image: sellerEntity.image,
  );

  SellerEntity toEntity() => SellerEntity(
    id: id,
    userName: userName,
    email: email,
    phoneNumber: phoneNumber,
    storeName: storeName,
    storeAddress: storeAddress,
    image: image,
  );
}
