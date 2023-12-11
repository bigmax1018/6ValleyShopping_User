import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';

class NotLoggedInWidget extends StatelessWidget {
  const NotLoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: SizedBox(width: 60,child: Image.asset(Images.loginIcon)),),
        Text(getTranslated('please_login', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
          child: Text('${getTranslated('need_to_login', context)}'),),

        Center(child: SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('login', context)}',
            backgroundColor: Theme.of(context).primaryColor,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen())))),
        ),
      InkWell(onTap: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const DashBoardScreen()), (route) => false),
        child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
          child: Text(getTranslated('back_to_home', context)!,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline),),
        ),
      ),
      ],
    );
  }
}
