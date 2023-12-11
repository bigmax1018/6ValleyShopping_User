import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class OrderAgainShimmerShimmer extends StatelessWidget {

  const OrderAgainShimmerShimmer({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding, vertical: 5),
        child: SizedBox(
          child: Container(
            margin: const EdgeInsets.all(5),
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.iconBg(),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: Colors.grey[300]!,
              enabled: true,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


                Padding(padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeSmall,
                    horizontal: Dimensions.paddingSizeSmall),
                  child: Container(height: 12,
                      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                      decoration:  BoxDecoration(
                          color: ColorResources.iconBg())),
                ),

                Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall,
                    right: 100),
                  child: Container(height: 12,
                      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                      decoration:  BoxDecoration(
                          color: ColorResources.iconBg())),
                ),


                const SizedBox(height: 10,),

                SizedBox(height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Container(height: 50,width: 50,
                          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                          decoration: BoxDecoration(
                              color: ColorResources.iconBg(),
                              borderRadius: BorderRadius.circular(10))),
                    );
                  }),
                ),

                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Row(children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, children: [

                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                              Container(height: 10, color: Theme.of(context).cardColor),
                              const SizedBox(height: Dimensions.paddingSizeEight),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: Container(height: 10, color: Theme.of(context).cardColor),
                              ),
                            ]),
                      ),

                    const SizedBox(width: 20,),
                    Container(height: 30,width: 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)
                    ),),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }
}

