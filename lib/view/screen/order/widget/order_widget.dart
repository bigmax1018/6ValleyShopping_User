import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_details_screen.dart';
import 'package:provider/provider.dart';


class OrderWidget extends StatelessWidget {
  final Orders? orderModel;
  const OrderWidget({Key? key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderId: orderModel!.id)));},

      child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,
              left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(width: 82,height: 82,
                  child: Column(children: [
                    Container(decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(.25)),
                      boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme? null :[BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],
                    ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder, fit: BoxFit.scaleDown, width: 80, height: 80,
                          image: '${Provider.of<SplashProvider>(context, listen: false).configModel?.baseUrls?.shopImageUrl}/${orderModel?.seller?.shop?.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.scaleDown, width: 80, height: 80),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(width: Dimensions.paddingSizeLarge),



                Expanded(flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(
                        child: Text('${getTranslated('order', context)!}# ${orderModel!.id.toString()}',
                            style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text(DateConverter.localDateToIsoStringAMPMOrder(DateTime.parse(orderModel!.createdAt!)),
                        style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).hintColor,
                        )),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text(PriceConverter.convertPrice(context, orderModel!.orderAmount), style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getPrimary(context)),),
                  ]),
                ),



                SizedBox(

                  child: Container(alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeEight),
                    decoration: BoxDecoration(
                      color: orderModel!.orderStatus == 'delivered'? ColorResources.getGreen(context).withOpacity(.10) :
                      orderModel!.orderStatus == 'pending'? ColorResources.getYellow(context).withOpacity(.10) :
                      orderModel!.orderStatus == 'confirmed'? ColorResources.getFloatingBtn(context).withOpacity(.10)
                          : ColorResources.getYellow(context).withOpacity(.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(getTranslated('${orderModel!.orderStatus}', context)!, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: orderModel!.orderStatus == 'delivered'?  ColorResources.getGreen(context) :
                      orderModel!.orderStatus == 'pending'? ColorResources.getYellow(context) :
                      orderModel!.orderStatus == 'confirmed'? ColorResources.getFloatingBtn(context)
                          : ColorResources.getYellow(context),
                    )),
                  ),
                ),

              ]),
            ),
          ),

          Positioned(top: 2, left: 90, child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Text("${orderModel?.orderDetailsCount}", style: textRegular.copyWith(color: Colors.white))
          )),
        ],
      ),
    );
  }
}
