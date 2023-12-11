import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/coupon_item_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class ShopCouponItem extends StatelessWidget {
  final Coupons coupons;
  const ShopCouponItem({Key? key, required this.coupons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall, Dimensions.fontSizeDefault,0),
      child: Stack(clipBehavior: Clip.none, children: [
          ClipRRect(clipBehavior: Clip.none,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                  boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? null : [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.12), spreadRadius: 1, blurRadius: 1, offset: const Offset(0,1))],
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125))
              ),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [
                          SizedBox(width: 30,child: Image.asset(coupons.couponType == 'free_delivery'? Images.freeCoupon :coupons.discountType == 'percentage'? Images.offerIcon :Images.firstOrder)),

                          coupons.couponType == 'free_delivery'?
                          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: Text('${getTranslated('free_delivery', context)}',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),),
                          ):

                          coupons.discountType == 'percentage'?
                          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: Text('${coupons.discount} ${'% ${getTranslated('off', context)}'}',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor),),
                          ): Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: Text('${PriceConverter.convertPrice(context, coupons.discount)} ${getTranslated('OFF', context)}',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor),),
                          ),
                          Text(getTranslated(coupons.couponType, context)??'',
                              style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),

                        ],),
                      ),
                    ),

                    Expanded(flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [



                          Container(width: 180,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeExtraLarge, Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeExtraSmall),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  border: Border.all(color: Theme.of(context).primaryColor)),
                              child: Text(coupons.code??'', style: titleRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge))),


                          Container(transform: Matrix4.translationValues(0, -70, 0),
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                                color: Theme.of(context).primaryColor
                            ),
                            child: Text('${getTranslated('coupon_code', context)}', style: textRegular.copyWith(color: Colors.white),),),





                          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: Text('${getTranslated('available_till', context)} ${DateConverter.estimatedDate(DateTime.parse(coupons.expireDatePlanText!))}',
                                style: textRegular.copyWith()),
                          ),
                          Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                            child: Text('${getTranslated('minimum_purchase_amount', context)} ${PriceConverter.convertPrice(context, coupons.minPurchase)}',
                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                          ),

                        ],),
                      ),
                    ),
                  ],
                ),
              ),),
          ),






          Positioned(top: 0,left: 0, child: InkWell(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: coupons.code??''));
                showCustomSnackBar(getTranslated('coupon_code_copied_successfully', Get.context!), Get.context!, isError: false);
              },
              child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Icon(Icons.copy_rounded, color: Theme.of(context).primaryColor.withOpacity(.65))))),



        ],
      ),
    );
  }
}