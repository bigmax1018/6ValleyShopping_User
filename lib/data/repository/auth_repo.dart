import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/social_login_model.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});


  Future<ApiResponse> socialLogin(SocialLoginModel socialLogin) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.socialLoginUri,
        data: socialLogin.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> registration(RegisterModel register) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.registrationUri,
        data: register.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {Response response = await dioClient!.post(
        AppConstants.loginUri,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> logout() async {
    try {Response response = await dioClient!.get(AppConstants.logOut);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateToken() async {
    try {
      String? deviceToken = await _getDeviceToken();
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
      Response response = await dioClient!.post(
        AppConstants.tokenUri,
        data: {"_method": "put",
          'guest_id' : Provider.of<AuthProvider>(Get.context!, listen: false).getGuestToken(),
          "cm_firebase_token": deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String?> _getDeviceToken() async {
    String? deviceToken;
    if(Platform.isIOS) {
      deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }else {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (deviceToken != null) {
      if (kDebugMode) {
        print('--------Device Token---------- $deviceToken--');
      }
    }
    return deviceToken;
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient!.updateHeader(token, null);
    try {
      await sharedPreferences!.setString(AppConstants.userLoginToken, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> setLanguageCode(String languageCode) async {
    try {
      final response = await dioClient!.post(AppConstants.setCurrentLanguage, data: {
        'current_language' : languageCode,
        '_method' : 'put'
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  String getUserToken() {
    return sharedPreferences!.getString(AppConstants.userLoginToken) ?? "";
  }

  Future<void> saveGuestId(String guestId) async {
    try {
      await sharedPreferences!.setString(AppConstants.guestId, guestId);
    } catch (e) {
      rethrow;
    }
  }

  String? getGuestIdToken() {
    return sharedPreferences!.getString(AppConstants.guestId) ?? "1";
  }

  bool isGuestIdExist() {
    return sharedPreferences!.containsKey(AppConstants.guestId);
  }

  Future<bool> clearGuestId() async {
    sharedPreferences!.remove(AppConstants.guestId);
    return true;
  }



  bool isLoggedIn() {
    return sharedPreferences!.containsKey(AppConstants.userLoginToken);
  }

  Future<bool> clearSharedData() async {
    sharedPreferences?.remove(AppConstants.userLoginToken);
    sharedPreferences?.remove(AppConstants.guestId);
    return true;
  }

  // for verify Email
  Future<ApiResponse> checkEmail(String email, String temporaryToken) async {
    try {
      Response response = await dioClient!.post(AppConstants.checkEmailUri,
          data: {"email": email, "temporary_token" : temporaryToken});
        return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendEmailOtp(String email, String temporaryToken) async {
    try {
      Response response = await dioClient!.post(AppConstants.resendEmailOtpUri,
          data: {"email": email, "temporary_token" : temporaryToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmail(String email, String token, String tempToken) async {
    try {
      Response response = await dioClient!.post(AppConstants.verifyEmailUri, data: {"email": email, "token": token, 'temporary_token': tempToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  //verify phone number

  Future<ApiResponse> checkPhone(String phone, String temporaryToken) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.checkPhoneUri,
          data: {"phone": phone, "temporary_token" :temporaryToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendPhoneOtp(String phone, String temporaryToken) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.resendPhoneOtpUri,
          data: {"phone": phone, "temporary_token" :temporaryToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(String phone, String token,String otp) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.verifyPhoneUri, data: {"phone": phone.trim(), "temporary_token": token,"otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> verifyOtp(String identity, String otp) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.verifyOtpUri, data: {"identity": identity.trim(), "otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String identity, String otp ,String password, String confirmPassword) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.resetPasswordUri, data: {"_method" : "put", "identity": identity.trim(), "otp": otp,"password": password, "confirm_password":confirmPassword});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences!.setString(AppConstants.userPassword, password);
      await sharedPreferences!.setString(AppConstants.userEmail, email);
    } catch (e) {
      rethrow;
    }
  }

  String getUserEmail() {
    return sharedPreferences!.getString(AppConstants.userEmail) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences!.getString(AppConstants.userPassword) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences!.remove(AppConstants.userPassword);
    return await sharedPreferences!.remove(AppConstants.userEmail);
  }

  Future<ApiResponse> forgetPassword(String identity) async {
    try {
      Response response = await dioClient!.post(AppConstants.forgetPasswordUri, data: {"identity": identity});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getGuestId() async {
    try {
      final response = await dioClient!.get(AppConstants.getGuestIdUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
