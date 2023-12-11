import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/offline_payment_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_details.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/refund_info_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/refund_result_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/shipping_method_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/order_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/payment/digital_payment_order_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utill/app_constants.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepo? orderRepo;
  OrderProvider({required this.orderRepo});

  int? _addressIndex;
  int? _billingAddressIndex;
  int? get billingAddressIndex => _billingAddressIndex;
  int? _shippingIndex;
  bool _isLoading = false;
  bool _isRefund = false;
  bool get isRefund => _isRefund;
  List<ShippingMethodModel>? _shippingList;
  int _paymentMethodIndex = -1;
  bool _onlyDigital = true;
  bool get onlyDigital => _onlyDigital;


  int? get addressIndex => _addressIndex;
  int? get shippingIndex => _shippingIndex;
  bool get isLoading => _isLoading;
  List<ShippingMethodModel>? get shippingList => _shippingList;
  int get paymentMethodIndex => _paymentMethodIndex;
  XFile? _imageFile;
  XFile? get imageFile => _imageFile;
  List <XFile?>_refundImage = [];
  List<XFile?> get refundImage => _refundImage;
  List<File> reviewImages = [];

  RefundInfoModel? _refundInfoModel;
  RefundInfoModel? get refundInfoModel => _refundInfoModel;
  RefundResultModel? _refundResultModel;
  RefundResultModel? get refundResultModel => _refundResultModel;




  OrderModel? orderModel;
  OrderModel? deliveredOrderModel;
  Future<void> getOrderList(int offset, String status, {String? type}) async {
    if(offset == 1){
      orderModel = null;
    }
    ApiResponse apiResponse = await orderRepo!.getOrderList(offset, status, type: type);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        orderModel = OrderModel.fromJson(apiResponse.response?.data);
        if(type == 'reorder'){
          deliveredOrderModel = OrderModel.fromJson(apiResponse.response?.data);
        }
      }else {
        orderModel!.orders!.addAll(OrderModel.fromJson(apiResponse.response?.data).orders!);
        orderModel!.offset = OrderModel.fromJson(apiResponse.response?.data).offset;
        orderModel!.totalSize = OrderModel.fromJson(apiResponse.response?.data).totalSize;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  String selectedType = 'ongoing';
  void setIndex(int index, {bool notify = true}) {
    _orderTypeIndex = index;
    if(_orderTypeIndex == 0){
      selectedType = 'ongoing';
      getOrderList(1, 'ongoing');
    }else if(_orderTypeIndex == 1){
      selectedType = 'delivered';
      getOrderList(1, 'delivered');
    }else if(_orderTypeIndex == 2){
      selectedType = 'canceled';
      getOrderList(1, 'canceled');
    }
    if(notify) {
      notifyListeners();
    }
  }

  String selectedPaymentName = '';
  void setSelectedPayment(String payment){
    selectedPaymentName = payment;
    notifyListeners();
  }

  List<OrderDetailsModel>? _orderDetails;
  List<OrderDetailsModel>? get orderDetails => _orderDetails;

  Future <ApiResponse> getOrderDetails(String orderID) async {
    _orderDetails = null;
    ApiResponse apiResponse = await orderRepo!.getOrderDetails(orderID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderDetails = null;
      _orderDetails = [];
      apiResponse.response!.data.forEach((order) => _orderDetails!.add(OrderDetailsModel.fromJson(order)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }




  Orders? orders;
  Future <void> getOrderFromOrderId(String orderID) async {
    ApiResponse apiResponse = await orderRepo!.getOrderFromOrderId(orderID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      orders = Orders.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  final TextEditingController orderNoteController = TextEditingController();

  List<String> inputValueList = [];
  Future<void> placeOrder(
      {required Function callback, String? addressID,
        String? couponCode, String? couponAmount,
        String? billingAddressId, String? orderNote, String? transactionId,
        String? paymentNote, int? id, String? name,bool isfOffline = false, bool wallet = false}) async {
    for(TextEditingController textEditingController in inputFieldControllerList) {
      inputValueList.add(textEditingController.text.trim());

    }
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
     isfOffline?
     apiResponse = await orderRepo!.offlinePaymentPlaceOrder(addressID, couponCode,couponAmount, billingAddressId, orderNote, keyList, inputValueList, offlineMethodSelectedId, offlineMethodSelectedName, paymentNote):
     wallet?
     apiResponse = await orderRepo!.walletPaymentPlaceOrder(addressID, couponCode,couponAmount, billingAddressId, orderNote):
     apiResponse = await orderRepo!.placeOrder(addressID, couponCode,couponAmount, billingAddressId, orderNote);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _addressIndex = null;
      _billingAddressIndex = null;

      String message = apiResponse.response!.data.toString();
      callback(true, message, '');
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      callback(false, errorMessage, '-1');
    }
    notifyListeners();
  }


  void stopLoader({bool notify = true}) {
    _isLoading = false;
    if(notify){
      notifyListeners();
    }

  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    notifyListeners();
  }
  void setBillingAddressIndex(int index) {
    _billingAddressIndex = index;
    notifyListeners();
  }


  void resetPaymentMethod(){
    _paymentMethodIndex = -1;
    codChecked = false;
    walletChecked = false;
    offlineChecked = false;

  }



  Future<void> initShippingList(BuildContext context, int sellerID) async {
    _paymentMethodIndex = 0;
    _shippingIndex = null;
    _addressIndex = null;
    ApiResponse apiResponse = await orderRepo!.getShippingMethod(sellerID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _shippingList = [];
      apiResponse.response!.data.forEach((shippingMethod) => _shippingList!.add(ShippingMethodModel.fromJson(shippingMethod)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  void shippingAddressNull(){
    _addressIndex = null;
    notifyListeners();
  }

  void billingAddressNull(){
    _billingAddressIndex = null;
    notifyListeners();
  }

  void setSelectedShippingAddress(int index) {
    _shippingIndex = index;
    notifyListeners();
  }
  void setSelectedBillingAddress(int index) {
    _billingAddressIndex = index;
    notifyListeners();
  }


  Orders? trackingModel;

  Future<void> initTrackingInfo(String orderID) async {
      ApiResponse apiResponse = await orderRepo!.getTrackingInfo(orderID);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        trackingModel = Orders.fromJson(apiResponse.response!.data);
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
  }


  bool offlineChecked = false;
  bool codChecked = false;
  bool walletChecked = false;

  void setOfflineChecked(String type){
    if(type == 'offline'){
      offlineChecked = !offlineChecked;
      codChecked = false;
      walletChecked = false;
      _paymentMethodIndex = -1;
      setOfflinePaymentMethodSelectedIndex(0);
    }else if(type == 'cod'){
      codChecked = !codChecked;
      offlineChecked = false;
      walletChecked = false;
      _paymentMethodIndex = -1;
    }else if(type == 'wallet'){
      walletChecked = !walletChecked;
      offlineChecked = false;
      codChecked = false;
      _paymentMethodIndex = -1;
    }

    notifyListeners();
  }



  String selectedDigitalPaymentMethodName = '';

  void setDigitalPaymentMethodName(int index, String name) {
    _paymentMethodIndex = index;
    selectedDigitalPaymentMethodName = name;
    codChecked = false;
    walletChecked = false;
    offlineChecked = false;
    notifyListeners();
  }


  void pickImage(bool isRemove, {bool fromReview = false}) async {
    if(isRemove) {
      _imageFile = null;
      _refundImage = [];
      reviewImages = [];
    }else {
      _imageFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 20);
      if (_imageFile != null) {
        if(fromReview){
          reviewImages.add(File(_imageFile!.path));
        }else{
          _refundImage.add(_imageFile);
        }
      }
    }
    notifyListeners();
  }


  void removeImage(int index, {bool fromReview = false}){
    if(fromReview){
      reviewImages.removeAt(index);
    }else{
      _refundImage.removeAt(index);
    }

    notifyListeners();
  }

  Future<http.StreamedResponse> refundRequest(BuildContext context, int? orderDetailsId, double? amount, String refundReason, String token) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await orderRepo!.refundRequest(orderDetailsId, amount, refundReason,refundImage, token);
    if (response.statusCode == 200) {
      getRefundReqInfo(orderDetailsId);
      _imageFile = null;
      _refundImage = [];
      _isLoading = false;

    } else {
      _isLoading = false;

    }
    _imageFile = null;
    _refundImage = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }



  Future<ApiResponse> getRefundReqInfo(int? orderDetailId) async {
    _isRefund = true;
    ApiResponse apiResponse = await orderRepo!.getRefundInfo(orderDetailId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _refundInfoModel = RefundInfoModel.fromJson(apiResponse.response!.data);
      _isRefund = false;
    } else if(apiResponse.response!.statusCode == 202){
      _isRefund = false;
      showCustomSnackBar('${apiResponse.response!.data['message']}', Get.context!);
    }
    else {
      _isRefund = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> getRefundResult(BuildContext context, int? orderDetailId) async {
    _isLoading =true;

    ApiResponse apiResponse = await orderRepo!.getRefundResult(orderDetailId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      _refundResultModel = RefundResultModel.fromJson(apiResponse.response!.data);
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> cancelOrder(BuildContext context, int? orderId) async {
    _isLoading = true;
    ApiResponse apiResponse = await orderRepo!.cancelOrder(orderId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  void downloadFile(String url, String dir) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir,
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );
  }

  void digitalOnly(bool value, {bool isUpdate = false}){
    _onlyDigital = value;
    if(isUpdate){
      notifyListeners();
    }

}



OfflinePaymentModel? offlinePaymentModel;
  Future<ApiResponse> getOfflinePaymentList() async {
    ApiResponse apiResponse = await orderRepo!.offlinePaymentList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      offlineMethodSelectedIndex = 0;
      offlinePaymentModel = OfflinePaymentModel.fromJson(apiResponse.response?.data);
    }
    else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  List<TextEditingController> inputFieldControllerList = [];
  List <String?> keyList = [];
  int offlineMethodSelectedIndex = -1;
  int offlineMethodSelectedId = 0;
  String offlineMethodSelectedName = '';

  void setOfflinePaymentMethodSelectedIndex(int index, {bool notify = true}){
    keyList = [];
    inputFieldControllerList = [];
    offlineMethodSelectedIndex = index;
    if(offlinePaymentModel != null && offlinePaymentModel!.offlineMethods!= null && offlinePaymentModel!.offlineMethods!.isNotEmpty){
      offlineMethodSelectedId = offlinePaymentModel!.offlineMethods![offlineMethodSelectedIndex].id!;
      offlineMethodSelectedName = offlinePaymentModel!.offlineMethods![offlineMethodSelectedIndex].methodName!;
    }

    if(offlinePaymentModel!.offlineMethods != null && offlinePaymentModel!.offlineMethods!.isNotEmpty && offlinePaymentModel!.offlineMethods![index].methodInformations!.isNotEmpty){
      for(int i= 0; i< offlinePaymentModel!.offlineMethods![index].methodInformations!.length; i++){
        inputFieldControllerList.add(TextEditingController());
        keyList.add(offlinePaymentModel!.offlineMethods![index].methodInformations![i].customerInput);
      }
    }
    if(notify){
      notifyListeners();
    }

  }

  Future<ApiResponse> digitalPayment({String? orderNote, String? customerId,
      String? addressId, String? billingAddressId,
      String? couponCode,
      String? couponDiscount,
      String? paymentMethod}) async {
    _isLoading =true;

    ApiResponse apiResponse = await orderRepo!.digitalPayment(orderNote, customerId, addressId, billingAddressId, couponCode, couponDiscount, paymentMethod);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
     Navigator.pushReplacement(Get.context!, MaterialPageRoute(builder: (_) => DigitalPaymentScreen(url: apiResponse.response?.data['redirect_link'])));

    }else {
      _isLoading = false;
      showCustomSnackBar('${getTranslated('payment_method_not_properly_configured', Get.context!)}', Get.context!);
    }
    notifyListeners();
    return apiResponse;
  }

  bool searching = false;
  Future<ApiResponse> trackYourOrder({String? orderId, String? phoneNumber}) async {
    searching = true;
    ApiResponse apiResponse = await orderRepo!.trackYourOrder(orderId!, phoneNumber!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      searching = false;
      _orderDetails = [];
      apiResponse.response!.data.forEach((order) => _orderDetails!.add(OrderDetailsModel.fromJson(order)));
    } else {
      searching = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> downloadDigitalProduct({int? orderDetailsId}) async {

    ApiResponse apiResponse = await orderRepo!.downloadDigitalProduct(orderDetailsId!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Provider.of<AuthProvider>(Get.context!, listen: false).resendTime = (apiResponse.response!.data["time_count_in_second"]);
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> resendOtpForDigitalProduct({int? orderId}) async {
    ApiResponse apiResponse = await orderRepo!.resendOtpForDigitalProduct(orderId!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> otpVerificationDigitalProduct({required int orderId, required String otp}) async {
    ApiResponse apiResponse = await orderRepo!.otpVerificationForDigitalProduct(orderId, otp);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      _launchUrl(Uri.parse('${AppConstants.baseUrl}${AppConstants.otpVerificationForDigitalProduct}?order_details_id=$orderId&otp=$otp&guest_id=1&action=download'));

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> reorder({String? orderId}) async {
    _isLoading =true;

    ApiResponse apiResponse = await orderRepo!.reorder(orderId!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      showCustomSnackBar(apiResponse.response?.data['message'], Get.context!, isError: false);
      Navigator.push(Get.context!, MaterialPageRoute(builder: (_) => const CartScreen()));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }




}
Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}