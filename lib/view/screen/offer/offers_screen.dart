import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '${getTranslated('offers', context)}',),
      body: Consumer<BannerProvider>(
        builder: (context, banner, child) {
          return banner.footerBannerList != null ? banner.footerBannerList!.isNotEmpty ? RefreshIndicator(
            onRefresh: () async {
              await Provider.of<BannerProvider>(context, listen: false).getBannerList(true);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              itemCount: Provider.of<BannerProvider>(context).footerBannerList!.length,
              itemBuilder: (context, index) {

                return InkWell(
                  onTap: () => _launchUrl(Uri.parse(banner.footerBannerList![index].url!)),
                  child: Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.bannerImageUrl}'
                      '/${banner.footerBannerList![index].photo}', height: 150, width: MediaQuery.of(context).size.width)
                    ),
                  ),
                );
              },
            ),
          ) : const Center(child: NoInternetOrDataScreen(isNoInternet: false, message: 'currently_no_offers_available',icon: Images.noOffer,)) : const OfferShimmer();
        },
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url)
        :  throw 'Could not launch $url';
  }
}

class OfferShimmer extends StatelessWidget {
  const OfferShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: Provider.of<BannerProvider>(context).footerBannerList == null,
          child: Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorResources.white),
          ),
        );
      },
    );
  }
}

