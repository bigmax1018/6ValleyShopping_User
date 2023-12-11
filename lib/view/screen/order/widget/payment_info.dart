
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/shipping_details_widget.dart';

class PaymentInfo extends StatelessWidget {
  final OrderProvider? order;
  const PaymentInfo({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(getTranslated('PAYMENT_STATUS', context)!,
                        style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

                    Text((order!.orders!.paymentStatus != null && order!.orders!.paymentStatus!.isNotEmpty) ?
                    order!.orders!.paymentStatus! : 'Digital Payment',
                      style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),
                  ]),
            ),


            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated('PAYMENT_PLATFORM', context)!,
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

              Text(order!.orders!.paymentMethod!.replaceAll('_', ' ').capitalize(), style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ]),
          ]),
    );
  }
}
