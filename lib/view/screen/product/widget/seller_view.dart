import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_logged_in_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/shop_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SellerView extends StatelessWidget {
  final String sellerId;
  const SellerView({Key? key, required this.sellerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sellerIconSize = 50;
    Provider.of<SellerProvider>(context, listen: false).initSeller(sellerId, context);

    return Consumer<SellerProvider>(
      builder: (context, seller, child) {
        return seller.sellerModel != null ?
        Container(margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, 0),
          color: Theme.of(context).cardColor,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: sellerIconSize,height: sellerIconSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sellerIconSize),
                      border: Border.all(width: .5,color: Theme.of(context).hintColor)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(sellerIconSize),
                      child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.shopImageUrl}/${seller.sellerModel!.seller!.shop!.image}'))),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),


                  Expanded(
                    child: Column(children: [
                      Row(children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
                              sellerId: seller.sellerModel?.seller?.id,
                              temporaryClose: seller.sellerModel?.seller?.shop?.temporaryClose,
                              vacationStatus: seller.sellerModel?.seller?.shop?.vacationStatus,
                              vacationEndDate: seller.sellerModel?.seller?.shop?.vacationEndDate,
                              vacationStartDate: seller.sellerModel?.seller?.shop?.vacationStartDate,
                              name: seller.sellerModel?.seller?.shop?.name,
                              banner: seller.sellerModel?.seller?.shop?.banner,
                              image: seller.sellerModel?.seller?.shop?.image))),
                            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(seller.sellerModel != null ? seller.sellerModel!.seller!.shop!.name ?? ''  : '',
                                  style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),

                                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                  child: Row(children: [
                                      RatingBar(rating: seller.sellerModel != null ? double.parse(seller.sellerModel!.avgRating!.toString()) : 0),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Text(seller.sellerModel != null ?
                                    '(${seller.sellerModel!.totalReview})'  : '',
                                      style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).hintColor),
                                    ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),


                        InkWell(onTap: () {
                            if(!Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                              showModalBottomSheet(context: context, builder: (_) => const NotLoggedInBottomSheet());
                            }else if(seller.sellerModel != null) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(
                                  id: seller.sellerModel!.seller!.id,
                                  name: seller.sellerModel!.seller!.shop!.name,
                              )));
                            }
                          },
                          child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                          ),
                              child: Image.asset(Images.chatImage, height: Dimensions.iconSizeDefault))),
                      ]),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall,),



                    ]),
                  ),
                ],
              ),

            seller.sellerModel != null?
            Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(children: [
                  Text(seller.sellerModel!.totalReview.toString(),
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),

                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  Text(getTranslated('reviews', context)!,
                    style: titleRegular.copyWith(color: Theme.of(context).hintColor),),
                ],),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Container(width: 1, height: 10, color: ColorResources.visitShop(context),),
                ),


                Row(children: [
                  Text(NumberFormat.compact().format(seller.sellerModel!.totalProduct),
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),

                  Text(getTranslated('products', context)!,
                    style: titleRegular.copyWith(color: Theme.of(context).hintColor),),

                ],),
              ]),
            ):const SizedBox(),

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal:  Dimensions.paddingSizeLarge),
              child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
                  sellerId: seller.sellerModel?.seller?.id,
                  temporaryClose: seller.sellerModel?.seller?.shop?.temporaryClose,
                  vacationStatus: seller.sellerModel?.seller?.shop?.vacationStatus,
                  vacationEndDate: seller.sellerModel?.seller?.shop?.vacationEndDate,
                  vacationStartDate: seller.sellerModel?.seller?.shop?.vacationStartDate,
                  name: seller.sellerModel?.seller?.shop?.name,
                  banner: seller.sellerModel?.seller?.shop?.banner,
                  image: seller.sellerModel?.seller?.shop?.image))),
                child: Container(width: MediaQuery.of(context).size.width, height: 40,
                  decoration: BoxDecoration(color: ColorResources.visitShop(context),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                  child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        child: SizedBox(width: 20, child: Image.asset(Images.storeIcon, color: Theme.of(context).primaryColor))),
                      Text(getTranslated('visit_store', context)!,
                        style: titleRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor),),
                    ],
                  )),
                ),
              ),
            )
            ],
          ),
        ):const SizedBox();
      },
    );
  }
}
