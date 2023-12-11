
import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  CartRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getCartListData() async {
    try {
      final response = await dioClient!.get('${AppConstants.getCartDataUri}?guest_id=${Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> addToCartListData(CartModelBody cart, List<ChoiceOptions> choiceOptions, List<int>? variationIndexes) async {
    Map<String?, dynamic> choice = {};
    for(int index=0; index<choiceOptions.length; index++){
      choice.addAll({choiceOptions[index].name: choiceOptions[index].options![variationIndexes![index]]});
    }
    Map<String?, dynamic> data = {'id': cart.productId,
      'guest_id' : Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken(),
      'variant': cart.variation != null ? cart.variation!.type : null,
      'quantity': cart.quantity};
    data.addAll(choice);
    if(cart.variant!.isNotEmpty) {
      data.addAll({'color': cart.color});
    }

    try {
      final response = await dioClient!.post(
        AppConstants.addToCartUri,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateQuantity( int? key,int quantity) async {
    try {
      final response = await dioClient!.post(AppConstants.updateCartQuantityUri,
        data: {'_method': 'put',
          'key': key,
          'quantity': quantity,
          'guest_id' : Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken(),
        });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeFromCart(int? key) async {
    try {
      final response = await dioClient!.post(AppConstants.removeFromCartUri,
          data: {'_method': 'delete',
            'guest_id' : Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken(),
            'key': key});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShippingMethod(int? sellerId, String? type) async {
    try {
      final response = await dioClient!.get('${AppConstants.getShippingMethod}/$sellerId/$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> addShippingMethod(int? id, String? cartGroupId) async {
    if (kDebugMode) {
      print('===>${{"id":id, "cart_group_id": cartGroupId}}');
    }
    try {
      final response = await dioClient!.post(AppConstants.chooseShippingMethod,
          data: {"id":id,
            'guest_id' : Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken(),
            "cart_group_id": cartGroupId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getChosenShippingMethod() async {
    try {
      final response =await dioClient!.get('${AppConstants.chosenShippingMethod}?guest_id=${Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSelectedShippingType(int sellerId, String sellerType) async {
    try {
      final response = await dioClient!.get('${AppConstants.getSelectedShippingTypeUri}?seller_id=$sellerId&seller_is=$sellerType');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
