import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/shipping_details_widget.dart';
import 'package:provider/provider.dart';

class GuestModeInfoPicker extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  const GuestModeInfoPicker({Key? key, required this.icon, required this.title, required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context,profileProvider,_) {
        return Consumer<OrderProvider>(
          builder: (context, shipping,_) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  border: Border.all(width: 0.75, color: Theme.of(context).primaryColor.withOpacity(.25)),

                ),
                child: Column(children: [
                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(
                        child: Row(children: [
                          SizedBox(width: 25, child: Image.asset(icon)),
                          Text('${getTranslated(title, context)}', style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),)
                        ],),
                      ),
                      SizedBox(width: 25, child: Image.asset(Images.edit))
                    ],),
                  ),

                  const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                      child: Divider()),

                  if(Provider.of<OrderProvider>(context,listen: false).addressIndex == null)
                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: SizedBox(width: 25, child: Image.asset(Images.contactInfoIcon))),

                  Provider.of<OrderProvider>(context,listen: false).addressIndex == null ?
                  Padding(padding: const EdgeInsets.only(bottom : Dimensions.paddingSizeExtraLarge),
                    child: Text('${getTranslated(subTitle, context)}',
                      style: textRegular.copyWith(color: Theme.of(context).hintColor),),):

                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: (profileProvider.addressList.isNotEmpty)?
                    Column(children: [
                      AddressInfoItem(icon: Images.user, title: profileProvider.addressList[shipping.addressIndex!].contactPersonName??''),
                      AddressInfoItem(icon: Images.callIcon, title: profileProvider.addressList[shipping.addressIndex!].phone??''),
                      AddressInfoItem(icon: Images.address, title: profileProvider.addressList[shipping.addressIndex!].address??''),

                    ],
                    ):const SizedBox(),
                  ),

                ],),
              ),
            );
          }
        );
      }
    );
  }
}
