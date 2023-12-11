import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/saved_address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/saved_billing_address_list_screen.dart';
import 'package:provider/provider.dart';


class ShippingDetailsWidget extends StatelessWidget {
  final bool hasPhysical;
  final bool billingAddress;
  const ShippingDetailsWidget({Key? key, required this.hasPhysical, required this.billingAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (context, shipping,_) {
          return Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              return Container(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  hasPhysical?
                      Card(child: Container(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                            color: Theme.of(context).cardColor,),
                          child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: Row(
                                    children: [
                                      SizedBox(width: 18, child: Image.asset(Images.deliveryTo)),
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                        child: Text('${getTranslated('delivery_to', context)}',
                                            style: titilliumRegular.copyWith(fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  )),


                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (BuildContext context) => const SavedAddressListScreen())),
                                    child: SizedBox(width: 20, child: Image.asset(Images.edit, scale: 3)),
                                  ),

                                ],
                              ),
                              const SizedBox(height: Dimensions.paddingSizeDefault,),

                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text((Provider.of<OrderProvider>(context,listen: false).addressIndex == null || Provider.of<ProfileProvider>(context, listen: false).addressList.isEmpty) ?
                                    '${getTranslated('address_type', context)}' :
                                    Provider.of<ProfileProvider>(context, listen: false).addressList[
                                    Provider.of<OrderProvider>(context, listen: false).addressIndex!].addressType!.capitalize(),
                                    style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                    maxLines: 3, overflow: TextOverflow.fade,
                                  ),
                                  const Divider(),


                                (Provider.of<OrderProvider>(context,listen: false).addressIndex == null || Provider.of<ProfileProvider>(context, listen: false).addressList.isEmpty)?
                                  Text(getTranslated('add_your_address', context)??'',
                                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                    maxLines: 3, overflow: TextOverflow.fade,
                                  ):Column(children: [
                                    AddressInfoItem(icon: Images.user, title: profileProvider.addressList[shipping.addressIndex!].contactPersonName??''),
                                    AddressInfoItem(icon: Images.callIcon, title: profileProvider.addressList[shipping.addressIndex!].phone??''),
                                    AddressInfoItem(icon: Images.address, title: profileProvider.addressList[shipping.addressIndex!].address??''),

                                ],
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ): const SizedBox(),

                      SizedBox(height: hasPhysical? Dimensions.paddingSizeSmall:0),
                      billingAddress?
                      Card(child: Container(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                            color: Theme.of(context).cardColor,
                          ),
                          child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
                              Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start, children: [
                                  Expanded(child: Row(children: [
                                      SizedBox(width: 18, child: Image.asset(Images.billingTo)),
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                        child: Text('${getTranslated('billing_to', context)}',
                                            style: titilliumRegular.copyWith(fontWeight: FontWeight.w600))),
                                    ],
                                  )),


                                  InkWell(onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) => const SavedBillingAddressListScreen())),
                                    child: SizedBox(width: 20,child: Image.asset(Images.edit, scale: 3)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.paddingSizeDefault,),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text((Provider.of<OrderProvider>(context).billingAddressIndex == null || Provider.of<ProfileProvider>(context, listen: false).billingAddressList.isEmpty) ?
                                  '${getTranslated('address_type', context)}'
                                        : Provider.of<ProfileProvider>(context, listen: false).billingAddressList[
                                    Provider.of<OrderProvider>(context, listen: false).billingAddressIndex!].addressType!.capitalize(),
                                    style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                    maxLines: 1, overflow: TextOverflow.fade,
                                  ),
                                  const Divider(),

                                  (Provider.of<OrderProvider>(context).billingAddressIndex == null || Provider.of<ProfileProvider>(context, listen: false).billingAddressList.isEmpty)?
                                  Text(getTranslated('add_your_address', context)!,
                                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall), maxLines: 3, overflow: TextOverflow.fade,):

                                  Column(children: [
                                    AddressInfoItem(icon: Images.user, title: profileProvider.billingAddressList[shipping.billingAddressIndex!].contactPersonName??''),
                                    AddressInfoItem(icon: Images.callIcon, title: profileProvider.billingAddressList[shipping.billingAddressIndex!].phone??''),
                                    AddressInfoItem(icon: Images.address, title: profileProvider.billingAddressList[shipping.billingAddressIndex!].address??''),

                                  ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ):const SizedBox(),
                    ]),
              );
            }
          );
        }
    );
  }
}

class AddressInfoItem extends StatelessWidget {
  final String? icon;
  final String? title;
  const AddressInfoItem({Key? key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(children: [
        SizedBox(width: 18, child: Image.asset(icon!)),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            child: Text(title??'',style: textRegular.copyWith(),maxLines: 2, overflow: TextOverflow.fade ),),)
      ],),
    );
  }
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}