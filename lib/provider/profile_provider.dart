import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/response_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/user_info_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/profile_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:http/http.dart' as http;


class ProfileProvider extends ChangeNotifier {
  final ProfileRepo? profileRepo;
  ProfileProvider({required this.profileRepo});

  final List<String> _addressTypeList = [];
  String? _addressType = '';
  UserInfoModel? _userInfoModel;
  bool _isLoading = false;
  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;
  List<AddressModel> _addressList =[];
  List<AddressModel> _billingAddressList = [];
  List<AddressModel> _shippingAddressList = [];


  double? _balance;
  double? get balance =>_balance;

  List<String> get addressTypeList => _addressTypeList;
  String? get addressType => _addressType;
  UserInfoModel? get userInfoModel => _userInfoModel;
  bool get isLoading => _isLoading;
  List<AddressModel> get addressList => _addressList;
  List<AddressModel> get billingAddressList => _billingAddressList;
  List<AddressModel> get shippingAddressList => _shippingAddressList;



  Future<void> initAddressList({bool fromRemove = false}) async {
      if(!fromRemove){
        _isLoading = true;
      }
    ApiResponse apiResponse = await profileRepo!.getAllAddress();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _addressList = [];
      _billingAddressList =[];
      _shippingAddressList =[];
      _isLoading = false;
      apiResponse.response!.data.forEach((address) {
        AddressModel addressModel = AddressModel.fromJson(address);
        if(addressModel.isBilling == 1){
          _billingAddressList.add(addressModel);
        }else if(addressModel.isBilling == 0){
          _addressList.add(addressModel);
        }
          _shippingAddressList.add(addressModel);
      });
    } else {
      _isLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  void removeAddressById(int? id, int index, BuildContext context) async {
    ApiResponse apiResponse = await profileRepo!.removeAddressByID(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      showCustomSnackBar(apiResponse.response!.data['message'], Get.context!, isError: false);
      initAddressList(fromRemove: true);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  double? loyaltyPoint = 0;
  String userID = '-1';
  Future<String> getUserInfo(BuildContext context) async {
    ApiResponse apiResponse = await profileRepo!.getUserInfo();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(apiResponse.response!.data);
      userID = _userInfoModel!.id.toString();
      _balance = _userInfoModel?.walletBalance?? 0;
      loyaltyPoint = _userInfoModel?.loyaltyPoint?? 0;
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return userID;
  }


  Future<ApiResponse> deleteCustomerAccount(BuildContext context, int? customerId) async {
    _isDeleting = true;
    notifyListeners();
    ApiResponse apiResponse = await profileRepo!.deleteUserAccount(customerId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      Map map = apiResponse.response!.data;
      String message = map ['message'];
      showCustomSnackBar(message, Get.context!, isError: false);

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }



  void initAddressTypeList(BuildContext context) async {
    if (_addressTypeList.isEmpty) {
      ApiResponse apiResponse = await profileRepo!.getAddressTypeList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _addressTypeList.clear();
        _addressTypeList.addAll(apiResponse.response!.data);
        _addressType = apiResponse.response!.data[0];
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }
  }


  Future<ResponseModel> updateUserInfo(UserInfoModel updateUserModel, String pass, File? file, String token) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.StreamedResponse response = await profileRepo!.updateProfile(updateUserModel, pass, file, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String? message = map["message"];
      _userInfoModel = updateUserModel;
      responseModel = ResponseModel(message, true);
    } else {
      if (kDebugMode) {
        print('${response.statusCode} ${response.reasonPhrase}');
      }
      responseModel = ResponseModel('${response.statusCode} ${response.reasonPhrase}', false);
    }
    notifyListeners();
    return responseModel;
  }


  Future<ApiResponse> contactUs(String name, String email, String phone, String subject, String message) async {
    _isDeleting = true;
    notifyListeners();
    ApiResponse apiResponse = await profileRepo!.contactUs(name, email, phone, subject, message);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
     showCustomSnackBar('${getTranslated('message_sent_successfully', Get.context!)}', Get.context!, isError: false);
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

}
