import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/carousel_options.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/custom_slider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/aster_theme/find_what_you_need_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/featured_deal_card.dart';
import 'package:provider/provider.dart';


class FeaturedDealsView extends StatelessWidget {
  final bool isHomePage;
  const FeaturedDealsView({Key? key, this.isHomePage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return isHomePage?
    Consumer<FeaturedDealProvider>(
      builder: (context, featuredDealProvider, child) {
        return featuredDealProvider.featuredDealProductList != null? featuredDealProvider.featuredDealProductList!.isNotEmpty ?
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 2.5,
            viewportFraction: 0.83,
            autoPlay: true,
            enlargeFactor: 0.2,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            disableCenter: true,
            onPageChanged: (index, reason) {
              Provider.of<FeaturedDealProvider>(context, listen: false).changeSelectedIndex(index);
            },
          ),
          itemCount: featuredDealProvider.featuredDealProductList?.length,


          itemBuilder: (context, index, _) {
            return FeaturedDealCard(isHomePage: isHomePage,product: featuredDealProvider.featuredDealProductList![index]);
          },
        ) : const SizedBox() :const FindWhatYouNeedShimmer();
      },
    ):
    Consumer<FeaturedDealProvider>(
      builder: (context, featuredDealProvider, _) {
        return ListView.builder(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            itemCount: featuredDealProvider.featuredDealProductList?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: FeaturedDealCard(isHomePage: isHomePage,product: featuredDealProvider.featuredDealProductList![index]),
              );
            });
      }
    );
  }
}


