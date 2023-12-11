import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/review_body.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_details.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:provider/provider.dart';

class ReviewDialog extends StatefulWidget {
  final String productID;
  final Function? callback;
  final OrderDetailsModel orderDetailsModel;
  final String orderType;
  const ReviewDialog({super.key, required this.productID, required this.callback, required this.orderDetailsModel, required this.orderType});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {

  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column( mainAxisSize: MainAxisSize.min, children: [
                Align(alignment: Alignment.topRight,
                  child: InkWell(onTap: () => Navigator.pop(context),
                    child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor.withOpacity(0.5)),
                      padding: const EdgeInsets.all(3), child: const Icon(Icons.clear)))),
                const SizedBox(height: Dimensions.paddingSizeSmall),


                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).cardColor),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(Dimensions.homePagePadding),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      OrderDetails(orderDetailsModel: widget.orderDetailsModel,
                        orderType: widget.orderType,),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Center(child: Text(getTranslated('rate_the_quality', context)!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),

                      Center(
                        child: SizedBox(height: 45,
                          child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Icon(Provider.of<ProductDetailsProvider>(context).rating < (index+1) ? Icons.star_outline_rounded : Icons.star_rate_rounded, size: 30,
                                  color: Provider.of<ProductDetailsProvider>(context).rating < (index+1) ?
                                  Theme.of(context).primaryColor.withOpacity(0.125) : Theme.of(context).primaryColor,
                                ),
                                onTap: () => Provider.of<ProductDetailsProvider>(context, listen: false).setRating(index+1),
                              );
                            },
                          ),
                        ),
                      ),


                      Align(alignment: Alignment.centerLeft,
                        child: Text(getTranslated('have_thoughts_to_share', context)!,
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      CustomTextField(
                        maxLines: 4,
                        hintText: getTranslated('write_your_experience_here', context),
                        controller: _controller,
                        inputAction: TextInputAction.done,
                      ),

                    Padding(padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
                      child: SizedBox(height: 75,
                        child: ListView.builder(
                            shrinkWrap: true,

                            scrollDirection: Axis.horizontal,
                            itemCount : orderProvider.reviewImages.length + 1 ,
                            itemBuilder: (BuildContext context, index){
                              return index ==  orderProvider.reviewImages.length ?
                              Padding(padding: const EdgeInsets.only(right : Dimensions.paddingSizeDefault),
                                child: InkWell(onTap: ()=> orderProvider.pickImage(false, fromReview: true),
                                  child: DottedBorder(
                                    strokeWidth: 2,
                                    dashPattern: const [10,5],
                                    color: Theme.of(context).hintColor,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(Dimensions.paddingSizeSmall),
                                    child: Stack(children: [
                                      ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                        child:  SizedBox(height: 75,
                                          width: 75, child: Image.asset(Images.placeholder, fit: BoxFit.cover,),
                                        ),
                                      ),
                                      Positioned(bottom: 0, right: 0, top: 0, left: 0,
                                        child: Container(decoration: BoxDecoration(
                                            color: Theme.of(context).hintColor.withOpacity(0.07),
                                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall))),
                                      ),
                                    ],
                                    ),
                                  ),
                                ),
                              ) :
                              Stack(children: [
                                Padding(padding: const EdgeInsets.only(right : Dimensions.paddingSizeSmall),
                                  child: Container(decoration: const BoxDecoration(color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),),
                                    child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
                                      child:  Image.file(File(orderProvider.reviewImages[index].path),
                                        width: 75, height: 75, fit: BoxFit.cover))),
                                ),
                                Positioned(top:0,right:0,
                                  child: InkWell(onTap :() => orderProvider.removeImage(index,fromReview: true),
                                    child: Container(decoration: const BoxDecoration(color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))),
                                        child: Padding(padding: const EdgeInsets.all(4.0),
                                          child: Icon(Icons.cancel,color: Theme.of(context).hintColor, size: 15,),)),
                                  ),
                                ),
                              ],
                              );

                            } ),
                      ),
                    ),

                      Provider.of<ProductDetailsProvider>(context).errorText != null ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Provider.of<ProductDetailsProvider>(context).errorText!,
                            style: textRegular.copyWith(color: ColorResources.red)),
                      ) :
                      const SizedBox.shrink(),

                      Builder(
                        builder: (context) => !Provider.of<ProductDetailsProvider>(context).isLoading ?
                        CustomButton(
                          buttonText: getTranslated('submit', context),
                          onTap: () {
                            if(Provider.of<ProductDetailsProvider>(context, listen: false).rating == 0) {
                              Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('${getTranslated('add_a_rating', context)}');
                            }else if(_controller.text.isEmpty) {
                              Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('${getTranslated('write_a_review', context)}');
                            }else {
                              Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('');
                              ReviewBody reviewBody = ReviewBody(
                                productId: widget.productID,
                                rating: Provider.of<ProductDetailsProvider>(context, listen: false).rating.toString(),
                                comment: _controller.text.isEmpty ? '' : _controller.text);
                              Provider.of<ProductDetailsProvider>(context, listen: false).submitReview(reviewBody,
                                  orderProvider.reviewImages, Provider.of<AuthProvider>(context, listen: false).getUserToken()).then((value) {
                                if(value.isSuccess) {
                                  Navigator.pop(context);
                                  widget.callback!();
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  _controller.clear();
                                }else {
                                  Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText(value.message);
                                }
                              });
                            }
                          },
                        ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}



///Order Details Widget

class OrderDetails extends StatefulWidget {
  final OrderDetailsModel orderDetailsModel;

  final String orderType;
  const OrderDetails({super.key, required this.orderDetailsModel, required this.orderType});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).cardColor,
            boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? null : [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],

          ),

          child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.125),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(.125)),),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder, fit: BoxFit.scaleDown, width: 70, height: 70,
                    image: '${Provider.of<SplashProvider>(context, listen: false).
                    baseUrls!.productThumbnailUrl}/${widget.orderDetailsModel.productDetails?.thumbnail}',
                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                        fit: BoxFit.scaleDown, width: 70, height: 70),),
                ),
              ),
              const SizedBox(width: Dimensions.marginSizeDefault),



              Expanded(flex: 3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: Text(widget.orderDetailsModel.productDetails?.name??'',
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor),
                        maxLines: 2, overflow: TextOverflow.ellipsis,),),

                    ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),


                    Row(children: [

                      Text("${getTranslated('price', context)}: ",
                        style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),

                      Text(PriceConverter.convertPrice(context, widget.orderDetailsModel.price),maxLines: 1,
                          style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),

                      Expanded(child: Text('(${getTranslated('tax', context)} ${widget.orderDetailsModel.productDetails!.taxModel} ${widget.orderDetailsModel.tax})',
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                      ),
                    ],),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),

                    Text('${getTranslated('qty', context)}: ${widget.orderDetailsModel.qty}',
                        style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14)),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),





                    (widget.orderDetailsModel.variant != null && widget.orderDetailsModel.variant!.isNotEmpty) ?
                    Padding(padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                        Text('${getTranslated('variations', context)}: ',
                            style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall)),


                        Flexible(child: Text(widget.orderDetailsModel.variant!,
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor,)))]),
                    ) : const SizedBox(),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),

                  ],
                ),
              ),

            ],
          ),
        ),

        Positioned(
          top: 10,  left: 0,
          child: widget.orderDetailsModel.discount! > 0?
          Container(height: 20,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                  bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall)
              ),
            ),


            child: Text(PriceConverter.percentageCalculation(context,
                (widget.orderDetailsModel.price! * widget.orderDetailsModel.qty!),
                widget.orderDetailsModel.discount, 'amount'),
              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                  color: ColorResources.white),
            ),
          ):const SizedBox(),
        ),
      ],
    );
  }
}
