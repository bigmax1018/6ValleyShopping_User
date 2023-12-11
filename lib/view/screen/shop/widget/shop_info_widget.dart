import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:provider/provider.dart';

class ShopInfoWidget extends StatelessWidget {
  final bool vacationIsOn;
  final int temporaryClose;
  final String sellerName;
  final int sellerId;
  final String banner;
  final String shopImage;
  const ShopInfoWidget({Key? key, required this.vacationIsOn, required this.sellerName, required this.sellerId, required this.banner, required this.shopImage, required this.temporaryClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl}/banner/$banner',
      placeholder: Images.placeholder_3x1,width: MediaQuery.of(context).size.width, height: 120,),


        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Container(transform: Matrix4.translationValues(0, -20, 0),
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
                boxShadow: Provider.of<ThemeProvider>(context,listen: false).darkTheme? null:[BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(children: [
                Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                    boxShadow: Provider.of<ThemeProvider>(context,listen: false).darkTheme? null: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
                  child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, height: 80, width: 80, fit: BoxFit.cover,
                      image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl}/$shopImage',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 80, width: 80, fit: BoxFit.cover),
                    ),
                  ),
                ),
                if(temporaryClose == 1  || vacationIsOn)
                  Container(width: 80,height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),)),

                temporaryClose ==1?
                Positioned(top: 0,bottom: 0,left: 0,right: 0,
                  child: Align(alignment: Alignment.center,
                      child: Center(child: Text(getTranslated('temporary_closed', context)!, textAlign: TextAlign.center,
                          style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)))),
                ):

                vacationIsOn?
                Positioned(top: 0,bottom: 0,left: 0,right: 0,
                  child: Align(alignment: Alignment.center,
                      child: Center(child: Text(getTranslated('close_for_now', context)!, textAlign: TextAlign.center,
                          style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)))),
                ):
                const SizedBox()
              ]),

              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Consumer<SellerProvider>(
                    builder: (context, sellerProvider,_) {
                      String ratting = sellerProvider.sellerModel != null && sellerProvider.sellerModel!.avgRating != null?
                      sellerProvider.sellerModel!.avgRating.toString() : "0";

                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Expanded(child: Text(sellerName,
                            style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                            maxLines: 2, overflow: TextOverflow.ellipsis,),),

                          InkWell(onTap: () {
                            if(!Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                              showAnimatedDialog(context, const GuestDialog(), isFlip: true);
                            }else  {
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                  ChatScreen(id: sellerId, name: sellerName)));
                            }
                          },
                            child : Image.asset(Images.chatImage, height: Dimensions.iconSizeDefault),
                          ),
                        ],
                        ),


                        sellerProvider.sellerModel != null?
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                              child: Row(children: [
                                const Icon(Icons.star_rate_rounded, color: Colors.orange),
                                Text(double.parse(ratting).toStringAsFixed(1), style: textRegular),

                                if(sellerProvider.sellerModel!.minimumOrderAmount != null && sellerProvider.sellerModel!.minimumOrderAmount! > 0)
                                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                  child: Text('|', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),),

                                if(sellerProvider.sellerModel!.minimumOrderAmount != null && sellerProvider.sellerModel!.minimumOrderAmount! > 0)
                                Text('${sellerProvider.sellerModel!.totalReview} ${getTranslated('reviews', context)}',
                                  style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).primaryColor),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,),
                              ])),
                          const SizedBox(height: Dimensions.paddingSizeSmall),


                          Row(children: [

                            (sellerProvider.sellerModel!.minimumOrderAmount != null && sellerProvider.sellerModel!.minimumOrderAmount! > 0)?

                            Text('${PriceConverter.convertPrice(context, sellerProvider.sellerModel!.minimumOrderAmount)} ${getTranslated('minimum_order', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,):
                            Text('${sellerProvider.sellerModel!.totalReview} ${getTranslated('reviews', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,),



                            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Text('|', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),),

                            Text('${sellerProvider.sellerModel!.totalProduct} ${getTranslated('products', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,),

                          ],
                          ),
                        ]):const SizedBox(),
                      ],
                      );
                    }
                ),
              ),

            ]),
          ),
        ),
      ],
    );
  }
}
