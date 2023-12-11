import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

const titilliumRegular = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontSize: Dimensions.fontSizeSmall,
);
const titleRegular = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,

);
const titleHeader = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontWeight: FontWeight.w600,
  fontSize: Dimensions.fontSizeLarge,

);
const titilliumSemiBold = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontSize: Dimensions.fontSizeSmall,
  fontWeight: FontWeight.w600,
);

const titilliumBold = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontSize: Dimensions.fontSizeDefault,
  fontWeight: FontWeight.w700,
);
const titilliumItalic = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontSize: Dimensions.fontSizeDefault,
  fontStyle: FontStyle.italic,
);

const textRegular = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontSize: Dimensions.fontSizeDefault,
);

const textMedium = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontSize: Dimensions.fontSizeDefault,
  fontWeight: FontWeight.w500
);
const textBold = TextStyle(
    fontFamily: 'SF-Pro-Rounded-Regular',
    fontSize: Dimensions.fontSizeDefault,
    fontWeight: FontWeight.w600
);

const robotoBold = TextStyle(
  fontFamily: 'SF-Pro-Rounded-Regular',
  fontSize: Dimensions.fontSizeDefault,
  fontWeight: FontWeight.w700,
);


class ThemeShadow {
  static List <BoxShadow> getShadow(BuildContext context) {
    List<BoxShadow> boxShadow =  [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.black26:
    Theme.of(context).primaryColor.withOpacity(.075), blurRadius: 5,spreadRadius: 1,offset: const Offset(1,1))];
    return boxShadow;
  }
}