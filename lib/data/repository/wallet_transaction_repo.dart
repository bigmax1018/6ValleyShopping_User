import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class WalletTransactionRepo {
  final DioClient? dioClient;
  WalletTransactionRepo({required this.dioClient});

  Future<ApiResponse> getWalletTransactionList(int offset, type) async {
    try {
      Response response = await dioClient!.get('${AppConstants.walletTransactionUri}$offset&transaction_type=$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getLoyaltyPointList(int offset) async {
    try {
      Response response = await dioClient!.get('${AppConstants.loyaltyPointUri}$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> convertPointToCurrency(int point) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.loyaltyPointConvert,
        data: {"point": point},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> addFundToWallet(String amount, String paymentMethod) async {
    try {
      print("==============Currency====> ${Provider.of<SplashProvider>(Get.context!, listen: false).myCurrency!.code}");
      final response = await dioClient!.post(AppConstants.addFundToWallet,
          data: {'payment_platform': 'app',
            'payment_method' : paymentMethod,
            'payment_request_from': 'app',
            'amount': amount,
            'current_currency_code': Provider.of<SplashProvider>(Get.context!, listen: false).myCurrency!.code

          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getWalletBonusBannerList() async {
    try {
      Response response = await dioClient!.get(AppConstants.walletBonusList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}