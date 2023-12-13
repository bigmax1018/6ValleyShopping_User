import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/category.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/category_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/sub_category_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import '../shimmer/category_shimmer.dart';

class SubCategoryView extends StatelessWidget {
  final bool isHomePage;
  final List<SubCategory?>? sub_category;
  const SubCategoryView({Key? key, required this.isHomePage, required this.sub_category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return
        SizedBox( height: 120,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: sub_category!.length+1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if(index == 0){
                // return InkWell(
                //   onTap: () {
                //     print("all product");
                //   },
                //   child: Padding(padding: EdgeInsets.only(left : Provider.of<LocalizationProvider>(context, listen: false).isLtr ? Dimensions.homePagePadding : 0,
                //       right: Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 0 : Dimensions.homePagePadding),
                //     child: Column( children: [
                //       Container(height: 70, width: 70,
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125),width: .25),
                //           borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                //           color: Theme.of(context).primaryColor.withOpacity(.125),
                //         ),
                //         child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                //             child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}'
                //                 '',)
                //
                //         ),
                //       ),
                //
                //       const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                //       Center(child: SizedBox(width: 70,
                //         child: Text(getTranslated('all_products', context)!, textAlign: TextAlign.center, maxLines: 2,
                //             overflow: TextOverflow.ellipsis,
                //             style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                //                 color: ColorResources.getTextTitle(context))),
                //         ),
                //       ),
                //
                //     ]),
                //   ),
                // );
                return InkWell(
                  onTap: () {
                    print("all product");
                    Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index);
                  },
                  child: SubCategoryItem(
                    title: getTranslated('all_products', context)!,
                    icon: '',
                    isSelected: categoryProvider.categorySelectedIndex == index,
                  ),
                );
              } else if(index != 0) {
                // return InkWell(
                //   onTap: () {
                //     print(sub_category![index-1]!.name);
                //   },
                //   child: SubCategoryWidget(sub_category: sub_category![index-1]!,
                //       index: index-1,
                //       length: sub_category!.length),
                // );
                return InkWell(
                  onTap: () {
                    Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index);
                    print(sub_category![index-1]!.name);
                  },
                  child: SubCategoryItem(
                    title: sub_category![index-1]!.name,
                    icon: sub_category![index-1]!.icon,
                    isSelected: categoryProvider.categorySelectedIndex == index,
                  ),
                );
              }
            },
          ),
        );

      },
    );
  }
}

class SubCategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  const SubCategoryItem({Key? key, required this.title, required this.icon, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? ColorResources.getPrimary(context) : null,
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder, fit: BoxFit.cover,
                image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}/$icon',
                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
            child: Text(title!, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(
              fontSize: Dimensions.fontSizeExtraSmall,
              color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
            )),
          ),
        ]),
      ),
    );
  }
}


