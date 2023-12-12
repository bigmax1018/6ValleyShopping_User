import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/category.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/category_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/sub_category_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
class BrandAndCategoryProductScreen extends StatelessWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;
  final int? index;
  const BrandAndCategoryProductScreen({Key? key, required this.isBrand, required this.id, required this.name, this.image,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).initBrandOrCategoryProductList(isBrand, id, context);
    CategoryProvider categoryProvider = Provider.of(context, listen: false);
    List<SubCategory?>? subCategory;
    subCategory = categoryProvider.categoryList[index!].subCategories;
    return Scaffold(
      appBar: CustomAppBar(title: name),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

            isBrand ? Container(height: 100,
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              color: Theme.of(context).highlightColor,
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.brandImageUrl}/$image', width: 80, height: 80, fit: BoxFit.cover,),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                Text(name!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              ]),
            ) : const SizedBox.shrink(),
            // Expanded(
            //   child: Container(
            //       height: 50,
            //       child: ListView.builder(
            //         padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            //         // scrollDirection: Axis.horizontal,
            //         itemCount: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].subCategories!.length+1,
            //         itemBuilder: (context, index) {
            //           late SubCategory subCategory;
            //           if(index != 0) {
            //             subCategory = categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].subCategories![index-1];
            //           }
            //           if(index == 0) {
            //             return Ink(
            //               // color: Theme.of(context).highlightColor,
            //               child: ListTile(
            //                 title: Text(getTranslated('all_products', context)!, style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
            //                 trailing: const Icon(Icons.navigate_next),
            //                 onTap: () {
            //                   Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
            //                     isBrand: false,
            //                     id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].id.toString(),
            //                     name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].name,
            //                     index: index,
            //                   )));
            //                 },
            //               ),
            //             );
            //           } else {
            //             return Ink(
            //               color: Theme.of(context).highlightColor,
            //               child: ListTile(
            //                 title: Text(subCategory.name!, style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
            //                 trailing: Icon(Icons.navigate_next, color: Theme.of(context).textTheme.bodyLarge!.color),
            //                 onTap: () {
            //                   Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
            //                     isBrand: false,
            //                     id: subCategory.id.toString(),
            //                     name: subCategory.name,
            //                     index: index,
            //                   )));
            //                 },
            //               ),
            //             );
            //           }
            //         },
            //       )),
            // ),
            // const CategoryView(isHomePage: false),
            SubCategoryView(isHomePage: false, sub_category: subCategory!),

            const SizedBox(height: Dimensions.paddingSizeSmall),

            // Products
            productProvider.brandOrCategoryProductList.isNotEmpty ?
            Expanded(
              child: MasonryGridView.count(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                itemCount: productProvider.brandOrCategoryProductList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(productModel: productProvider.brandOrCategoryProductList[index]);
                },
              ),
            ) :

            Expanded(child: productProvider.hasData! ?

            ProductShimmer(isHomePage: false,
                isEnabled: Provider.of<ProductProvider>(context).brandOrCategoryProductList.isEmpty)
                : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct,
              message: 'no_product_found',)),

          ]);
        },
      ),
    );
  }
}