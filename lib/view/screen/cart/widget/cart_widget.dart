import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  final CartModel? cartModel;
  final int index;
  final bool fromCheckout;
  const CartWidget({Key? key, this.cartModel, required this.index, required this.fromCheckout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool inRight = Provider.of<SplashProvider>(context, listen: false).configModel!.currencySymbolPosition == 'right';

    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,0),
          child: Container(decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.15), width: .75)

            ),
            child: Slidable(

              key: const ValueKey(0),

              endActionPane: ActionPane(
                extentRatio: .25,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (value){
                      Provider.of<CartProvider>(context, listen: false).removeFromCartAPI(context,cartModel!.id, index);
                    },
                    backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.05),
                    foregroundColor: Theme.of(context).colorScheme.error,
                    icon: CupertinoIcons.delete_solid,

                    label: getTranslated('delete', context),
                  ),
                ],
              ),


              child: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:  MainAxisAlignment.start, children: [
                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 1000),
                        pageBuilder: (context, anim1, anim2) => ProductDetails(productId: cartModel!.productId, slug: cartModel!.slug,),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.10),width: 0.5)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                            child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productThumbnailUrl}/${cartModel!.thumbnail}',
                              height: 70, width: 70,)),
                    ),
                  ),
                    ),

                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, children: [
                          Row(children: [
                            Expanded(child: Text(cartModel!.name!, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                                    color: ColorResources.getReviewRattingColor(context)))),
                            const SizedBox(width: Dimensions.paddingSizeSmall)]),
                          const SizedBox(height: Dimensions.paddingSizeSmall,),



                          Row(children: [cartModel!.discount!>0?
                            Text(PriceConverter.convertPrice(context, cartModel!.price),maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: titilliumSemiBold.copyWith(color: Theme.of(context).hintColor,
                                    decoration: TextDecoration.lineThrough)):const SizedBox(),
                            const SizedBox(width: Dimensions.fontSizeSmall,),


                            Text(PriceConverter.convertPrice(context, cartModel!.price,
                                discount: cartModel!.discount,discountType: 'amount'),
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: textBold.copyWith(color: ColorResources.getPrimary(context),
                                    fontSize: Dimensions.fontSizeLarge),
                              ),
                            ],
                          ),


                          //variation
                          (cartModel!.variant != null && cartModel!.variant!.isNotEmpty) ? Padding(
                            padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                            child: Row(children: [
                              Flexible(child: Text(cartModel!.variant!,maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                    color: ColorResources.getReviewRattingColor(context),))),
                            ]),
                          ) : const SizedBox(),
                          const SizedBox(width: Dimensions.paddingSizeSmall),


                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            cartModel!.shippingType !='order_wise'?
                            Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                              child: Row(children: [
                                Text('${getTranslated('shipping_cost', context)}: ',
                                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                                        color: ColorResources.getReviewRattingColor(context))),
                                Text(PriceConverter.convertPrice(context, cartModel!.shippingCost),
                                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).disabledColor,)),
                              ]),):const SizedBox(),

                          ],),

                          cartModel!.taxModel == 'exclude'?
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                            child: Text('(${getTranslated('tax', context)} : ${PriceConverter.convertPrice(context, cartModel?.tax)})',
                              style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault),),
                          ):
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                            child: Text('(${getTranslated('tax', context)} ${cartModel!.taxModel})',
                              style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault),),
                          ),

                        ],
                      ),
                  )),

                    Container(decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.05),
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.075)),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                        topRight: Radius.circular(Dimensions.paddingSizeExtraSmall))),
                      width: 40, height: cartModel!.shippingType !='order_wise'? 130 :(cartModel!.variant != null && cartModel!.variant!.isNotEmpty)? 115 : 100,child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                          cartModel!.increment!? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(width: 20, height: 20,child: CircularProgressIndicator(color: Theme.of(context).primaryColor, strokeWidth: 2)),
                          ) :
                          QuantityButton(index: index, isIncrement: true,
                            quantity: cartModel!.quantity,
                            maxQty: cartModel!.productInfo?.totalCurrentStock,
                            cartModel: cartModel, minimumOrderQuantity: cartModel!.productInfo!.minimumOrderQty,
                            digitalProduct: cartModel!.productType == "digital"? true : false),


                          Text(cartModel!.quantity.toString(), style: textRegular),

                          cartModel!.decrement!?  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(width: 20, height: 20,child: CircularProgressIndicator(color: Theme.of(context).primaryColor, strokeWidth: 2,)),
                          ) :
                          QuantityButton(isIncrement: false, index: index,
                            quantity: cartModel!.quantity,
                            maxQty: cartModel!.productInfo!.totalCurrentStock,
                            cartModel: cartModel, minimumOrderQuantity: cartModel!.productInfo!.minimumOrderQty,
                            digitalProduct: cartModel!.productType == "digital"? true : false,

                          ),

                    ],),
                      ),)

              ]),
            ),
          ),
        );
      }
    );
  }
}

class QuantityButton extends StatelessWidget {
  final CartModel? cartModel;
  final bool isIncrement;
  final int? quantity;
  final int index;
  final int? maxQty;
  final int? minimumOrderQuantity;
  final bool? digitalProduct;
  const QuantityButton({Key? key, required this.isIncrement, required this.quantity, required this.index,
    required this.maxQty,required this.cartModel, this.minimumOrderQuantity, this.digitalProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvide,_) {
        return InkWell(
          onTap: () {
            if (!isIncrement && quantity! > minimumOrderQuantity!) {
                Provider.of<CartProvider>(context, listen: false).updateCartProductQuantity(cartModel!.id, cartModel!.quantity!-1, context, false, index).then((value) {
                  showCustomSnackBar(value.message, context,isError: !value.isSuccess);
                });
            } else if ((isIncrement && quantity! < maxQty!) || (isIncrement && digitalProduct!)) {
              Provider.of<CartProvider>(context, listen: false).updateCartProductQuantity(cartModel!.id, cartModel!.quantity!+1, context, true, index).then((value) {
                showCustomSnackBar(value.message, context, isError: !value.isSuccess);
              });
            }else if(isIncrement && quantity! == maxQty!){
              showCustomSnackBar(getTranslated('out_of_stock', context), context);
            }else{
              Provider.of<CartProvider>(context, listen: false).removeFromCartAPI(context,cartModel!.id, index);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(isIncrement ? CupertinoIcons.add : quantity! == minimumOrderQuantity!? CupertinoIcons.delete_solid : CupertinoIcons.minus,
              color: Colors.red, size:  15),
          ),
        );
      }
    );
  }
}

