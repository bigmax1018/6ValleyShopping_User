import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_details.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/otp_verification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/refunded_status_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/review_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/refund_request_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsWidget extends StatefulWidget {
  final OrderDetailsModel orderDetailsModel;
  final String orderType;
  final String paymentStatus;
  final Function callback;
  final bool fromTrack;
  final int? isGuest;
  const OrderDetailsWidget({Key? key, required this.orderDetailsModel, required this.callback, required this.orderType, required this.paymentStatus,  this.fromTrack = false, this.isGuest}) : super(key: key);

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Stack(children: [

          Card(color: Theme.of(context).cardColor,
            child: Column(children: [
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(width: Dimensions.marginSizeDefault),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      child: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125))
                      ),
                        child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                        baseUrls!.productThumbnailUrl}/${widget.orderDetailsModel.productDetails?.thumbnail}', width: 80, height: 80)
                      ),
                    ),
                    const SizedBox(width: Dimensions.marginSizeDefault),



                    Expanded(flex: 3,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Expanded(child: Text(widget.orderDetailsModel.productDetails?.name??'',
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                              maxLines: 2, overflow: TextOverflow.ellipsis))]),
                          const SizedBox(height: Dimensions.marginSizeExtraSmall),


                        Row(children: [

                          Text("${getTranslated('price', context)}: ",
                            style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                          Text(PriceConverter.convertPrice(context, widget.orderDetailsModel.price),
                            style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),

                          widget.orderDetailsModel.productDetails!.taxModel == 'exclude'?
                          Text('(${getTranslated('tax', context)} ${widget.orderDetailsModel.tax})',
                            style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault),):
                          Text('(${getTranslated('tax', context)} ${widget.orderDetailsModel.productDetails!.taxModel})',
                            style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault),),

                        ]),
                        const SizedBox(height: Dimensions.marginSizeExtraSmall),

                        Text('${getTranslated('qty', context)}: ${widget.orderDetailsModel.qty}',
                            style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14)),
                        const SizedBox(height: Dimensions.marginSizeExtraSmall),





                        (widget.orderDetailsModel.variant != null && widget.orderDetailsModel.variant!.isNotEmpty) ?
                        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                          child: Row(children: [
                            Text('${getTranslated('variations', context)}: ',
                                style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall)),


                              Flexible(child: Text(widget.orderDetailsModel.variant!,
                                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).disabledColor,))),
                            ]),
                          ) : const SizedBox(),
                          const SizedBox(height: Dimensions.marginSizeExtraSmall),

                          ///Downloadable Product////////////

                          Row(
                            children: [
                              const Spacer(),
                              SizedBox(height: (widget.orderDetailsModel.productDetails != null && widget.orderDetailsModel.productDetails?.productType =='digital' && widget.paymentStatus == 'paid')?
                              Dimensions.paddingSizeExtraLarge : 0),
                              widget.orderDetailsModel.productDetails?.productType =='digital' && widget.paymentStatus == 'paid'?
                              Consumer<OrderProvider>(
                                  builder: (context, orderProvider, _) {
                                    return InkWell(
                                      onTap : () async {
                                        if(widget.orderDetailsModel.productDetails!.digitalProductType == 'ready_after_sell' &&
                                            widget.orderDetailsModel.digitalFileAfterSell == null ){

                                        showCustomSnackBar(getTranslated('product_not_uploaded_yet', context), context, isToaster: true);
                                        }else{

                                         if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn() && widget.isGuest == 0){

                                           _launchUrl(Uri.parse(widget.orderDetailsModel.productDetails!.digitalProductType == 'ready_after_sell'?
                                           '${Provider.of<SplashProvider>(Get.context!, listen: false).
                                           baseUrls!.digitalProductUrl}/${widget.orderDetailsModel.digitalFileAfterSell}':
                                           '${Provider.of<SplashProvider>(Get.context!, listen: false).
                                           baseUrls!.digitalProductUrl}/${widget.orderDetailsModel.productDetails!.digitalFileReady}'));

                                         }else{
                                           orderProvider.downloadDigitalProduct(orderDetailsId: widget.orderDetailsModel.id!).then((value){
                                             if(value.response?.statusCode == 200){
                                               Navigator.push(context, MaterialPageRoute(builder: (_)=>  VerificationScreen('', '', '', orderId: widget.orderDetailsModel.id, fromDigitalProduct: true,)));
                                             }
                                           });
                                         }

                                        }

                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(width: 100,
                                          padding: const EdgeInsets.only(left: 5),
                                          height: 38,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),

                                              color: Theme.of(context).primaryColor
                                          ),
                                          alignment: Alignment.center,
                                          child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('${getTranslated('download', context)}',
                                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).cardColor),),
                                              const SizedBox(width: Dimensions.paddingSizeSmall),
                                              SizedBox(width: Dimensions.iconSizeDefault,
                                                  child: Image.asset(Images.fileDownload, color: Theme.of(context).cardColor,))
                                            ],
                                          )),
                                        ),
                                      ),
                                    );
                                  }
                              ) : const SizedBox(),

                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),


                          ///Review and Refund Request///////////////////
                          Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                            child: Row(children: [
                              const Spacer(),
                              Provider.of<OrderProvider>(context).orderTypeIndex == 1 && widget.orderType != "POS"?
                              InkWell(
                                onTap: () {
                                  if(Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 1) {
                                    Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
                                    showDialog(
                                      context: context, builder: (context) => Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      child: ReviewDialog(
                                        productID: widget.orderDetailsModel.productDetails!.id.toString(),
                                        callback: widget.callback,
                                        orderDetailsModel: widget.orderDetailsModel,
                                        orderType: widget.orderType,
                                      ),
                                    ),);
                                  }
                                },
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color:  Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                  ),
                                  child: Row(children: [
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                      const Icon(Icons.star_outline_outlined, color: Colors.white, size: 20,),
                                      const SizedBox(width: Dimensions.paddingSizeSmall),
                                      Text(getTranslated('review', context)!, style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: ColorResources.white,
                                      )),
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    ],
                                  ),
                                ),
                              ) : const SizedBox.shrink(),


                              Consumer<OrderProvider>(builder: (context,refund,_){
                                return refund.orderTypeIndex == 1 && widget.orderDetailsModel.refundReq == 0 && widget.orderType != "POS"?
                                InkWell(onTap: () {
                                    Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
                                    refund.getRefundReqInfo(widget.orderDetailsModel.id).then((value) {
                                      if(value.response!.statusCode==200){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                            RefundBottomSheet(product: widget.orderDetailsModel.productDetails,
                                                orderDetailsId: widget.orderDetailsModel.id)));
                                      }
                                    });},

                                  child: refund.isRefund ?
                                  Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
                                  Container(height: 30,
                                    margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,
                                        horizontal: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(color: ColorResources.getPrimary(context),
                                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),

                                    child: Text(getTranslated('refund_request', context)!,
                                        style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                                          color: Theme.of(context).highlightColor,)),),
                                ) :const SizedBox();
                              }),


                              Consumer<OrderProvider>(builder: (context,refund,_){
                                return (Provider.of<OrderProvider>(context).orderTypeIndex == 1 &&
                                    widget.orderDetailsModel.refundReq != 0 && widget.orderType != "POS")?

                                InkWell(onTap: () {
                                    Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
                                    refund.getRefundReqInfo(widget.orderDetailsModel.id).then((value) {
                                      if(value.response!.statusCode==200){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => RefundResultBottomSheet(product: widget.orderDetailsModel.productDetails,
                                            orderDetailsId: widget.orderDetailsModel.id,
                                            orderDetailsModel:  widget.orderDetailsModel)));}});},



                                  child: refund.isLoading?
                                  Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):

                                    Container(height: 30,
                                      margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,
                                          horizontal: Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(color: ColorResources.getPrimary(context),
                                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),

                                      child: Text(getTranslated('refund_status_btn', context)!,
                                          style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                                            color: Theme.of(context).highlightColor,)),)
                                ) :const SizedBox();
                              }),

                              const SizedBox(width: 10),
                            ],),
                          ),

                          widget.orderDetailsModel.refundReq == 0 && widget.orderType != "POS"?
                          const SizedBox(height: Dimensions.paddingSizeLarge):const SizedBox(),


                        ],
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

          Positioned(
            top: 35,  left: 20,
            child: widget.orderDetailsModel.discount! > 0?
            Container(height: 20,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(Dimensions.paddingSizeExtraSmall)),
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
      ),
    );
  }
}


Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}