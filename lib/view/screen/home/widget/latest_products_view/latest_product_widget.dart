import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';

class LatestProductWidget extends StatelessWidget {
  final Product productModel;
  const LatestProductWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ratting = productModel.rating != null && productModel.rating!.isNotEmpty? productModel.rating![0].average! : "0";

    return InkWell(onTap: () {
      Navigator.push(context, PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (context, anim1, anim2) => ProductDetails(productId: productModel.id,slug: productModel.slug),
      ));},
      child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Container(clipBehavior: Clip.none,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25), spreadRadius: 1, blurRadius: 1, offset: const Offset(0,1))],),
          child: Stack(fit: StackFit.expand, children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: Container(decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeSmall), topRight: Radius.circular(10)),),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeSmall), topRight: Radius.circular(10)),
                  child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${productModel.thumbnail}')
                ),
              ),
            ),

            // Off

            Positioned(bottom: 0, left: 0, right: 0,
              child: Container(margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Theme.of(context).hintColor.withOpacity(.125)),
                  boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme? null :[BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],),
                child: Padding(
                  padding: const EdgeInsets.only(top :Dimensions.paddingSizeSmall,bottom: 5, left: 5,right: 5),
                  child: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center, children: [

                      if(productModel.currentStock! < productModel.minimumOrderQuantity! && productModel.productType == 'physical')
                        Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                            child: Text(getTranslated('out_of_stock', context)??'', style: textRegular.copyWith(color: const Color(0xFFF36A6A)))),


                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        RatingBar(rating: double.parse(ratting), size: 18),


                        Text('(${productModel.reviewCount.toString()})', style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall)),
                      ]),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                      Text(productModel.name ?? '', textAlign: TextAlign.center,
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, fontWeight: FontWeight.w400), maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        productModel.discount!= null && productModel.discount! > 0 ?
                        Text(PriceConverter.convertPrice(context, productModel.unitPrice),
                          style: titleRegular.copyWith(color: ColorResources.hintTextColor,
                            decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.fontSizeExtraSmall)) : const SizedBox.shrink(),
                        const SizedBox(width: 2,),


                        Text(PriceConverter.convertPrice(context, productModel.unitPrice, discountType: productModel.discountType,
                            discount: productModel.discount),
                          style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            productModel.discount! > 0 ?
            Positioned(top: 12, left: 0, child: Container(
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                color: ColorResources.getPrimary(context),
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
              ),


              child: Center(
                child: Text(PriceConverter.percentageCalculation(context, productModel.unitPrice,
                    productModel.discount, productModel.discountType),
                  style: textRegular.copyWith(color: Theme.of(context).highlightColor,
                      fontSize: Dimensions.fontSizeSmall))),
            )) : const SizedBox.shrink(),


            Positioned(top: 10, right: 10, child: FavouriteButton(
              backgroundColor: ColorResources.getImageBg(context),
              productId: productModel.id,
            )),

          ]),
        ),
      ),
    );
  }
}
