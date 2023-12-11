import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ProceedButton extends StatelessWidget {
  const ProceedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Consumer<OrderProvider>(
          builder: (context, order, child) {
            return !Provider.of<OrderProvider>(context).isLoading ?
            Text(getTranslated('proceed', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
              color: ColorResources.white)):
            Container(height: 30,width: 30 ,alignment: Alignment.center,
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).highlightColor)),
            );
          },
        ),
      ),
    );
  }
}
