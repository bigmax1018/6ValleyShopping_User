
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:provider/provider.dart';

class RefundBottomSheet extends StatefulWidget {
  final Product? product;
  final int? orderDetailsId;
  const RefundBottomSheet({Key? key, required this.product, required this.orderDetailsId}) : super(key: key);

  @override
  RefundBottomSheetState createState() => RefundBottomSheetState();
}

class RefundBottomSheetState extends State<RefundBottomSheet> {
  final TextEditingController _refundReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getRefundReqInfo(widget.orderDetailsId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(getTranslated('refund_request', context)!, style: titilliumRegular.copyWith(fontSize: 20,
            color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
            maxLines: 1, overflow: TextOverflow.ellipsis,),
        ),

        body: SingleChildScrollView(
          child: Consumer<OrderProvider>(
              builder: (context,refundReq,_) {
                return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<OrderProvider>(
                            builder: (context, refund,_) {
                              return (refund.refundInfoModel != null && refund.refundInfoModel!.refund != null)?
                              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? null : [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],
                                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                        ),
                                        child: Column(children: [
                                          TitleWithAmountRow(
                                            title: getTranslated('total_price', context)!,
                                            amount: PriceConverter.convertPrice(context,
                                                refund.refundInfoModel!.refund!.productPrice!*refund.refundInfoModel!.refund!.quntity!),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                            child: TitleWithAmountRow(
                                                title: getTranslated('product_discount', context)!,
                                                amount: '-${PriceConverter.convertPrice(context, refund.refundInfoModel!.refund!.productTotalDiscount)}'
                                            ),
                                          ),

                                          TitleWithAmountRow(
                                            title: getTranslated('tax', context)!,
                                            amount: PriceConverter.convertPrice(context, refund.refundInfoModel!.refund!.productTotalTax),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                            child: TitleWithAmountRow(
                                              title: getTranslated('sub_total', context)!,
                                              amount: PriceConverter.convertPrice(context, refund.refundInfoModel!.refund!.subtotal),
                                            ),
                                          ),

                                          TitleWithAmountRow(
                                            title: getTranslated('coupon_discount', context)!,
                                            amount: PriceConverter.convertPrice(context, refund.refundInfoModel!.refund!.couponDiscount),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                            child: Divider(color: Theme.of(context).primaryColor.withOpacity(0.125), height: 2),
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(getTranslated('total_refund_amount', context)!,
                                                  style: robotoBold),
                                              Text(PriceConverter.convertPrice(context, refund.refundInfoModel!.refund!.refundAmount),
                                                  style: robotoBold.copyWith(color: Theme.of(context).primaryColor)),
                                            ],
                                          ),
                                        ],
                                        ),
                                      ),
                                    ]),
                              ): const SizedBox();
                            }
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Row(
                              children: [
                                Text(getTranslated('refund_reason', context)!, style: textRegular),
                                Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 30),
                              ]
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: CustomTextField(
                            maxLines: 4,
                            controller: _refundReasonController,
                            inputAction: TextInputAction.done,

                          ),
                        ),

                        Consumer<OrderProvider>(
                            builder: (context, refundProvider,_) {
                              return refundProvider.refundImage.isNotEmpty?
                              SizedBox(height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: refundProvider.refundImage.length,
                                  itemBuilder: (BuildContext context, index){
                                    return  refundProvider.refundImage.isNotEmpty?
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(width: 100, height: 100,
                                            decoration: const BoxDecoration(color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                                              child: Image.file(File(refundProvider.refundImage[index]!.path), width: 100, height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ) ,
                                          ),
                                          Positioned(
                                            top:0,right:0,
                                            child: InkWell(
                                              onTap :() => refundProvider.removeImage(index),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).hintColor,
                                                      borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Icon(Icons.clear,color: Colors.white,size: Dimensions.iconSizeExtraSmall),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ):const SizedBox();
                                  },),
                              ):const SizedBox();
                            }
                        ),


                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: InkWell(
                            onTap: () => Provider.of<OrderProvider>(context, listen: false).pickImage(false),
                            child: SizedBox(height: 30,
                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(getTranslated('upload_image', context)!),
                                    const SizedBox(width: Dimensions.paddingSizeDefault),
                                    Image.asset(Images.uploadImage),
                                  ],
                                )),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: CustomButton(
                            buttonText: getTranslated('send_request', context),
                            onTap: () {
                              String reason  = _refundReasonController.text.trim().toString();
                              if(reason.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('reason_required', context)!),
                                  backgroundColor: Colors.red,
                                ));
                              }else {
                                refundReq.refundRequest(context, widget.orderDetailsId,
                                    refundReq.refundInfoModel!.refund!.refundAmount,reason,
                                    Provider.of<AuthProvider>(context, listen: false).getUserToken()).
                                then((value) {
                                  if(value.statusCode==200){
                                    refundReq.getRefundReqInfo(widget.orderDetailsId);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(getTranslated('successfully_requested_for_refund', context)!),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.pop(context);
                                  }
                                });
                              }
                            },
                          ),
                        ),

                      ]),
                );
              }
          ),
        ),
      ),
    );
  }
}

class TitleWithAmountRow extends StatelessWidget {
  final String title;
  final String amount;
  const TitleWithAmountRow({
    super.key, required this.title, required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textRegular.copyWith(color: Theme.of(context).hintColor)),

        Text(amount, style: textRegular),
      ],
    );
  }
}


