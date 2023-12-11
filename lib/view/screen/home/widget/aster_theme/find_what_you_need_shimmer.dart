import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/flash_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/carousel_options.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/custom_slider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FindWhatYouNeedShimmer extends StatelessWidget {

  const FindWhatYouNeedShimmer({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.homePagePadding),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          viewportFraction: .7,
          autoPlay: true,
          aspectRatio: 1/.3,
          enlargeFactor: 0.1,
          enlargeCenterPage: true,
          disableCenter: true,
          onPageChanged: (index, reason) {
            Provider.of<FlashDealProvider>(context, listen: false).setCurrentIndex(index);
          },
        ),
        itemCount: 2,
        itemBuilder: (context, index, _) {

          return SizedBox(height: 100,
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
                    padding: const EdgeInsets.only(left: 8.0, right: 50, bottom: 8, top: 10),
                    child: Container(height: 8,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        decoration:  BoxDecoration(
                            color: ColorResources.iconBg())),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 8.0, right: 150),
                      child: Container(height: 7,width: 50,
                          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                          decoration:  BoxDecoration(color: ColorResources.iconBg()))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: SizedBox(height: 40,
                      child: Row(children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 3,
                              shrinkWrap: true, padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(height: 40,width: 40,
                                      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                                      decoration: BoxDecoration(
                                          color: ColorResources.iconBg(),
                                          borderRadius: BorderRadius.circular(5))),
                                );
                              }),
                        ),

                        Icon(Icons.arrow_forward_rounded, color: Theme.of(context).hintColor,)
                      ],
                      ),
                    ),
                  ),

                  Padding(padding: const EdgeInsets.only(left: 8.0, right: 220),
                      child: Container(height: 5,width: 50,
                          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                          decoration:  BoxDecoration(color: ColorResources.iconBg()))),


                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

