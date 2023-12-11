import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/coupon_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CouponApplyWidget extends StatelessWidget {
  final TextEditingController couponController;
  final double orderAmount;
  const CouponApplyWidget({Key? key, required this.couponController, required this.orderAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponProvider>(
      builder: (context, couponProvider, _) {
        return Padding(padding: const EdgeInsets.only(left:Dimensions.paddingSizeDefault,right:Dimensions.paddingSizeDefault),
          child: Container(height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color:Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.25))),

            child: (couponProvider.discount != null && couponProvider.discount != 0)?
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                    SizedBox(height: 25,width: 25, child: Image.asset(Images.appliedCoupon)),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Text(couponProvider.couponCode, style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyLarge?.color),),),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      child: Text('(-${PriceConverter.convertPrice(context, couponProvider.discount)} off)',
                        style: textMedium.copyWith(color: Theme.of(context).primaryColor),),),

                  ],
                ),
                InkWell(onTap: (){
                  couponProvider.removeCoupon();
                },
                    child: Icon(Icons.clear, color: Theme.of(context).colorScheme.error,))

              ],),
            ):
            InkWell(onTap: ()=> showModalBottomSheet(context: context,
                    isScrollControlled: true, backgroundColor: Colors.transparent,
                    builder: (c) =>   CouponBottomSheet(orderAmount: orderAmount)),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${getTranslated('add_coupon', context)}', style: textRegular,),
                  Text('${getTranslated('add_more', context)}', style: textMedium.copyWith(color: Theme.of(context).primaryColor),),

                ],),
              ),
            ),
          ),
        );
      }
    );
  }
}
