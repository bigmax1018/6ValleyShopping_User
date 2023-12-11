import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
class PromiseScreen extends StatelessWidget {
  const PromiseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double  width = 30;
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Column(children: [
        SizedBox(width: width, child: Image.asset(Images.sevenDayEasyReturn),),

          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Text(getTranslated('seven_days_return', context)!,maxLines: 2,
              overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
          ),],),
      ),
      const SizedBox(width: Dimensions.paddingSizeDefault,),

        Expanded(child: Column(children: [
          SizedBox(width: width, child: Image.asset(Images.safePayment),),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Text(getTranslated('safe_payment', context)!,
                maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
          ),],),
      ),
      const SizedBox(width: Dimensions.paddingSizeDefault,),


        Expanded(child: Column(children: [
          SizedBox(width: width, child: Image.asset(Images.hundredParAuthentic),),
          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Text(getTranslated('authentic_product', context)!,
              maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
          ),],),
        ),
    ],);
  }
}
