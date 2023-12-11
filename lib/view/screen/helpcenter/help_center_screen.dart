import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_expanded_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    List<String> articleList = [
      'My app isn\'t working', 'Ordered by mistake', 'Tracking is not working',
      'Tracking is not working, Ordered by mistake Ordered by mistake',
    ];

    return CustomExpandedAppBar(title: getTranslated('help_center', context), child: ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      children: [

        // Search Field
        TextField(
          style: textRegular,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor),
            contentPadding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            prefixIcon: Icon(Icons.search, color: ColorResources.getColombiaBlue(context)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 2, color: ColorResources.getColombiaBlue(context)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 2, color: ColorResources.getColombiaBlue(context)),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),

        // Recommended
        Text(getTranslated('recommended_articles', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: articleList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(articleList[index], style: titilliumSemiBold),
              trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).hintColor, size: Dimensions.iconSizeDefault),
            );
          },
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),

        // Could not find
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Text(getTranslated('contact_with_customer_care', context)!, textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).hintColor,
          )),
        ),

        CustomButton(buttonText: getTranslated('GET_STARTED', context), onTap: () {}),

      ],
    ));
  }
}

