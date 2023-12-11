import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/flash_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';


class FlashDealCard extends StatelessWidget {
  final Product product;
  final int index;
  final FlashDealProvider megaProvider;
  const FlashDealCard({Key? key, required this.product, required this.megaProvider, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashDealProvider>(
      builder: (context, flashDealProvider,_) {
        return InkWell(onTap: () {
            Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) => ProductDetails(productId: product.id, slug: product.slug)));
          },
          child: Container(margin: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                color: Theme.of(context).cardColor, border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125))),
            child: Stack(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

                Padding(padding: const EdgeInsets.all(6.0),
                  child: Container(height: 210,
                    decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2),width: .25),
                      color: ColorResources.getIconBg(context),
                      borderRadius: const BorderRadius.all( Radius.circular(10))),
                    child: ClipRRect(borderRadius: const BorderRadius.all( Radius.circular(10)),
                      child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}''/${product.thumbnail}',),
                    ),
                  ),
                ),


                if(product.currentStock! < product.minimumOrderQuantity! && product.productType == 'physical')
                  Center(
                    child: Text(getTranslated('out_of_stock', context)??'', style: textRegular.copyWith(color: const Color(0xFFF36A6A))),
                  ),

                Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,Dimensions.paddingSizeExtraSmall),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(product.rating!.isNotEmpty ?
                            double.parse(product.rating![0].average!).toStringAsFixed(1) : '0.0',
                            style: textRegular.copyWith(color: Provider.of<ThemeProvider>(context).darkTheme ?
                            Colors.white : Colors.orange, fontSize: Dimensions.fontSizeSmall)),
                          Icon(Icons.star, color: Provider.of<ThemeProvider>(context).darkTheme ?
                          Colors.white : Colors.orange, size: 15),
                          Text('(${product.reviewCount.toString()})',
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,)),
                        ],
                        ),
                      ),


                      Text(product.name!, style: textRegular, maxLines: 1,
                        overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                      Row( mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(product.discount! > 0 ?
                        PriceConverter.convertPrice(context, product.unitPrice) : '',
                          style: robotoBold.copyWith(
                            color: ColorResources.hintTextColor,
                            decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.fontSizeExtraSmall,
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),


                        Text(PriceConverter.convertPrice(context, product.unitPrice,
                            discountType: product.discountType,
                            discount: product.discount),
                          style: robotoBold.copyWith(color: ColorResources.getPrimary(context)),
                        ),
                      ]),


                    ],
                  ),
                ),
              ]),


              product.discount! >= 1?
              Positioned(top: 17, left: 9,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorResources.getPrimary(context),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                  ),
                  child: Text(PriceConverter.percentageCalculation(
                    context, product.unitPrice,
                    product.discount,
                    product.discountType,),
                    style: textRegular.copyWith(color: Theme.of(context).highlightColor,
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                ),
              ) : const SizedBox.shrink(),



              Positioned(top: 15, right: 15, child: FavouriteButton(
                backgroundColor: ColorResources.getImageBg(context),
                productId: product.id,
              )),


            ]),
          ),
        );
      }
    );
  }
}
