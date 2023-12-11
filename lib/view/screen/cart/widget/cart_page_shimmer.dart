import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';



class CartPageShimmer extends StatelessWidget {
  const CartPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Theme.of(context).cardColor),
              color: ColorResources.white,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: Colors.grey[300]!,
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(height: 15,width: MediaQuery.of(context).size.width/2, color: ColorResources.iconBg(),),),


                    Row(children: [
                       Container(decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                           color: Theme.of(context).cardColor),
                           width: 80,height: 80,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Container(height: 15, color: ColorResources.iconBg(),),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                            Container(height: 15, color: ColorResources.iconBg(),),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                            Row(
                              children: [
                                Container(height: 15,width: 120, color: ColorResources.iconBg(),),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(height: 10, width: 30, color: ColorResources.white),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                        ),
                      ])
                    ]),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}