import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/amount_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/order_place_success_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/choose_payment_section.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/coupon_apply_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/shipping_details_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/wallet_payment.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/offline_payment/offline_payment.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> cartList;
  final bool fromProductDetails;
  final double totalOrderAmount;
  final double shippingFee;
  final double discount;
  final double tax;
  final int? sellerId;
  final bool onlyDigital;
  final bool hasPhysical;
  final int quantity;

  const CheckoutScreen({Key? key, required this.cartList, this.fromProductDetails = false,
    required this.discount, required this.tax, required this.totalOrderAmount, required this.shippingFee, this.sellerId, this.onlyDigital = false, required this.quantity, required this.hasPhysical}) : super(key: key);


  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _controller = TextEditingController();

  final FocusNode _orderNoteNode = FocusNode();
  double _order = 0;
  late bool _billingAddress;
  double? _couponDiscount;


  TextEditingController paymentByController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController paymentNoteController = TextEditingController();



  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).stopLoader(notify: false);
    Provider.of<ProfileProvider>(context, listen: false).initAddressList();
    Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    Provider.of<CouponProvider>(context, listen: false).removePrevCouponData();
    Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
    Provider.of<OrderProvider>(context, listen: false).resetPaymentMethod();
    Provider.of<CartProvider>(context, listen: false).getChosenShippingMethod(context);
    if(Provider.of<SplashProvider>(context, listen: false).configModel != null && Provider.of<SplashProvider>(context, listen: false).configModel!.offlinePayment != null)
    {
      Provider.of<OrderProvider>(context, listen: false).getOfflinePaymentList();
    }

    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()){
      Provider.of<CouponProvider>(context, listen: false).getAvailableCouponList();
    }

    _billingAddress = Provider.of<SplashProvider>(Get.context!, listen: false).configModel!.billingInputByCustomer == 1;

  }

  @override
  Widget build(BuildContext context) {
    _order = widget.totalOrderAmount + widget.discount;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,

      bottomNavigationBar: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          return Consumer<CouponProvider>(
            builder: (context, couponProvider, _) {
              return Consumer<CartProvider>(
                builder: (context, cartProvider,_) {
                  return Consumer<ProfileProvider>(
                    builder: (context, profileProvider,_) {
                      return Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: CustomButton(
                          onTap: () async {
                            if(orderProvider.addressIndex == null && !widget.onlyDigital) {
                              showCustomSnackBar(getTranslated('select_a_shipping_address', context), context, isToaster: true);
                            }else if((orderProvider.billingAddressIndex == null && !widget.hasPhysical) || (orderProvider.billingAddressIndex == null && _billingAddress)){
                              showCustomSnackBar(getTranslated('select_a_billing_address', context), context, isToaster: true);

                            }

                            else {
                              List<CartModel> cartList = [];
                              cartList.addAll(widget.cartList);

                              for(int index=0; index<widget.cartList.length; index++) {
                                for(int i=0; i<cartProvider.chosenShippingList.length; i++) {
                                  if(cartProvider.chosenShippingList[i].cartGroupId == widget.cartList[index].cartGroupId) {
                                    cartList[index].shippingMethodId = cartProvider.chosenShippingList[i].id;
                                    break;
                                  }
                                }
                              }

                              String orderNote = orderProvider.orderNoteController.text.trim();
                              String couponCode = couponProvider.discount != null && couponProvider.discount != 0? couponProvider.couponCode : '';
                              String couponCodeAmount = couponProvider.discount != null && couponProvider.discount != 0? couponProvider.discount.toString() : '0';
                              String addressId = !widget.onlyDigital?profileProvider.addressList[orderProvider.addressIndex!].id.toString():'';
                              String billingAddressId = (_billingAddress)?
                              profileProvider.billingAddressList[orderProvider.billingAddressIndex!].id.toString() : '';


                              if(orderProvider.paymentMethodIndex != -1){
                                orderProvider.digitalPayment(
                                    orderNote: orderNote,
                                  customerId: Provider.of<AuthProvider>(context, listen: false).isLoggedIn()?
                                  profileProvider.userInfoModel?.id.toString() : Provider.of<AuthProvider>(context, listen: false).getGuestToken(),
                                  addressId: addressId,
                                  billingAddressId: billingAddressId,
                                  couponCode: couponCode,
                                  couponDiscount: couponCodeAmount,
                                  paymentMethod: orderProvider.selectedDigitalPaymentMethodName
                                );

                              }else if (orderProvider.codChecked && !widget.onlyDigital){
                                orderProvider.placeOrder(callback: _callback,
                                    addressID : widget.onlyDigital ? '': addressId,
                                    couponCode : couponCode,
                                    couponAmount : couponCodeAmount,
                                    billingAddressId : _billingAddress? billingAddressId: widget.onlyDigital ? '': addressId,
                                    orderNote : orderNote);

                              } else if(orderProvider.offlineChecked){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>  OfflinePaymentScreen(payableAmount: _order, callback: _callback)));
                              }else if(orderProvider.walletChecked){

                                showAnimatedDialog(context, Consumer<ProfileProvider>(
                                  builder: (context, profile,_) {
                                    return WalletPayment(
                                      currentBalance: profile.balance,
                                      orderAmount: _order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax,
                                      onTap: (){
                                        if(profile.balance! < (_order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax)){
                                          showCustomSnackBar(getTranslated('insufficient_balance', context), context, isToaster: true);
                                        }else{
                                          Navigator.pop(context);
                                          orderProvider.placeOrder(callback: _callback,wallet: true,
                                              addressID : widget.onlyDigital ? '': profileProvider.addressList[orderProvider.addressIndex!].id.toString(),
                                              couponCode : couponCode,
                                              couponAmount : couponCodeAmount,
                                              billingAddressId : _billingAddress? profileProvider.billingAddressList[orderProvider.billingAddressIndex!].id.toString(): widget.onlyDigital ? '': profileProvider.addressList[orderProvider.addressIndex!].id.toString(),
                                              orderNote : orderNote);
                                        }

                                      },
                                    );
                                  }
                                ), dismissible: false, isFlip: true);
                              }
                              else {

                              }
                            }
                          },
                          buttonText: '${getTranslated('proceed', context)}',
                        ),
                      );
                    }
                  );
                }
              );
            }
          );
        }
      ),

      appBar: CustomAppBar(title: getTranslated('checkout', context)),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider,_) {
          return Consumer<OrderProvider>(
            builder: (context, orderProvider,_) {
              return Column(children: [



                  Expanded(
                    child: ListView(physics: const BouncingScrollPhysics(), padding: const EdgeInsets.all(0), children: [


                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                        child: ShippingDetailsWidget(hasPhysical: widget.hasPhysical, billingAddress: _billingAddress)),


                      if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn())
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                        child: CouponApplyWidget(couponController: _controller, orderAmount: _order)),



                       Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: ChoosePaymentSection(onlyDigital: widget.onlyDigital)),

                      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall),
                        child: Text(getTranslated('order_summary', context)!,
                          style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                      // Total bill


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Consumer<OrderProvider>(
                          builder: (context, order, child) {
                             _couponDiscount = Provider.of<CouponProvider>(context).discount ?? 0;

                            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              widget.quantity>1?
                              AmountWidget(title: '${getTranslated('sub_total', context)} ${' (${widget.quantity} ${getTranslated('items', context)}) '}', amount: PriceConverter.convertPrice(context, _order)):
                              AmountWidget(title: '${getTranslated('sub_total', context)} ${'(${widget.quantity} ${getTranslated('item', context)})'}', amount: PriceConverter.convertPrice(context, _order)),
                              AmountWidget(title: getTranslated('shipping_fee', context), amount: PriceConverter.convertPrice(context, widget.shippingFee)),
                              AmountWidget(title: getTranslated('discount', context), amount: PriceConverter.convertPrice(context, widget.discount)),
                              AmountWidget(title: getTranslated('coupon_voucher', context), amount: PriceConverter.convertPrice(context, _couponDiscount)),
                              AmountWidget(title: getTranslated('tax', context), amount: PriceConverter.convertPrice(context, widget.tax)),
                              Divider(height: 5, color: Theme.of(context).hintColor),
                              AmountWidget(title: getTranslated('total_payable', context), amount: PriceConverter.convertPrice(context,
                                  (_order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax))),
                            ]);
                          },
                        ),
                      ),


                      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                              Text('${getTranslated('order_note', context)}',
                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          CustomTextField(
                            hintText: getTranslated('enter_note', context),
                            inputType: TextInputType.multiline,
                            inputAction: TextInputAction.done,
                            maxLines: 3,
                            focusNode: _orderNoteNode,
                            controller: orderProvider.orderNoteController,
                          ),
                        ]),
                      ),



                    ]),
                  ),
                ],
              );
            }
          );
        }
      ),
    );
  }

  void _callback(bool isSuccess, String message, String orderID) async {
    if(isSuccess) {
        Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
        showAnimatedDialog(context, OrderPlaceSuccessDialog(
          icon: Icons.check,
          title: getTranslated('order_placed', context),
          description: getTranslated('your_order_placed', context),
          isFailed: false,
        ), dismissible: false, isFlip: true);

      Provider.of<OrderProvider>(context, listen: false).stopLoader();
    }else {
      showCustomSnackBar(message, context, isToaster: true);
    }
  }
}

