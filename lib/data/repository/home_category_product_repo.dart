import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class HomeCategoryProductRepo {
  final DioClient? dioClient;
  HomeCategoryProductRepo({required this.dioClient});

  Future<ApiResponse> getHomeCategoryProductList() async {
    try {
      final response = await dioClient!.get(
        AppConstants.homeCategoryProductUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}