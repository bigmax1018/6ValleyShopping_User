import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';

class GuestDialog extends StatelessWidget {
  const GuestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [

        Positioned(
          left: 0, right: 0, top: -50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(Images.login, height: 80, width: 80),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(getTranslated('THIS_SECTION_IS_LOCK', context)!, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Text(getTranslated('GOTO_LOGIN_SCREEN_ANDTRYAGAIN', context)!, textAlign: TextAlign.center, style: titilliumRegular),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Divider(height: 0, color: Theme.of(context).hintColor),
              Row(children: [

                Expanded(child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
                    child: Text(getTranslated('cancel', context)!, style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
                  ),
                )),

                Expanded(child: InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false),
                  child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10))),
                    child: Text(getTranslated('login', context)??'', style: titilliumBold.copyWith(color: Colors.white)),
                  ),
                )),

              ]),
            ],
          ),
        ),

      ]),
    );
  }
}
