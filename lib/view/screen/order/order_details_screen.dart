import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/image_diaglog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/order_details_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/cal_chat_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/cancel_and_support_center.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/order_details_top_portion_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/ordered_product_list.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/payment_info.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/seller_section.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/shipping_and_billing_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/shipping_info.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/amount_widget.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final bool isNotification;
  final int? orderId;
  final String? phone;
  final bool fromTrack;
  const OrderDetailsScreen({Key? key, required this.orderId, this.isNotification = false, this.phone,  this.fromTrack = false}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {


  void _loadData(BuildContext context) async {
    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn() && !widget.fromTrack){
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderDetails(widget.orderId.toString());
      await Provider.of<OrderProvider>(Get.context!, listen: false).initTrackingInfo(widget.orderId.toString());
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderFromOrderId(widget.orderId.toString());
    }else{
      await Provider.of<OrderProvider>(Get.context!, listen: false).trackYourOrder(orderId: widget.orderId.toString(), phoneNumber: widget.phone);
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderFromOrderId(widget.orderId.toString());

    }

  }

  @override
  void initState() {
    super.initState();
    if(Provider.of<SplashProvider>(context, listen: false).configModel == null ){
      Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((value){
        _loadData(context);
        Provider.of<OrderProvider>(context, listen: false).digitalOnly(true);
      });
    }else{
      _loadData(context);
      Provider.of<OrderProvider>(context, listen: false).digitalOnly(true);
    }

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
       if(Navigator.of(context).canPop()){
         Navigator.of(context).pop();
       }else{
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));

        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 1,
            backgroundColor: Theme.of(context).cardColor,
            toolbarHeight: 120,
            leadingWidth: 0,
            automaticallyImplyLeading: false,
            title: Consumer<OrderProvider>(
              builder: (context, orderProvider, _) {
                return (orderProvider.orderDetails != null && orderProvider.orders != null) ?
                OrderDetailTopPortion(orderProvider: orderProvider,):const SizedBox();
              }
            )),
        body: Consumer<OrderProvider>(
          builder: (context, orderProvider,_) {
            return Consumer<SplashProvider>(
                builder: (context, config, _) {
                  return config.configModel != null?
                  Consumer<OrderProvider>(
                    builder: (context, orderProvider, child) {

                      double order = 0;
                      double discount = 0;
                      double? eeDiscount = 0;
                      double tax = 0;
                      double shippingCost = 0;



                      if (orderProvider.orderDetails != null && orderProvider.orderDetails!.isNotEmpty) {
                        if( orderProvider.orderDetails?[0].order?.isShippingFree == 1){
                          shippingCost = 0;
                        }else{
                          shippingCost = orderProvider.orders?.shippingCost??0;
                        }

                        for (var orderDetails in orderProvider.orderDetails!) {
                          if(orderDetails.productDetails?.productType != null && orderDetails.productDetails!.productType != "physical" ){
                            orderProvider.digitalOnly(false, isUpdate: false);
                          }
                        }



                        for (var orderDetails in orderProvider.orderDetails!) {
                          order = order + (orderDetails.price! * orderDetails.qty!);
                          discount = discount + orderDetails.discount!;
                          tax = tax + orderDetails.tax!;
                        }


                        if(orderProvider.orders != null && orderProvider.orders!.orderType == 'POS'){
                          if(orderProvider.orders!.extraDiscountType == 'percent'){
                            eeDiscount = order * (orderProvider.orders!.extraDiscount!/100);
                          }else{
                            eeDiscount = orderProvider.orders!.extraDiscount;
                          }
                        }
                      }


                      return (orderProvider.orderDetails != null && orderProvider.orders != null) ?
                      ListView(padding: const EdgeInsets.all(0), children: [



                        Container(height: 10, color: Theme.of(context).primaryColor.withOpacity(.1)),

                        if(Provider.of<SplashProvider>(context, listen: false).configModel?.orderVerification == 1 && orderProvider.orders!.orderType != 'POS')
                          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                            child: Center(child: Text.rich(TextSpan(children: [
                              TextSpan(text: '${getTranslated('order_verification_code', context)} : ', style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                              TextSpan(text: orderProvider.orders?.verificationCode??'', style: robotoBold.copyWith(color: Theme.of(context).primaryColor)),
                            ])),),
                          ),


                        ShippingAndBillingWidget(orderProvider: orderProvider),


                        orderProvider.orders != null && orderProvider.orders!.orderNote != null?
                        Padding(padding : const EdgeInsets.all(Dimensions.marginSizeSmall),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(text: '${getTranslated('order_note', context)} : ',
                                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                      color: ColorResources.getReviewRattingColor(context))),

                              TextSpan(text:  orderProvider.orders!.orderNote != null? orderProvider.orders!.orderNote ?? '': "",
                                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge?.color)),
                            ]))):const SizedBox(),
                        const SizedBox(height: Dimensions.paddingSizeSmall),



                        SellerSection(order: orderProvider),


                        if(orderProvider.orders != null)
                          OrderProductList(order: orderProvider,orderType: orderProvider.orders!.orderType, fromTrack: widget.fromTrack,isGuest: orderProvider.orders!.isGuest!,),


                        const SizedBox(height: Dimensions.marginSizeDefault),


                        Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          color: Theme.of(context).highlightColor,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                            AmountWidget(title: getTranslated('sub_total', context),
                                amount: PriceConverter.convertPrice(context, order)),


                            orderProvider.orders!.orderType == "POS"? const SizedBox():
                            AmountWidget(title: getTranslated('shipping_fee', context),
                                amount: PriceConverter.convertPrice(context, shippingCost)),


                            AmountWidget(title: getTranslated('discount', context),
                                amount: PriceConverter.convertPrice(context, discount)),


                            orderProvider.orders!.orderType == "POS"?
                            AmountWidget(title: getTranslated('extra_discount', context),
                                amount: PriceConverter.convertPrice(context, eeDiscount)):const SizedBox(),


                            AmountWidget(title: getTranslated('coupon_voucher', context),
                              amount: PriceConverter.convertPrice(context, orderProvider.orders!.discountAmount),),


                            AmountWidget(title: getTranslated('tax', context),
                                amount: PriceConverter.convertPrice(context, tax)),


                            const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                              child: Divider(height: 2, color: ColorResources.hintTextColor),),


                            AmountWidget(title: getTranslated('total_payable', context),
                              amount: PriceConverter.convertPrice(context, (order + shippingCost - eeDiscount! - orderProvider.orders!.discountAmount! - discount  + tax)),),
                          ]),
                        ),




                        const SizedBox(height: Dimensions.paddingSizeSmall,),

                        orderProvider.orders!.deliveryMan != null?
                        Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                              boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2), spreadRadius:2, blurRadius: 10)]),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                            Text('${getTranslated('shipping_info', context)}', style: robotoBold),
                            const SizedBox(height: Dimensions.marginSizeExtraSmall),



                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('${getTranslated('delivery_man', context)} : ',
                                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),


                              Text((orderProvider.orders!.deliveryMan != null ) ?
                              '${orderProvider.orders!.deliveryMan!.fName} ${orderProvider.orders!.deliveryMan!.lName}':'',
                                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),


                            ]),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              CallAndChatWidget(orderProvider: orderProvider, orderModel: orderProvider.orders),
                            ],
                            )
                          ]),
                        ):

                        orderProvider.orders!.deliveryServiceName != null?
                        ShippingInfo(order: orderProvider):const SizedBox(),



                        if(orderProvider.orderDetails != null && orderProvider.orderDetails!.isNotEmpty && orderProvider.orderDetails![0].verificationImages != null &&orderProvider.orderDetails![0].verificationImages!.isNotEmpty)
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeExtraSmall),
                              child: Text('${getTranslated('picture_uploaded_by', context)} ${orderProvider.orders!.deliveryMan != null? '${orderProvider.orders!.deliveryMan!.fName} ${orderProvider.orders!.deliveryMan!.lName}' : ''}',
                                style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),),

                            SizedBox(height: 120,
                              child: ListView.builder(
                                  itemCount: orderProvider.orderDetails![0].verificationImages?.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){

                                    return InkWell(
                                      onTap: (){
                                        showDialog(context: context, builder: (_)=> ImageDialog(imageUrl: '${AppConstants.baseUrl}/storage/app/public/delivery-man/verification-image/${orderProvider.orderDetails![0].verificationImages?[index].image}'));
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall,
                                            right: orderProvider.orderDetails![0].verificationImages!.length == index+1? Dimensions.paddingSizeSmall : 0),
                                        child: SizedBox(width: 200,
                                          child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                            child: Container(decoration: BoxDecoration(
                                                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25), width: .25),
                                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                                                child: CustomImage(image: '${AppConstants.baseUrl}/storage/app/public/delivery-man/verification-image/${orderProvider.orderDetails![0].verificationImages?[index].image}')),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                          ),


                        const SizedBox(height: Dimensions.paddingSizeDefault),


                        PaymentInfo(order: orderProvider),

                        const SizedBox(height: Dimensions.paddingSizeSmall),


                        CancelAndSupport(orderModel: orderProvider.orders),

                      ],
                      ) : const OrderDetailsShimmer();
                    },
                  ):const OrderDetailsShimmer();
                }
            );
          }
        )
      ),
    );
  }
}
