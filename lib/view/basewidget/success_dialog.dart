import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';

class SuccessDialog extends StatelessWidget {
  final bool isFailed;
  final double rotateAngle;
  final IconData icon;
  final String? title;
  final String? description;
  final Function()? onTap;
  const SuccessDialog({Key? key, this.isFailed = false, this.rotateAngle = 0, required this.icon, required this.title, required this.description, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Stack(clipBehavior: Clip.none, children: [

          Positioned(
            left: 0, right: 0, top: -55,
            child: Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: isFailed ? ColorResources.getRed(context) : Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Transform.rotate(angle: rotateAngle, child: Icon(icon, size: 40, color: Colors.white)),
            ),
          ),

          Padding(padding: const EdgeInsets.only(top: 40),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(title!, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Text(description!, textAlign: TextAlign.center, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: CustomButton(buttonText: getTranslated('ok', context), onTap: onTap?? () => Navigator.pop(context)),
              ),
            ]),
          ),

        ]),
      ),
    );
  }
}
