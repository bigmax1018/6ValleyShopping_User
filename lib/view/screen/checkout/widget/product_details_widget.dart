import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class CheckOutProductDetailsWidget extends StatelessWidget {
  const CheckOutProductDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: Provider.of<CartProvider>(context,listen: false).cartList.length,
          itemBuilder: (ctx,index){
            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Row(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.25)),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraExtraSmall),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraExtraSmall),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, fit: BoxFit.cover, width: 50, height: 50,
                      image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productThumbnailUrl}'
                          '/${Provider.of<CartProvider>(context,listen: false).cartList[index].thumbnail}',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover, width: 50, height: 50),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.marginSizeDefault),
                Expanded(
                  flex: 3,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            Provider.of<CartProvider>(context,listen: false).cartList[index].name!,
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.getPrimary(context)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall,),
                        Text(PriceConverter.convertPrice(context, Provider.of<CartProvider>(context,listen: false).cartList[index].price),
                          style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

                      ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),

                    Row(children: [

                      Text('${getTranslated('qty', context)} -  ${Provider.of<CartProvider>(context,listen: false).cartList[index].quantity}',
                          style: titilliumRegular.copyWith()),

                    ]),
                  ]),
                ),
              ]),
            );

          }),
    );
  }
}
