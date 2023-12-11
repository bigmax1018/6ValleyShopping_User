import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? fontSize;
  final String? leftIcon;
  final double? borderWidth;

  const CustomButton({Key? key, this.onTap, required this.buttonText, this.isBuy= false, this.isBorder = false, this.backgroundColor, this.radius, this.textColor, this.fontSize, this.leftIcon, this.borderColor, this.borderWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: Container(height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: isBorder? Border.all(color: borderColor??Theme.of(context).primaryColor, width:  borderWidth ??1): null,
          color:  backgroundColor ?? (isBuy? const Color(0xffFE961C) : Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(radius !=null ? radius! : isBorder? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if(leftIcon != null)
            Padding(padding: const EdgeInsets.only(right: 5),
              child: SizedBox(width: 30, child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Image.asset(leftIcon!),
              )),
            ),
            Flexible(
              child: Text(buttonText??"", style: titilliumSemiBold.copyWith(fontSize: fontSize?? 16,
                    color: textColor ?? (Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white : Theme.of(context).highlightColor),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
