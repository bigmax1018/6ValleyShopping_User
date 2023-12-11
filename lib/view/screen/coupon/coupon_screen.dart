import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/coupon/widget/coupon_item.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/order_shimmer.dart';
import 'package:provider/provider.dart';

class CouponList extends StatefulWidget {
  const CouponList({Key? key}) : super(key: key);

  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  @override
  void initState() {
    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()){
      Provider.of<CouponProvider>(context, listen: false).getCouponList(context, 1);

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('coupons', context)),
      body: Provider.of<AuthProvider>(context, listen: false).isLoggedIn()?

      Consumer<CouponProvider>(
          builder: (context, couponProvider,_) {
            return couponProvider.couponList != null? couponProvider.couponList!.isNotEmpty?
            Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: couponProvider.couponList!.length,
                  itemBuilder: (context, index){
                    return CouponItem(coupons: couponProvider.couponList![index]);
                  }),
            ) : const NoInternetOrDataScreen(isNoInternet: false,
              icon: Images.noCoupon, message: 'no_coupon_available') : const OrderShimmer();
          }
      ): const NotLoggedInWidget(),
    );
  }
}