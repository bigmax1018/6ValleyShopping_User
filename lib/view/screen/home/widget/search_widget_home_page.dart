import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class SearchWidgetHomePage extends StatelessWidget {
  const SearchWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraExtraSmall),
      child: Container(padding:  const EdgeInsets.symmetric(
          horizontal: Dimensions.homePagePadding, vertical: Dimensions.paddingSizeSmall),

        alignment: Alignment.center,
        child: Container(padding: const EdgeInsets.only(
          left: Dimensions.homePagePadding, right: Dimensions.paddingSizeExtraSmall),
          height: 60, alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: Theme.of(context).cardColor,
            boxShadow: Provider.of<ThemeProvider>(context).darkTheme ? null : [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.1), spreadRadius: 1, blurRadius: 1, offset: const Offset(0,0))],
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
          child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [

            Text(getTranslated('search_hint', context)??'',
                style: textRegular.copyWith(color: Theme.of(context).hintColor)),

            Container(width: 40,height: 40,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall))),
              child: Icon(Icons.search, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?
              Colors.white : Theme.of(context).cardColor, size: Dimensions.iconSizeSmall),
            ),
          ]),
        ),
      ),
    );
  }
}
