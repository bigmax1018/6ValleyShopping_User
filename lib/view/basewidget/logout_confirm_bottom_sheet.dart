import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class LogoutCustomBottomSheet extends StatelessWidget {
  const LogoutCustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40,height: 4,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.5), borderRadius: BorderRadius.circular(20)),),
        const SizedBox(height: 30,),

       Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: SizedBox(width: 60,child: Image.asset(Images.exitIcon)),),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

        Text(getTranslated('sign_out', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
          child: Text('${getTranslated('want_to_sign_out', context)}'),),

        const SizedBox(height: Dimensions.paddingSizeDefault),
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Expanded(child: SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('cancel', context)}',
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.5),
                textColor: Theme.of(context).textTheme.bodyLarge?.color,
                onTap: ()=> Navigator.pop(context),))),

            const SizedBox(width: Dimensions.paddingSizeDefault,),
            Expanded(child: SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('sign_out', context)}',
                onTap: (){
              Provider.of<AuthProvider>(context, listen: false).logOut().then((condition) {
                Navigator.pop(context);
                Provider.of<AuthProvider>(context,listen: false).clearSharedData();
                Provider.of<ProfileProvider>(context, listen: false).initAddressList();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
              });
            })),
            )
          ],),
        )

      ],),
    );
  }
}
