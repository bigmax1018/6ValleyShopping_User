import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailsShimmer extends StatelessWidget {

  const OrderDetailsShimmer({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: SingleChildScrollView(
        child: Column(children: [



          SizedBox(height: MediaQuery.of(context).size.height,
            child: Container(
              margin: const EdgeInsets.all(5),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.iconBg(),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor,
                highlightColor: Colors.grey[300]!,
                enabled: true,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [



                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(height: 30,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        decoration:  BoxDecoration(color: ColorResources.iconBg()))),


                  Padding(padding: const EdgeInsets.all(10),
                    child: Container(height: 300, padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        decoration: BoxDecoration(color: ColorResources.iconBg(), borderRadius: BorderRadius.circular(10)),),),

                  Row(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center, children: [


                        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Container(height: 100, width: 100, decoration: BoxDecoration(
                              color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)

                          ),),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeEight),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(height: 10, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),
                            const SizedBox(width: Dimensions.paddingSizeEight),

                            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(height: 10, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),
                            const SizedBox(width: Dimensions.paddingSizeEight),


                            Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: Container(height: 10, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),
                            const SizedBox(width: Dimensions.paddingSizeEight),
                            ],
                          ),
                        ),




                      ]),


                  const SizedBox(height: 50),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(height: 20, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),

                  const SizedBox(height: Dimensions.paddingSizeEight),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(height: 10, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),


                  const SizedBox(height: Dimensions.paddingSizeEight),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(height: 10, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),


                  const SizedBox(height: Dimensions.paddingSizeEight),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(height: 10, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),


                  const SizedBox(height: 30),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(height: 40, width: MediaQuery.of(context).size.width-20, color: Theme.of(context).cardColor),),



                ]),
              ),
            ),
          )
        ],
        ),
      ),
    );
  }
}

