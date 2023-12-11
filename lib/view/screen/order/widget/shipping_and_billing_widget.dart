import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/icon_with_text_row.dart';
import 'package:provider/provider.dart';

class ShippingAndBillingWidget extends StatelessWidget {
  final OrderProvider orderProvider;
  const ShippingAndBillingWidget({Key? key, required this.orderProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  orderProvider.orders!.orderType == 'POS' ? Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.homePagePadding),
        color: Theme.of(context).highlightColor,
        child: Text(getTranslated('pos_order', context)!)) :
    Container(decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(Images.mapBg), fit: BoxFit.cover)),
        child: Card(margin: const EdgeInsets.all(Dimensions.marginSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),

            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconWithTextRow(
                  icon: Icons.delivery_dining_outlined,
                  iconColor: Theme.of(context).primaryColor,
                  text: getTranslated('address_info', context)!,
                  textColor: Theme.of(context).primaryColor,
                ),


                orderProvider.onlyDigital?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Divider(),

                    Text(getTranslated('shipping', context)!),
                    const SizedBox(height: Dimensions.marginSizeSmall),


                  IconWithTextRow(
                    icon: Icons.person,
                    text: '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.contactPersonName : ''}',
                  ),
                  const SizedBox(height: Dimensions.marginSizeSmall),


                  IconWithTextRow(
                    icon: Icons.call,
                    text: '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.phone : ''}',
                  ),
                    const SizedBox(height: Dimensions.marginSizeSmall),


                    Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white : Theme.of(context).primaryColor.withOpacity(.30)),
                        const SizedBox(width: Dimensions.marginSizeSmall),

                        Expanded(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text('${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.address : ''}',
                              maxLines: 3, overflow: TextOverflow.ellipsis,
                              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                        )),
                      ],
                    ),

                  Row(children: [
                      Expanded(
                        child: IconWithTextRow(
                          icon: Icons.location_city,
                          text: '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.country : ''}',
                        ),
                      ),

                      Expanded(
                        child: IconWithTextRow(
                          icon: Icons.location_city,
                          text: '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.zip : ''}',
                        ),
                      ),
                    ],
                  ),

                  ],
                ):const SizedBox(),

                const SizedBox(height: Dimensions.paddingSizeDefault),



                orderProvider.orderModel !=null && orderProvider.orders!.billingAddressData != null?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(getTranslated('billing', context)!),
                      const SizedBox(height: Dimensions.marginSizeSmall),

                      IconWithTextRow(
                        icon: Icons.person,
                        text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.contactPersonName : ''}',
                      ),
                      const SizedBox(height: Dimensions.marginSizeSmall),
                      IconWithTextRow(
                        icon: Icons.call,
                        text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.phone : ''}',
                      ),
                      const SizedBox(height: Dimensions.marginSizeSmall),



                      Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white : Theme.of(context).primaryColor.withOpacity(.30)),
                          const SizedBox(width: Dimensions.marginSizeSmall),

                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(' ${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.address : ''}',
                                maxLines: 3, overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                          )),
                        ],
                      ),
                  Row(children: [
                    Expanded(
                      child: IconWithTextRow(
                        icon: Icons.location_city,
                        text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.country : ''}',
                      ),
                    ),

                    Expanded(
                      child: IconWithTextRow(
                        icon: Icons.location_city,
                        text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.zip : ''}',
                      ),
                    ),
                  ],
                  ),
                    ]
                ):const SizedBox(),


              ],
            ),

          ),

        )
    );
  }
}
