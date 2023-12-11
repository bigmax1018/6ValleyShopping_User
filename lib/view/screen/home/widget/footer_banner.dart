import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/banner_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:provider/provider.dart';



class SingleBannersView extends StatelessWidget {
  final BannerModel? bannerModel;
  final double? height;
  final bool noRadius;
  const SingleBannersView({Key? key, this.bannerModel, this.height,  this.noRadius = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Consumer<BannerProvider>(
    builder: (context, footerBannerProvider, child) {

      return InkWell(
        onTap: () {
          footerBannerProvider.clickBannerRedirect(context,
              bannerModel?.resourceId,
              bannerModel?.resourceType =='product'?
              bannerModel?.product : null,
              bannerModel?.resourceType);
        },
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(width: MediaQuery.of(context).size.width,
            height: height?? MediaQuery.of(context).size.width/2.2,
            decoration:  BoxDecoration(borderRadius: BorderRadius.all(noRadius?const Radius.circular(0): const Radius.circular(5))),
            child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(noRadius?0:5)),
              child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.bannerImageUrl}'
                  '/${bannerModel?.photo}')
            ),
          ),
        ),
      );
    },
    ),],
    );
  }
}

