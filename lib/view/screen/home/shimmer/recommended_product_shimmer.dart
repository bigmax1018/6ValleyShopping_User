import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedProductShimmer extends StatelessWidget {

  const RecommendedProductShimmer({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( Dimensions.homePagePadding),
      child: SizedBox(height: 180,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.iconBg(),
             // boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]
     ),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Colors.grey[300]!,
            enabled: true,
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

              Padding(
                padding: const EdgeInsets.all(Dimensions.homePagePadding),
                child: Container(height: 70,width: 140,
                    padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                    decoration: BoxDecoration(
                        color: ColorResources.iconBg(),
                        borderRadius: BorderRadius.circular(10))),
              ),

              Expanded(
                child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(height: 10, width: 50, color: ColorResources.white),
                          const Icon(Icons.star, color: Colors.orange, size: 15),
                        ]),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        Container(height: Dimensions.paddingSizeLarge, color: Theme.of(context).cardColor),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        Container(height: Dimensions.paddingSizeLarge, color: Theme.of(context).cardColor),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Container(height: Dimensions.paddingSizeLarge, color: Theme.of(context).cardColor),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(height: 35,decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor
                          ),),
                        ),




                      ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

