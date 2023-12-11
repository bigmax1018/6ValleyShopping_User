import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';
class ResetPasswordWidget extends StatefulWidget {
  final String mobileNumber;
  final String otp;
  const ResetPasswordWidget({Key? key,required this.mobileNumber,required this.otp}) : super(key: key);

  @override
  ResetPasswordWidgetState createState() => ResetPasswordWidgetState();
}

class ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  final FocusNode _newPasswordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  GlobalKey<FormState>? _formKeyReset;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }


  void resetPassword() async {
      String password = _passwordController!.text.trim();
      String confirmPassword = _confirmPasswordController!.text.trim();

      if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      }else if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
          backgroundColor: Colors.red,
        ));
      } else {
        Provider.of<AuthProvider>(context, listen: false).resetPassword(widget.mobileNumber,widget.otp,
            password, confirmPassword).then((value) {
          if(value.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(getTranslated('password_reset_successfully', context)!),
                  backgroundColor: Colors.green,)
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
          }else {
            showCustomSnackBar(value.message, context);
          }
        });

      }
    // }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyReset,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset(Images.logoWithNameImage, height: 150, width: 200),
            ),

            Padding(
              padding: const EdgeInsets.all(Dimensions.marginSizeLarge),
              child: Text(getTranslated('password_reset', context)!, style: titilliumSemiBold),
            ),
            // for new password
            Container(
                margin:
                const EdgeInsets.only(left: Dimensions.marginSizeLarge, right: Dimensions.marginSizeLarge,
                    bottom: Dimensions.marginSizeSmall),
                child: CustomTextField(
                  hintText: getTranslated('new_password', context),
                  focusNode: _newPasswordNode,
                  nextFocus: _confirmPasswordNode,
                  isPassword: true,
                  controller: _passwordController,
                )),

            // for confirm Password
            Container(
                margin:
                const EdgeInsets.only(left: Dimensions.marginSizeLarge, right: Dimensions.marginSizeLarge,
                    bottom: Dimensions.marginSizeDefault),
                child: CustomTextField(
                  isPassword: true,
                  hintText: getTranslated('confirm_password', context),
                  inputAction: TextInputAction.done,
                  focusNode: _confirmPasswordNode,
                  controller: _confirmPasswordController,
                )),


            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
              child: Provider.of<AuthProvider>(context).isLoading
                  ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              )
                  : CustomButton(onTap: resetPassword, buttonText: getTranslated('reset_password', context)),
            ),


          ],
        ),
      ),
    );
  }
}
