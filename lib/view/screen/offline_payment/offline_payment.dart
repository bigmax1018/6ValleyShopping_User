import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/proced_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/shipping_details_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/offline_payment/widget/offline_card.dart';
import 'package:provider/provider.dart';

class OfflinePaymentScreen extends StatefulWidget {
  final double payableAmount;
  final Function callback;
  const OfflinePaymentScreen({Key? key, required this.payableAmount, required this.callback}) : super(key: key);

  @override
  State<OfflinePaymentScreen> createState() => _OfflinePaymentScreenState();
}

class _OfflinePaymentScreenState extends State<OfflinePaymentScreen> {
   TextEditingController paymentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('offline_payment', context)),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, _) {
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min, children: [
                Center(child: SizedBox(height: 100, child: Image.asset(Images.offlinePayment))),
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Text('${getTranslated('offline_payment_helper_text', context)}', textAlign: TextAlign.center,
                      style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault)),),

                if(orderProvider.offlinePaymentModel != null && orderProvider.offlinePaymentModel!.offlineMethods != null && orderProvider.offlinePaymentModel!.offlineMethods!.isNotEmpty)
                  SizedBox(height: 190,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: orderProvider.offlinePaymentModel!.offlineMethods!.length,
                          itemBuilder: (context, index){
                            return InkWell(onTap: (){
                              if(orderProvider.offlinePaymentModel?.offlineMethods != null && orderProvider.offlinePaymentModel!.offlineMethods!.isNotEmpty){
                                orderProvider.setOfflinePaymentMethodSelectedIndex(index);
                              }
                            },
                                child: OfflineCard(offlinePaymentModel: orderProvider.offlinePaymentModel!.offlineMethods![index], index: index));
                          })),


                Center(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Text('${getTranslated('amount', context)} : ${PriceConverter.convertPrice(context, widget.payableAmount)}',
                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)))),


                Text('${getTranslated('payment_info', context)}', style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderProvider.offlinePaymentModel!.offlineMethods![orderProvider.offlineMethodSelectedIndex].methodInformations?.length,
                    itemBuilder: (context, index){

                      return Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                        child: CustomTextField(
                          controller: orderProvider.inputFieldControllerList[index],
                          required: orderProvider.offlinePaymentModel!.offlineMethods![orderProvider.offlineMethodSelectedIndex].methodInformations?[index].isRequired == 1,
                          labelText: '${orderProvider.offlinePaymentModel!.offlineMethods![orderProvider.offlineMethodSelectedIndex].methodInformations?[index].customerInput}'.replaceAll('_', ' ').capitalize(),
                          hintText: '${orderProvider.offlinePaymentModel!.offlineMethods![orderProvider.offlineMethodSelectedIndex].methodInformations?[index].customerPlaceholder}'.replaceAll('_', ' ').capitalize(),
                        ),
                      );
                    }),

                const SizedBox(height: 20,),

                CustomTextField(controller: paymentController,
                labelText:  getTranslated('note', context),
                hintText: getTranslated('note', context),),

                const SizedBox(height: 20,),


              ],),
            ),)
          ],);
        }
      ),
      bottomNavigationBar: Consumer<OrderProvider>(
        builder: (context, orderProvider, _) {
          return Consumer<ProfileProvider>(
            builder: (context, profileProvider,_) {
              return Consumer<CouponProvider>(
                builder: (context, couponProvider,_) {
                  return InkWell(
                    onTap: (){
                      bool emptyRequiredField = false;
                      for(int i = 0; i< orderProvider.offlinePaymentModel!.offlineMethods!.length; i++){
                        if(orderProvider.offlinePaymentModel!.offlineMethods![orderProvider.offlineMethodSelectedIndex].methodInformations?[i].isRequired == 1 && orderProvider.inputFieldControllerList[i].text.isEmpty){
                          emptyRequiredField = true;
                          break;
                        }
                      }



                      if(emptyRequiredField){
                        showCustomSnackBar('${getTranslated('fill_all_required_fill', context)}', context);
                      }
                      else{
                        String paymentNote = paymentController.text.trim();
                        String orderNote = orderProvider.orderNoteController.text.trim();
                        String couponCode = couponProvider.discount != null && couponProvider.discount != 0? couponProvider.couponCode : '';
                        String couponCodeAmount = couponProvider.discount != null && couponProvider.discount != 0? couponProvider.discount.toString() : '0';
                        String addressId = orderProvider.addressIndex != null ?profileProvider.addressList[orderProvider.addressIndex!].id.toString():'';
                        String billingAddressId = (Provider.of<SplashProvider>(context, listen: false).configModel!.billingInputByCustomer == 1)?
                        profileProvider.billingAddressList[orderProvider.billingAddressIndex!].id.toString() : '';
                        orderProvider.placeOrder(callback: widget.callback,
                            paymentNote: paymentNote,
                            addressID: addressId, billingAddressId: billingAddressId,
                            orderNote: orderNote, couponCode: couponCode, couponAmount: couponCodeAmount, isfOffline: true);
                      }

                    }, child: const ProceedButton());
                }
              );
            }
          );
        }
      ),
    );
  }
}
