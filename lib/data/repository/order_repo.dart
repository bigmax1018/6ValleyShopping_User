
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class OrderRepo {
  final DioClient? dioClient;

  OrderRepo({required this.dioClient});

  Future<ApiResponse> getOrderList(int offset, String status, {String? type}) async {
    try {
      final response = await dioClient!.get('${AppConstants.orderUri}$offset&status=$status&type=$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      final response = await dioClient!.get(
        AppConstants.orderDetailsUri+orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderFromOrderId(String orderID) async {
    try {
      final response = await dioClient!.get('${AppConstants.getOrderFromOrderId}$orderID&guest_id=${Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShippingList() async {
    try {
      final response = await dioClient!.get(AppConstants.shippingUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> placeOrder(String? addressID, String? couponCode,String? couponDiscountAmount, String? billingAddressId, String? orderNote) async {

    try {
      final response = await dioClient!.get('${AppConstants.orderPlaceUri}?address_id=$addressID&coupon_code=$couponCode&coupon_discount=$couponDiscountAmount&billing_address_id=$billingAddressId&order_note=$orderNote&guest_id=${Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()}&is_guest=${Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn()? 0 :1 }');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> offlinePaymentPlaceOrder(String? addressID, String? couponCode, String? couponDiscountAmount, String? billingAddressId, String? orderNote, List <String?> typeKey, List<String> typeValue, int? id, String name, String? paymentNote) async {
    try {
      Map<String?, String> fields = {};
      Map<String?, String> info = {};

      for(var i = 0; i < typeKey.length; i++){
        info.addAll(<String?, String>{
          typeKey[i] : typeValue[i]
        });
      }

      fields.addAll(<String, String>{

        "method_informations" : base64.encode(utf8.encode(jsonEncode(info))),
        'method_name': name,
        'method_id': id.toString(),
        'payment_note' : paymentNote??'',
        'address_id': addressID??'',
        'coupon_code' : couponCode??"",
        'coupon_discount' : couponDiscountAmount??'',
        'billing_address_id' : billingAddressId??'',
        'order_note' : orderNote??'',
        'guest_id': Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()??'',
        'is_guest' : Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn()? '0':'1'

      });


      if (kDebugMode) {
        print('--here is type key =$id/$name');
      }
      Response response = await dioClient!.post(AppConstants.offlinePayment,
          data: fields);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> walletPaymentPlaceOrder(String? addressID, String? couponCode,String? couponDiscountAmount, String? billingAddressId, String? orderNote) async {
    try {
      final response = await dioClient!.get('${AppConstants.walletPayment}?address_id=$addressID&coupon_code=$couponCode&coupon_discount=$couponDiscountAmount&billing_address_id=$billingAddressId&order_note=$orderNote&guest_id=${Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()}&is_guest=${Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn()? 0 :1}',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> getTrackingInfo(String orderID) async {
    try {
      final response = await dioClient!.get(AppConstants.trackingUri+orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShippingMethod(int sellerId) async {
    try {
      final response = sellerId==1?await dioClient!.get('${AppConstants.getShippingMethod}/$sellerId/admin'):
      await dioClient!.get('${AppConstants.getShippingMethod}/$sellerId/seller');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<http.StreamedResponse> refundRequest(int? orderDetailsId, double? amount, String refundReason, List<XFile?> file, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.refundRequestUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('images[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'order_details_id': orderDetailsId.toString(),
      'amount': amount.toString(),
      'refund_reason':refundReason
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<ApiResponse> getRefundInfo(int? orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundRequestPreReqUri}?order_details_id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }
  Future<ApiResponse> getRefundResult(int? orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundResultUri}?id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelOrder(int? orderId) async {
    try {
      final response = await dioClient!.get('${AppConstants.cancelOrderUri}?order_id=$orderId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> offlinePaymentList() async {
    try {
      final response = await dioClient!.get('${AppConstants.offlinePaymentList}?guest_id=${Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()}&is_guest=${!Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> digitalPayment(
      String? orderNote,
      String? customerId,
      String? addressId,
      String? billingAddressId,
      String? couponCode,
      String? couponDiscount,
      String? paymentMethod,
      ) async {

    try {
      final response = await dioClient!.post(AppConstants.digitalPayment, data: {
        "order_note": orderNote,
        "customer_id":  customerId,
        "address_id": addressId,
        "billing_address_id": billingAddressId,
        "coupon_code": couponCode,
        "coupon_discount": couponDiscount,
        "payment_platform" : "app",
        "payment_method" : paymentMethod,
        "callback" : null,
        "payment_request_from" : "app",
        'guest_id' : Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken(),
        'is_guest': !Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn(),
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> trackYourOrder(String orderId, String phoneNumber) async {
    try {
      final response = await dioClient!.post(AppConstants.orderTrack,
          data: {'order_id': orderId,
            'phone_number' : phoneNumber

      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> downloadDigitalProduct(int orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.downloadDigitalProduct}$orderDetailsId?guest_id=${Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendOtpForDigitalProduct(int orderId) async {
    try {
      final response = await dioClient!.post(AppConstants.otpVResendForDigitalProduct,
      data: {'order_details_id' : orderId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> otpVerificationForDigitalProduct(int orderId, String otp) async {
    try {
      final response = await dioClient!.get('${AppConstants.otpVerificationForDigitalProduct}?order_details_id=$orderId&otp=$otp&guest_id=1',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> reorder(String orderId) async {
    try {
      final response = await dioClient!.post(AppConstants.reorder,
          data: {'order_id': orderId,
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}
