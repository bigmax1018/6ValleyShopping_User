import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/top_seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/shop_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SellerCard extends StatefulWidget {
  final TopSellerModel? sellerModel;
  final bool isHomePage;
  final int index;
  final int length;
  const SellerCard({Key? key, this.sellerModel, this.isHomePage = false, required this.index, required this.length}) : super(key: key);

  @override
  State<SellerCard> createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  bool vacationIsOn = false;
  @override
  Widget build(BuildContext context) {

    if(widget.sellerModel?.shop?.vacationEndDate != null){
      DateTime vacationDate = DateTime.parse(widget.sellerModel!.shop!.vacationEndDate!);
      DateTime vacationStartDate = DateTime.parse(widget.sellerModel!.shop!.vacationStartDate!);
      final today = DateTime.now();
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if(difference >= 0 && widget.sellerModel!.shop!.vacationStatus == 1 && startDate <= 0){
        vacationIsOn = true;
      }

      else{
        vacationIsOn = false;
      }


    }


    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
          sellerId: widget.sellerModel?.id,
          temporaryClose: widget.sellerModel?.shop?.temporaryClose,
          vacationStatus: widget.sellerModel?.shop?.vacationStatus,
          vacationEndDate: widget.sellerModel?.shop?.vacationEndDate,
          vacationStartDate: widget.sellerModel?.shop?.vacationStartDate,
          name: widget.sellerModel?.shop?.name,
          banner: widget.sellerModel?.shop?.banner,
          image: widget.sellerModel?.shop?.image,)));
      },
      child : Padding(
        padding: widget.isHomePage? EdgeInsets.only(left : widget.index == 0? Dimensions.paddingSizeDefault : Provider.of<LocalizationProvider>(context, listen: false).isLtr ?
        Dimensions.paddingSizeDefault : 0, right: widget.index + 1 == widget.length?
        Dimensions.paddingSizeDefault : (Provider.of<LocalizationProvider>(context, listen: false).isLtr && widget.isHomePage) ?
            0 : Dimensions.paddingSizeDefault, bottom: widget.isHomePage?  Dimensions.paddingSizeExtraSmall: Dimensions.paddingSizeDefault):
        const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,0),
        child: Container(clipBehavior: Clip.none, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.075), spreadRadius: 1, blurRadius: 1, offset: const Offset(0,1))]),
          child: Column(children: [
              SizedBox(height: widget.isHomePage? 60 : 120,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeSmall), topRight: Radius.circular(Dimensions.paddingSizeSmall)),
                  child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl}/banner/${widget.sellerModel!.shop!.banner ?? ''}')),

              ),

              Row(children: [
                  Container(transform: Matrix4.translationValues(12, -20, 0), height: 60, width: 60,
                    child: Stack(children: [
                        Container(width: 60,height: 60,
                            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)),
                              color: Theme.of(context).highlightColor),
                            child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)),
                              child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.shopImageUrl!}/${widget.sellerModel!.shop?.image}',
                                  width: 60,height: 60))),

                        if(widget.sellerModel!.shop!.temporaryClose == 1  || vacationIsOn)
                          Container(decoration: BoxDecoration(color: Colors.black.withOpacity(.5),
                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)))),

                        widget.sellerModel!.shop!.temporaryClose ==1?
                        Center(child: Text(getTranslated('temporary_closed', context)!, textAlign: TextAlign.center,
                          style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge),)):
                        vacationIsOn?
                        Center(child: Text(getTranslated('close_for_now', context)!, textAlign: TextAlign.center,
                          style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge),)):
                        const SizedBox()
                      ],
                    ),
                  ),

                  const SizedBox(width: Dimensions.paddingSizeLarge),

                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(widget.sellerModel?.shop?.name??'', maxLines: 1,overflow: TextOverflow.ellipsis,style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
                      Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Icon(Icons.star_rate_rounded, color: Colors.yellow.shade700, size: 15,),
                          Text("${widget.sellerModel?.averageRating?.toStringAsFixed(1)} ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                          Text(" (${widget.sellerModel?.ratingCount??0})", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),
                        ],),
                      ),


                    ],),
                  )]),

            Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall, bottom:  Dimensions.paddingSizeSmall),
              child: Row( children: [
                  Expanded(child: Container(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(.125),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.min, children: [
                        Text("${widget.sellerModel?.ratingCount??0}", style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault, color:Theme.of(context).primaryColor),),
                        const SizedBox(width: 5,),
                        Text("${getTranslated('reviews', context)}", style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall),),
                      ],),
                    ),
                  ),

                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  Expanded(child: Container(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                          color: Theme.of(context).hintColor.withOpacity(.125),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(NumberFormat.compact().format(widget.sellerModel?.productCount??0),
                          style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault, color:Theme.of(context).primaryColor),),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                        Text("${getTranslated('products', context)}", style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall),),

                      ],),
                    ),
                  ),
                ],
              ),
            ),

            ],
          ),
        ),
      )
    );
  }
}
