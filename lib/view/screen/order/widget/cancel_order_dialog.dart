import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class CancelOrderDialog extends StatefulWidget {
  final int? orderId;
   const CancelOrderDialog({super.key, required this.orderId});

  @override
  State<CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),


        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).cardColor,
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(Dimensions.homePagePadding),
          child: Column(
            children: [
              Image.asset(Images.cancelOrder, height: 60),
              const SizedBox(height: Dimensions.homePagePadding),

              Text(getTranslated('are_you_sure_you_want_to_cancel_your_order', context)!,
                textAlign: TextAlign.center,

                style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: Dimensions.homePagePadding),

              // Text(getTranslated('if_you_want_to_cancel_order_please_give_a_reason', context)!,
              //   textAlign: TextAlign.start,
              //   style: titilliumRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall, fontWeight: FontWeight.w400),
              // ),
              const SizedBox(height: Dimensions.homePagePadding),


              //  CustomTextField(
              //   maxLines: 3,
              //   inputAction: TextInputAction.done,
              //   inputType: TextInputType.text,
              //   hintText: getTranslated('write_here', context),
              // ),
              // const SizedBox(height: Dimensions.homePagePadding),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: CustomButton(

                    textColor: Theme.of(context).textTheme.bodyLarge?.color,
                    backgroundColor: Theme.of(context).hintColor.withOpacity(0.50),
                    buttonText:  getTranslated('NO', context)!,
                    onTap: () {
                      Navigator.pop(context);
                    },

                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: CustomButton(
                    buttonText:  getTranslated('YES', context)!,
                    onTap: () {
                      Provider.of<OrderProvider>(context, listen: false)
                          .cancelOrder(context, widget.orderId)
                          .then((value) {
                        if (value.response!.statusCode == 200) {
                          Provider.of<OrderProvider>(context, listen: false).getOrderList(1, Provider.of<OrderProvider>(context, listen: false).selectedType);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showCustomSnackBar(getTranslated('order_cancelled_successfully', context)!, context, isError: false);
                        }
                      });
                    },

                  ),
                ),
              ]),


            ],
          ),
        ),
      ],
      ),
    );
  }
}
