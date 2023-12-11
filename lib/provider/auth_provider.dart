import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/response_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/social_login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/auth_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo? authRepo;
  AuthProvider({required this.authRepo});

  bool _isLoading = false;
  bool? _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  String countryDialCode = '+880';
  void setCountryCode( String countryCode, {bool notify = true}){
    countryDialCode  = countryDialCode;
    if(notify){
      notifyListeners();
    }

  }

  updateSelectedIndex(int index, {bool notify = true}){
    _selectedIndex = index;
    if(notify){
      notifyListeners();
    }

  }


  bool get isLoading => _isLoading;
  bool? get isRemember => _isRemember;

  void updateRemember() {
    _isRemember = !_isRemember!;
    notifyListeners();
  }

  Future socialLogin(SocialLoginModel socialLogin, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.socialLogin(socialLogin);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String? message = '';
      String? token = '';
      String? temporaryToken= '';
      try{
        message = map['error_message'];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
      try{
        token = map['token'];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
      try{
        temporaryToken = map['temporary_token'];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }

      if(token != null){
        authRepo!.saveUserToken(token);
        await authRepo!.updateToken();
        setCurrentLanguage(Provider.of<LocalizationProvider>(Get.context!, listen: false).getCurrentLanguage()??'en');
      }
      callback(true, token,temporaryToken,message );
      notifyListeners();
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
      callback(false, '', '',errorMessage);
      notifyListeners();
    }
  }


  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.registration(register);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String? temporaryToken = '';
      String? token = '';
      String? message = '';
      try{
        message = map["message"];

      }catch(e){

        if (kDebugMode) {
          print(e);
        }
      }
      try{
        token = map["token"];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }

      }
      try{
        temporaryToken = map["temporary_token"];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }

      }
      if(token != null && token.isNotEmpty){
        authRepo!.saveUserToken(token);
        await authRepo!.updateToken();
      }
      callback(true, token, temporaryToken, message);
      notifyListeners();
    }else{
     showCustomSnackBar('${getTranslated('email_already_taken', Get.context!)}', Get.context!);
    }
    notifyListeners();
  }



  Future logOut() async {
    ApiResponse apiResponse = await authRepo!.logout();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

    }
  }

  Future<void> setCurrentLanguage(String currentLanguage) async {
    ApiResponse apiResponse = await authRepo!.setLanguageCode(currentLanguage);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

    }
  }



  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      clearGuestId();
      Map map = apiResponse.response!.data;
      String? temporaryToken = '';
      String? token = '';
      String? message = '';
      try{
        message = map["message"];
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
      try{
        token = map["token"];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
      try{
        temporaryToken = map["temporary_token"];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }


      if(token != null && token.isNotEmpty){
        authRepo!.saveUserToken(token);
        await authRepo!.updateToken();
      }

      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderList(1,'delivered');

      callback(true, token, temporaryToken, message);
      notifyListeners();
    } else {
      _isLoading = false;
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
      callback(false, '', '' , errorMessage);
      notifyListeners();
    }
  }




  Future<void> updateToken(BuildContext context) async {
    ApiResponse apiResponse = await authRepo!.updateToken();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

    } else {
      ApiChecker.checkApi( apiResponse);
    }
  }

  //email
  Future<ResponseModel> checkEmail(String email, String temporaryToken, {bool resendOtp = false}) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse;
    if(resendOtp){
      apiResponse = await authRepo!.resendEmailOtp(email,temporaryToken);
    }else{
      apiResponse = await authRepo!.checkEmail(email,temporaryToken);
    }
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data['token'], true);
      resendTime = (apiResponse.response!.data["resend_time"]);
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
      responseModel = ResponseModel(errorMessage,false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.verifyEmail(email, _verificationCode, token);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      authRepo!.saveUserToken(apiResponse.response!.data['token']);
      await authRepo!.updateToken();
      responseModel = ResponseModel('Successful', true);
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
      responseModel = ResponseModel(errorMessage, false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  //phone


  int resendTime = 0;

  Future<ResponseModel> checkPhone(String phone, String temporaryToken,{bool fromResend = false}) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse; //= await authRepo!.checkPhone(phone, temporaryToken);
    if(fromResend){
      apiResponse = await authRepo!.resendPhoneOtp(phone, temporaryToken);
    }else{
      apiResponse = await authRepo!.checkPhone(phone, temporaryToken);
    }
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data["token"],true);
      resendTime = (apiResponse.response!.data["resend_time"]);
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
          print('=error==${errorResponse.errors![0].message}');
        }
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel( errorMessage,false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyPhone(String phone, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.verifyPhone(phone, token, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel( apiResponse.response!.data["message"], true);
    }
    else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage,false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel> verifyOtp(String phone) async {
    debugPrint('---Forget----> $phone & $_verificationCode');
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();

    ApiResponse apiResponse = await authRepo!.verifyOtp(phone, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel( apiResponse.response!.data["message"], true);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage,false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel> resetPassword(String identity, String otp, String password, String confirmPassword) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.resetPassword(identity,otp,password,confirmPassword);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel( apiResponse.response!.data["message"], true);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage,false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }



  // for phone verification
  bool _isPhoneNumberVerificationButtonLoading = false;

  bool get isPhoneNumberVerificationButtonLoading => _isPhoneNumberVerificationButtonLoading;
  String? _verificationMsg = '';

  String? get verificationMessage => _verificationMsg;
  String _email = '';
  String _phone = '';

  String get email => _email;
  String get phone => _phone;

  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }
  updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void clearVerificationMessage() {
    _verificationMsg = '';
  }


  // for verification Code
  String _verificationCode = '';

  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;

  bool get isEnableVerificationCode => _isEnableVerificationCode;

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }





  // for user Section
  String getUserToken() {
    return authRepo!.getUserToken();
  }

  String? getGuestToken() {
    return authRepo!.getGuestIdToken();
  }




  bool isLoggedIn() {
    return authRepo!.isLoggedIn();
  }

  bool isGuestIdExist() {
    return authRepo!.isGuestIdExist();
  }

  Future<bool> clearSharedData()  {
    return authRepo!.clearSharedData();
  }

  Future<bool> clearGuestId() async {
    return await authRepo!.clearGuestId();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo!.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo!.getUserEmail();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo!.clearUserEmailAndPassword();
  }


  String getUserPassword() {
    return authRepo!.getUserPassword();
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.forgetPassword(email.replaceAll('+', ''));
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data["message"], true);
      showCustomSnackBar(apiResponse.response?.data['message'], Get.context!, isError: false);
    }
    else {
      showCustomSnackBar('user not found', Get.context!);
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
    }
    return responseModel;
  }







  Future<void> getGuestIdUrl() async {
    ApiResponse apiResponse = await authRepo!.getGuestId();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      authRepo?.saveGuestId(apiResponse.response!.data['guest_id'].toString());
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


}

