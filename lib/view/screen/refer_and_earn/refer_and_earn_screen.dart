

import 'package:dotted_border/dotted_border.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/refer_and_earn/widgets/refer_hint_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> shareItem = [Images.share];
    final List<String> hintList = [getTranslated("invite_your_friends", context)!, '${getTranslated('they_register', context)} ${AppConstants.appName} ${getTranslated('with_special_offer', context)}', '${getTranslated('you_made_your_earning', context)}'];
    return Scaffold(

      body:Column(
        children: [
          CustomAppBar(title: '${getTranslated('refer_and_earn', context)}'),
          Expanded(
            child: ExpandableBottomSheet(
              background: Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
                      child: Image.asset(Images.referAndEarn, height: MediaQuery.of(context).size.height * 0.2),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),

                    Text('${getTranslated('invite_friend_and_businesses', context)}',
                      textAlign: TextAlign.center, style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                    Text('${getTranslated('copy_your_code', context)}', textAlign: TextAlign.center, style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                    )),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                    Text('${getTranslated('your_personal_code', context)}', textAlign: TextAlign.center,
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color:  Provider.of<ThemeProvider>(context, listen: false).darkTheme?  Theme.of(context).hintColor: Theme.of(context).primaryColor.withOpacity(.5)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge,),

                    DottedBorder(padding: const EdgeInsets.all(3), borderType: BorderType.RRect,
                      radius: const Radius.circular(20), dashPattern: const [5, 5],
                      color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.grey : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      strokeWidth: 1,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: Text(Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.referCode??'',
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.referCode??''));
                            showCustomSnackBar(getTranslated('referral_code_copied', context), context, isError: false);
                          },
                          child: Container(
                            width: 85,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(60),
                            ),
                            child: Text('${getTranslated('copy', context)}',style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white.withOpacity(0.9),
                            )),
                          ),
                        ),

                      ]),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                    Text('${getTranslated('or_share', context)}', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),

                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: shareItem.map((item) => GestureDetector(
                        onTap: () => Share.share('Greetings, 6Valley is the best e-commerce platform in the country. If you are new to this website don’t forget to use "${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.referCode??''}" as the referral code while sign up into 6valley. ${'${Provider.of<SplashProvider>(context, listen: false).configModel?.refSignup}${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.referCode??''}'}',),
                        child: Container(margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                          child: Image.asset(item, height: 45, width: 45),),
                      )).toList(),),
                    ),
                  ],
                ),
              ),
              persistentContentHeight: 80,
              expandableContent: ReferHintView(hintList: hintList),


            ),
          ),
        ],
      ),
    );
  }
}
