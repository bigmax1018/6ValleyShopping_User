import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class CouponRepo {
  final DioClient? dioClient;
  CouponRepo({required this.dioClient});

  Future<ApiResponse> getCoupon(String coupon) async {
    try {
      final response = await dioClient!.get('${AppConstants.couponUri}$coupon');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCouponList(int offset) async {
    try {
      final response = await dioClient!.get('${AppConstants.couponListApi}$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAvailableCouponList() async {
    try {
      final response = await dioClient!.get(AppConstants.availableCoupon);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSellerCouponList(int sellerId, int offset) async {
    try {
      final response = await dioClient!.get('${AppConstants.sellerWiseCouponListApi}$sellerId/seller-wise-coupons?limit=100&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}