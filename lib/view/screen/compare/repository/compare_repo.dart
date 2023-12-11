import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class CompareRepo {
  final DioClient? dioClient;
  CompareRepo({required this.dioClient});

  Future<ApiResponse> getCompareProductList() async {
    try {
      final response = await dioClient!.get(AppConstants.getCompareList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addCompareProductList(int id) async {
    try {
      final response = await dioClient!.post(AppConstants.addToCompareList, data: {'product_id' : id});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeAllCompareProductList() async {
    try {
      final response = await dioClient!.post(AppConstants.removeAllFromCompareList, data: {'_method':'delete'});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> replaceCompareProductList(int compareId, int productId) async {
    try {
      final response = await dioClient!.get('${AppConstants.replaceFromCompareList}?compare_id=$compareId&product_id=$productId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAttributeList() async {
    try {
      final response = await dioClient!.get(AppConstants.attributeUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}