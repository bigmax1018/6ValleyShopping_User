import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/carousel_options.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/custom_slider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/widget/shop_coupon_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/widget/shop_featured_product_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/widget/shop_recommanded_product_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShopOverviewScreen extends StatefulWidget {
  final int sellerId;
  final ScrollController scrollController;
  const ShopOverviewScreen({Key? key, required this.sellerId, required this.scrollController}) : super(key: key);

  @override
  State<ShopOverviewScreen> createState() => _ShopOverviewScreenState();
}

class _ShopOverviewScreenState extends State<ShopOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<CouponProvider>(
      builder: (context, couponProvider, _) {
        return  ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [

            couponProvider.couponItemModel != null? (couponProvider.couponItemModel!.coupons != null && couponProvider.couponItemModel!.coupons!.isNotEmpty)?
            SizedBox(width: width, height: MediaQuery.of(context).size.width *.85,
              child: couponProvider.couponItemModel != null? (couponProvider.couponItemModel!.coupons != null && couponProvider.couponItemModel!.coupons!.isNotEmpty)? Stack(
                fit: StackFit.expand, children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      onPageChanged: (index, reason) {
                        couponProvider.setCurrentIndex(index);
                      },
                    ),
                    itemCount: couponProvider.couponItemModel!.coupons!.length,
                    itemBuilder: (context, index, _) {

                      return SizedBox(child: ShopCouponItem(coupons: couponProvider.couponItemModel!.coupons![index],));
                    },
                  ),

                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: couponProvider.couponItemModel!.coupons!.map((banner) {
                        int index = couponProvider.couponItemModel!.coupons!.indexOf(banner);
                        return TabPageSelectorIndicator(
                          backgroundColor: index == couponProvider.couponCurrentIndex ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.25),
                          borderColor: index == couponProvider.couponCurrentIndex ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.25),
                          size: 5,
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(bottom: 10, right: 30,
                    child: Row(children: [
                        Text('${couponProvider.couponCurrentIndex+1}', style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
                        Text('/${couponProvider.couponItemModel!.coupons!.length}', style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                      ],
                    ),
                  ),
                ],
              ) :  Center(child: Text('${getTranslated('no_coupon_available', context)}')) : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: couponProvider.couponItemModel!.coupons == null,
                child: Container(margin: const EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.white,
                )),
              ),
            ): const SizedBox() : const Center(child: SizedBox()),


          Consumer<ProductProvider>(
            builder: (context, productProvider, _) {
              return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, 0),
                child: TitleRow(title: productProvider.sellerWiseFeaturedProduct != null ?  (productProvider.sellerWiseFeaturedProduct!.products != null&& productProvider.sellerWiseFeaturedProduct!.products!.isNotEmpty)?
                getTranslated('featured_products', context) : getTranslated('recommanded_products', context) : ''));
            }
          ),


            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, 0),
              child: ShopFeaturedProductViewList(scrollController: widget.scrollController,sellerId: widget.sellerId),),


            Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                return (productProvider.sellerWiseFeaturedProduct != null && productProvider.sellerWiseFeaturedProduct!.products != null&& productProvider.sellerWiseFeaturedProduct!.products!.isEmpty)?
                Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, 0),
                  child: ShopRecommandedProductViewList(scrollController: widget.scrollController,sellerId: widget.sellerId),): const SizedBox();
              }
            ),



          ],
        );
      }
    );
  }
}
