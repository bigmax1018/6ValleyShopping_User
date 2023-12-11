
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/search_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/custom_check_box.dart';
import 'package:provider/provider.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  final bool onlyDigital;
  const PaymentMethodBottomSheet({Key? key, required this.onlyDigital,}) : super(key: key);

  @override
  PaymentMethodBottomSheetState createState() => PaymentMethodBottomSheetState();
}

class PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {


  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        return Container(constraints : BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9, minHeight: MediaQuery.of(context).size.height * 0.5 ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: Center(child: Container(width: 35,height: 4,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                      color: Theme.of(context).hintColor.withOpacity(.5))))),

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Text(getTranslated('choose_payment_method', context)??'',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault)),

                  Expanded(
                    child: Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                      child: Text('${getTranslated('click_one_of_the_option_below', context)}',
                          style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),
                    ),
                  )
                ],
                ),
              ),


              Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, children: [


                  Row(children: [
                    if(Provider.of<SplashProvider>(context, listen: false).configModel != null && Provider.of<SplashProvider>(context, listen: false).configModel!.cashOnDelivery! && !widget.onlyDigital)
                    Expanded(child: CustomButton(
                        isBorder: true,
                      leftIcon: Images.cod,
                      backgroundColor: orderProvider.codChecked? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                        textColor:  orderProvider.codChecked? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: Dimensions.fontSizeSmall,
                        onTap: () => orderProvider.setOfflineChecked('cod'),
                        buttonText: '${getTranslated('cash_on_delivery', context)}')),
                    const SizedBox(width: Dimensions.paddingSizeDefault),

                    if(Provider.of<SplashProvider>(context, listen: false).configModel != null && Provider.of<SplashProvider>(context, listen: false).configModel!.walletStatus! == 1 && Provider.of<AuthProvider>(context, listen: false).isLoggedIn())
                    Expanded(child: CustomButton(
                        onTap: () => orderProvider.setOfflineChecked('wallet'),
                        isBorder: true,
                        leftIcon: Images.payWallet,
                        backgroundColor: orderProvider.walletChecked ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                        textColor:  orderProvider.walletChecked? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: Dimensions.fontSizeSmall,
                        buttonText: '${getTranslated('pay_via_wallet', context)}')),


                  ],),

                  if(Provider.of<SplashProvider>(context, listen: false).configModel != null && Provider.of<SplashProvider>(context, listen: false).configModel!.digitalPayment!)
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeDefault),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('${getTranslated('pay_via_online', context)}', style: textRegular),
                        Expanded(
                          child: Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                            child: Text('${getTranslated('fast_and_secure', context)}', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                          ),
                        ),
                      ]),
                  ),

                  if(Provider.of<SplashProvider>(context, listen: false).configModel != null && Provider.of<SplashProvider>(context, listen: false).configModel!.digitalPayment!)
                    Consumer<SplashProvider>(
                      builder: (context, configProvider,_) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: configProvider.configModel?.paymentMethods?.length??0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return  CustomCheckBox(index: index,
                              icon: '${configProvider.configModel?.paymentMethodImagePath}/${configProvider.configModel?.paymentMethods?[index].additionalDatas?.gatewayImage??''}',
                              name: configProvider.configModel!.paymentMethods![index].keyName!,
                              title: configProvider.configModel!.paymentMethods![index].additionalDatas?.gatewayTitle??'',
                            );
                          },
                        );
                      }
                  ),


                  if(Provider.of<SplashProvider>(context, listen: false).configModel != null && Provider.of<SplashProvider>(context, listen: false).configModel!.offlinePayment != null)
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                    child: Container(
                      decoration: BoxDecoration(
                        color: orderProvider.offlineChecked?Theme.of(context).primaryColor.withOpacity(.15): null,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
                      ),
                      child: Column(children: [

                      Consumer<OrderProvider>(
                          builder: (context, orderProvider,_) {
                            return InkWell(
                              onTap: () {
                                if(orderProvider.offlinePaymentModel?.offlineMethods != null && orderProvider.offlinePaymentModel!.offlineMethods!.isNotEmpty){
                                  orderProvider.setOfflineChecked('offline');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
                                  child: Row(children: [
                                    Theme(data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Theme.of(context).primaryColor.withOpacity(.25),),
                                      child: Checkbox(
                                        visualDensity: VisualDensity.compact,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge)),
                                        value: orderProvider.offlineChecked,
                                        activeColor: Colors.green,
                                        onChanged: (bool? isChecked){
                                          if(orderProvider.offlinePaymentModel?.offlineMethods != null && orderProvider.offlinePaymentModel!.offlineMethods!.isNotEmpty){
                                            orderProvider.setOfflineChecked('offline');
                                          }
                                        }

                                      ),
                                    ),

                                    Text('${getTranslated('pay_offline', context)}', style: textRegular.copyWith(),),

                                  ]),
                                ),
                              ),
                            );
                          }
                      ),
                      if(orderProvider.offlinePaymentModel != null && orderProvider.offlinePaymentModel!.offlineMethods != null && orderProvider.offlinePaymentModel!.offlineMethods!.isNotEmpty && orderProvider.offlineChecked)
                        Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.paddingSizeDefault : 0, bottom: Dimensions.paddingSizeDefault, right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0 : Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeSmall),
                          child: SizedBox(height: 40,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: orderProvider.offlinePaymentModel!.offlineMethods!.length,
                                itemBuilder: (context, index){
                                  return InkWell(
                                    onTap: (){
                                      if(orderProvider.offlinePaymentModel?.offlineMethods != null && orderProvider.offlinePaymentModel!.offlineMethods!.isNotEmpty) {
                                        orderProvider.setOfflinePaymentMethodSelectedIndex(index);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                      child: Container(decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                          border: orderProvider.offlineMethodSelectedIndex == index ?
                                          Border.all(color: Theme.of(context).primaryColor, width: 2): Border.all(color: Theme.of(context).primaryColor.withOpacity(.5), width: .25)),
                                          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                            child: Center(child: Text(orderProvider.offlinePaymentModel!.offlineMethods![index].methodName??'')),
                                          )),
                                    ),
                                  );
                                }),
                          ),
                        ),

                    ],),),
                  ),





                  CustomButton(buttonText: '${getTranslated('save', context)}',
                  onTap: (){
                    Navigator.of(context).pop();
                  },),

                ],
              ),

            ]),
          ),
        );
      }
    );
  }
}

class FilterItemWidget extends StatelessWidget {
  final String? title;
  final int index;
  const FilterItemWidget({Key? key, required this.title, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: Row(children: [
          Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: InkWell(
                onTap: ()=> Provider.of<SearchProvider>(context, listen: false).setFilterIndex(index),
                child: Icon(Provider.of<SearchProvider>(context).filterIndex == index? Icons.check_box_rounded: Icons.check_box_outline_blank_rounded,
                    color: Provider.of<SearchProvider>(context).filterIndex == index? Theme.of(context).primaryColor: Theme.of(context).hintColor.withOpacity(.5))),
          ),
          Expanded(child: Text(title??'', style: textRegular.copyWith())),

        ],),),
    );
  }
}

class CategoryFilterItem extends StatelessWidget {
  final String? title;
  final bool checked;
  final Function()? onTap;
  const CategoryFilterItem({Key? key, required this.title, required this.checked, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: Row(children: [
          Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: InkWell(
                onTap: onTap,
                child: Icon(checked? Icons.check_box_rounded: Icons.check_box_outline_blank_rounded,
                    color: checked? Theme.of(context).primaryColor: Theme.of(context).hintColor.withOpacity(.5))),
          ),
          Expanded(child: Text(title??'', style: textRegular.copyWith())),

        ],),),
    );
  }
}

