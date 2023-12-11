import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/social_login_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/facebook_login_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/google_sign_in_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'mobile_verify_screen.dart';
import 'otp_verification_screen.dart';

class SocialLoginWidget extends StatefulWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  @override
  SocialLoginWidgetState createState() => SocialLoginWidgetState();
}

class SocialLoginWidgetState extends State<SocialLoginWidget> {

  SocialLoginModel socialLogin = SocialLoginModel();
  route(bool isRoute, String? token, String? temporaryToken, String? errorMessage) async {
    if (isRoute) {
      if(token != null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);

      }else if(temporaryToken != null && temporaryToken.isNotEmpty){
        if(Provider.of<SplashProvider>(context,listen: false).configModel!.emailVerification!){
          Provider.of<AuthProvider>(context, listen: false).checkEmail(socialLogin.email.toString(),
              temporaryToken).then((value) async {
            if (value.isSuccess) {
              Provider.of<AuthProvider>(context, listen: false).updateEmail(socialLogin.email.toString());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => VerificationScreen(temporaryToken, '',socialLogin.email.toString())), (route) => false);

            }
          });
        }
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MobileVerificationScreen(temporaryToken)), (route) => false);
      }
      else {
        showCustomSnackBar(errorMessage, context);
      }

    } else {
      showCustomSnackBar(errorMessage, context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (Provider.of<SplashProvider>(context,listen: false).configModel!.socialLogin![0].status! ||
       Provider.of<SplashProvider>(context,listen: false).configModel!.socialLogin![1].status! ||
            Provider.of<SplashProvider>(context,listen: false).configModel!.socialLogin![2].status!)?
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(Images.left, color: Theme.of(context).primaryColor)),
            const SizedBox(width: Dimensions.paddingSizeSmall,),
            Center(child: Text(getTranslated('or_login_with', context)!)),
            const SizedBox(width: Dimensions.paddingSizeSmall,),
            Expanded(child: Image.asset( Images.right)),
          ],
        ) :const SizedBox(),


        Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
             Provider.of<SplashProvider>(context,listen: false).configModel!.socialLogin![0].status!?

              InkWell(onTap: () async{
                  await Provider.of<GoogleSignInProvider>(context, listen: false).login();
                  String? id,token,email, medium;
                  if(context.mounted){}
                  if(Provider.of<GoogleSignInProvider>(Get.context!,listen: false).googleAccount != null){
                    id = Provider.of<GoogleSignInProvider>(Get.context!,listen: false).googleAccount!.id;
                    email = Provider.of<GoogleSignInProvider>(Get.context!,listen: false).googleAccount!.email;
                    token = Provider.of<GoogleSignInProvider>(Get.context!,listen: false).auth.accessToken;
                    medium = 'google';
                    if (kDebugMode) {
                      print('eemail =>$email token =>$token');
                    }
                    socialLogin.email = email;
                    socialLogin.medium = medium;
                    socialLogin.token = token;
                    socialLogin.uniqueId = id;
                    await Provider.of<AuthProvider>(Get.context!, listen: false).socialLogin(socialLogin, route);
                  }

                },
                child: Padding(padding: const EdgeInsets.all(6),
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).cardColor,
                    boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,0))]
                  ),
                    child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                          Container(decoration: const BoxDecoration(color: Colors.white ,
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                            height: 47,width: 47,
                            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Image.asset(Images.google))), // <-- Use 'Image.asset(...)' here
                        ],
                      ),
                    ),
                  ),
                ),
              ) :const SizedBox(),


              Provider.of<SplashProvider>(context,listen: false).configModel!.socialLogin![1].status!?
              InkWell(onTap: () async{
                  await Provider.of<FacebookLoginProvider>(context, listen: false).login();
                  String? id,token,email, medium;
                  if(Provider.of<FacebookLoginProvider>(Get.context!,listen: false).userData != null){
                    id = Provider.of<FacebookLoginProvider>(Get.context!,listen: false).result.accessToken!.userId;
                    email = Provider.of<FacebookLoginProvider>(Get.context!,listen: false).userData!['email'];
                    token = Provider.of<FacebookLoginProvider>(Get.context!,listen: false).result.accessToken!.token;
                    medium = 'facebook';
                    socialLogin.email = email;
                    socialLogin.medium = medium;
                    socialLogin.token = token;
                    socialLogin.uniqueId = id;
                    await Provider.of<AuthProvider>(Get.context!, listen: false).socialLogin(socialLogin, route);
                  }
                },
                child: Padding(padding: const EdgeInsets.all(6),
                  child: Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).cardColor,
                      boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,0))]
                  ),
                    child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Wrap(crossAxisAlignment: WrapCrossAlignment.center,
                        children: [SizedBox(height: 47,width: 47,
                            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Image.asset(Images.facebook),)),
                        ],
                      ),
                    ),
                  ),
                ),
              ):const SizedBox(),


              if(Provider.of<SplashProvider>(context,listen: false).configModel!.socialLogin!.length >2 && Provider.of<SplashProvider>(context,listen: false).configModel!.socialLogin![2].status! && Platform.isIOS)
              Padding(padding: const EdgeInsets.all(6.0),
                child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  child: SizedBox(width: 70,height: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SignInWithAppleButton(
                        style: Provider.of<ThemeProvider>(context, listen: false).darkTheme? SignInWithAppleButtonStyle.black : SignInWithAppleButtonStyle.white,
                        text: '',
                        height: 47,
                        onPressed: () async {
                          String? id,token,email, medium;
                          final credential = await SignInWithApple.getAppleIDCredential(
                            scopes: [
                              AppleIDAuthorizationScopes.email,
                              AppleIDAuthorizationScopes.fullName,
                            ],
                          );
                          id = credential.authorizationCode;
                          email = credential.email??'';
                          token = credential.authorizationCode;
                          medium = 'apple';
                          socialLogin.email = email;
                          socialLogin.medium = medium;
                          socialLogin.token = token;
                          socialLogin.uniqueId = id;
                          await Provider.of<AuthProvider>(Get.context!, listen: false).socialLogin(socialLogin, route);

                          if (kDebugMode) {
                            print('id token =>${credential.identityToken}\n===> Identifier${credential.userIdentifier}\n==>Given Name ${credential.familyName}');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
