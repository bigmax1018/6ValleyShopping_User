import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/brand_view.dart';
import 'package:provider/provider.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.75,
        centerTitle: true,
        backgroundColor: Theme.of(context).cardColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Theme.of(context).textTheme.bodyLarge?.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(getTranslated('all_brand', context)!,
            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge?.color)),
        actions: [
          PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(enabled: false, child: Text(getTranslated('sort_by', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.hintTextColor))),
              CheckedPopupMenuItem(
                value: 0,
                checked: Provider.of<BrandProvider>(context, listen: false).isTopBrand,
                child: Text(getTranslated('top_brand', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
              ),
              CheckedPopupMenuItem(
                value: 1,
                checked: Provider.of<BrandProvider>(context, listen: false).isAZ,
                child: Text(getTranslated('alphabetically_az', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
              ),
              CheckedPopupMenuItem(
                value: 2,
                checked: Provider.of<BrandProvider>(context, listen: false).isZA,
                child: Text(getTranslated('alphabetically_za', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
              ),
            ];
          }, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            offset: const Offset(0, 45),
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Image.asset(Images.filterImage, color: ColorResources.white)),
            onSelected: (dynamic value) {
            Provider.of<BrandProvider>(context, listen: false).sortBrandLis(value);
            })]),

      body: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: BrandView(isHomePage: false)),
    );
  }
}
