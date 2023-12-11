import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/reset_password_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  final String tempToken;
  final String mobileNumber;
  final String? email;
  final bool fromForgetPassword;
  final bool fromDigitalProduct;
  final int? orderId;

  const VerificationScreen(this.tempToken, this.mobileNumber, this.email, {Key? key, this.fromForgetPassword = false,  this.fromDigitalProduct = false, this.orderId}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? _timer;
  int? _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = Provider.of<AuthProvider>(context, listen: false).resendTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if(_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }



  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
  @override
  Widget build(BuildContext context) {

    int minutes = (_seconds! / 60).truncate();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');




    return Scaffold(

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          widget.fromDigitalProduct? CustomAppBar(title: '${getTranslated('verify_otp', context)}'): const SizedBox(),
              const SizedBox(height: 55),
              Image.asset(Images.login, width: 100, height: 100,),
              const SizedBox(height: 40),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(child: Text(widget.email == ''?
                '${getTranslated('please_enter_4_digit_code', context)}\n${widget.mobileNumber}':
                '${getTranslated('please_enter_4_digit_code', context)}\n${widget.email}',
                  textAlign: TextAlign.center,)),),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                child: PinCodeTextField(
                  length: 4,
                  appContext: context,
                  obscureText: false,
                  showCursor: true,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 63,
                    fieldWidth: 55,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(10),
                    selectedColor: ColorResources.colorMap[200],
                    selectedFillColor: Colors.white,
                    inactiveFillColor: ColorResources.getSearchBg(context),
                    inactiveColor: ColorResources.colorMap[200],
                    activeColor: ColorResources.colorMap[400],
                    activeFillColor: ColorResources.getSearchBg(context),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: authProvider.updateVerificationCode,
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),


              if(_seconds! <= 0)
              Column(children: [
                Center(child: Text(getTranslated('i_didnt_receive_the_code', context)!,)),


                Center(
                  child: InkWell(
                    onTap: () {
                      if(widget.fromForgetPassword){
                        Provider.of<AuthProvider>(context, listen: false).forgetPassword(widget.mobileNumber).then((value) {
                          if (value.isSuccess) {
                            _startTimer();
                            showCustomSnackBar('Resent code successful', context, isError: false);
                          } else {
                            showCustomSnackBar(value.message, context);
                          }
                        });

                      }
                      else if(widget.email!.isNotEmpty){
                        Provider.of<AuthProvider>(context, listen: false).checkEmail(widget.email!, widget.tempToken, resendOtp: true).then((value) {
                          if (value.isSuccess) {
                            _startTimer();
                            showCustomSnackBar('Resent code successful', context, isError: false);
                          } else {
                            showCustomSnackBar(value.message, context);
                          }
                        });

                      }else if(widget.fromDigitalProduct){
                        Provider.of<OrderProvider>(context, listen: false).resendOtpForDigitalProduct(orderId: widget.orderId).then((value) {
                          if (value.response?.statusCode == 200) {
                            _startTimer();
                            showCustomSnackBar('Resent code successful', context, isError: false);
                          }
                        });

                      }else{
                        Provider.of<AuthProvider>(context, listen: false).checkPhone(widget.mobileNumber,widget.tempToken, fromResend: true).then((value) {
                          if (value.isSuccess) {
                            _startTimer();
                            showCustomSnackBar('Resent code successful', context, isError: false);
                          } else {
                            showCustomSnackBar(value.message, context);
                          }
                        });
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      child: Text(getTranslated('resend_code', context)!,
                        style: robotoBold.copyWith(color: Theme.of(context).primaryColor),),),
                  ),
                ),
              ],),





              if(_seconds! > 0)
                Text('${getTranslated('resend_code', context)} ${getTranslated('after', context)} ${_seconds! > 0 ? '$minutesStr:${_seconds! % 60}' : ''} ${'Sec'}'),



              const SizedBox(height: 48),

              if(widget.fromDigitalProduct)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                  child: CustomButton(buttonText: getTranslated('verify', context),
                    onTap: (){
                      Provider.of<OrderProvider>(context, listen: false).otpVerificationDigitalProduct(orderId: widget.orderId!, otp: authProvider.verificationCode).then((value) {
                        if(value.response?.statusCode == 200) {
                          Navigator.of(context).pop();
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(getTranslated('input_valid_otp', context)!),
                                backgroundColor: Colors.red,)
                          );
                        }
                      });

                  },),
                ),

              if(!widget.fromDigitalProduct)
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: authProvider.isEnableVerificationCode ? !authProvider.isPhoneNumberVerificationButtonLoading ?
                CustomButton(
                  buttonText: getTranslated('verify', context),

                  onTap: () {
                    bool phoneVerification = Provider.of<SplashProvider>(context,listen: false).configModel!.forgotPasswordVerification =='phone';
                    if(phoneVerification && widget.fromForgetPassword){
                      Provider.of<AuthProvider>(context, listen: false).verifyOtp(widget.mobileNumber).then((value) {
                        if(value.isSuccess) {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (_) => ResetPasswordWidget(mobileNumber: widget.mobileNumber,
                                  otp: authProvider.verificationCode)), (route) => false);
                          }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(getTranslated('input_valid_otp', context)!),
                                backgroundColor: Colors.red,)
                          );
                        }
                      });
                    }else{
                      if(Provider.of<SplashProvider>(context,listen: false).configModel!.phoneVerification!){
                        Provider.of<AuthProvider>(context, listen: false).verifyPhone(widget.mobileNumber,widget.tempToken).then((value) {
                          if(value.isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(getTranslated('sign_up_successfully_now_login', context)!),
                                  backgroundColor: Colors.green,)
                            );
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (_) => const AuthScreen()), (route) => false);
                          }else {
                            showCustomSnackBar(value.message, context);
                          }
                        });
                      }
                      else{
                        Provider.of<AuthProvider>(context, listen: false).verifyEmail(widget.email!,widget.tempToken).then((value) {
                          if(value.isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(getTranslated('sign_up_successfully_now_login', context)!),
                                  backgroundColor: Colors.green,)
                            );
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (_) => const AuthScreen()), (route) => false);
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value.message!),backgroundColor: Colors.red)
                            );
                          }
                        });
                      }
                    }





                  },
                ):  Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
                    : const SizedBox.shrink(),
              )


            ],
          ),
        ),
      ),
    );
  }
}
