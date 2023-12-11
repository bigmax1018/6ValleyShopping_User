import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';



class LatestProductShimmer extends StatelessWidget {
  const LatestProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorResources.iconBg(),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Colors.grey[300]!,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
            child: Column(children: [
               Container(height: 220, width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   color: ColorResources.iconBg(),
                   borderRadius: BorderRadius.circular(10)
                 ),
                 ),



              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                child: Column(children: [
                  Container(height: 15, color: ColorResources.iconBg(),),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Container(height: 15, color: ColorResources.iconBg(),),
                ]),
              ),

            ]),
          ),
        ),
      ),
    );
  }
}