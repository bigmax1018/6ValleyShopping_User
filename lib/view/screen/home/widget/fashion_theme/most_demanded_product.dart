import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:provider/provider.dart';

class MostDemandedProductView extends StatelessWidget {
  const MostDemandedProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, mostDemandedProduct,_) {
        return Column(children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: Container(height: 108, width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                 color: Theme.of(context).primaryColor.withOpacity(0.125),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                child: CustomImage(image: '${AppConstants.baseUrl}/storage/app/public/most-demanded/${mostDemandedProduct.mostDemandedProductModel?.banner}',),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),


            Container(height: 108, width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 1),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  RichText(
                    text: TextSpan(
                      text: '${getTranslated("most_demanded", context)} ',
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
                      children: <TextSpan>[
                        TextSpan(text: getTranslated("product_of_this_year", context), style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.lightSkyBlue)),
                      ],
                    ),
                  ),


                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      MostDemandedReviewCard(
                        count: '${mostDemandedProduct.mostDemandedProductModel?.reviewCount??0}',
                        title: getTranslated('review', context)!,
                        textColor: ColorResources.green,
                      ),

                      MostDemandedReviewCard(
                        count: '${mostDemandedProduct.mostDemandedProductModel?.orderCount??0}',
                        title: getTranslated('order', context)!,
                        textColor: ColorResources.green,
                      ),

                      MostDemandedReviewCard(
                        count: '${mostDemandedProduct.mostDemandedProductModel?.deliveryCount??0}',
                        title: getTranslated('delivery', context)!,
                        textColor: ColorResources.green,
                      ),

                      MostDemandedReviewCard(
                        count: '${mostDemandedProduct.mostDemandedProductModel?.wishlistCount??0}',
                        title: getTranslated('wishes', context)!,
                        textColor: ColorResources.green,
                      ),
                    ],
                  ),

                ],
              )
            ),
          ],
        );
      }
    );
  }
}

class MostDemandedReviewCard extends StatelessWidget {
  const MostDemandedReviewCard({
    super.key, required this.count, required this.title, required this.textColor,
  });

  final String count;
  final String title;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(width: 65, height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.1), width: 1),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        boxShadow: Provider.of<ThemeProvider>(context).darkTheme ? null : [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(count, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: textColor)),
          Text(title, style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: textColor)),
        ],
      )
    );
  }
}
