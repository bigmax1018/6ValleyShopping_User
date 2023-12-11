import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/carousel_options.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/custom_slider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';



class FashionBannersView extends StatelessWidget {
  const FashionBannersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BannerProvider>(
          builder: (context, bannerProvider, child) {

            double width = MediaQuery.of(context).size.width;
            return Stack(children: [
              bannerProvider.mainBannerList != null ? bannerProvider.mainBannerList!.isNotEmpty ?
              Column(children: [
                SizedBox(height: width * 0.40, width: width,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      aspectRatio: 2/1,
                      viewportFraction: 0.8,
                      autoPlay: true,
                      enlargeFactor: .2,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      onPageChanged: (index, reason) {
                        Provider.of<BannerProvider>(context, listen: false).setCurrentIndex(index);
                      },
                    ),
                    itemCount: bannerProvider.mainBannerList!.isEmpty ? 1 : bannerProvider.mainBannerList!.length,
                    itemBuilder: (context, index, _) {
                      String colorString = bannerProvider.mainBannerList![index].backgroundColor != null?
                      '0xff${ bannerProvider.mainBannerList![index].backgroundColor!.substring(1, 7)}'  : '0xFF424242';

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                        child: Container(decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                            color: Color(int.parse(colorString))
                        ), child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.bannerImageUrl}'
                                '/${bannerProvider.mainBannerList![index].photo}'),
                            Expanded(
                              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(mainAxisSize: MainAxisSize.min,children: [
                                    Text(bannerProvider.mainBannerList![index].title??'', style: textBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeLarge)),
                                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                      child: Text(bannerProvider.mainBannerList![index].subTitle??'',textAlign: TextAlign.center,
                                        maxLines: 3,style: textRegular.copyWith(color: ColorResources.white),),),
                                    SizedBox(height: 30, width: 100,child: CustomButton(backgroundColor: ColorResources.white,
                                            textColor: Colors.black45,
                                        onTap: () {
                                          bannerProvider.clickBannerRedirect(context,
                                              bannerProvider.mainBannerList![index].resourceId,
                                              bannerProvider.mainBannerList![index].resourceType =='product'?
                                              bannerProvider.mainBannerList![index].product : null,
                                              bannerProvider.mainBannerList![index].resourceType);
                                        },
                                        fontSize: Dimensions.fontSizeDefault,
                                        radius: 5,
                                        buttonText: bannerProvider.mainBannerList![index].buttonText??'Check Now'))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                        ),
                      );
                    },
                  ),
                ),
              ],
              ) : const SizedBox() : SizedBox(
                height: width * 0.49,width: width,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: bannerProvider.mainBannerList == null,
                  child: Container(margin: const EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorResources.white,
                  )),
                ),
              ),

              if( bannerProvider.mainBannerList != null &&  bannerProvider.mainBannerList!.isNotEmpty)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: bannerProvider.mainBannerList!.map((banner) {
                      int index = bannerProvider.mainBannerList!.indexOf(banner);
                      return index == bannerProvider.currentIndex ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        margin: const EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                          color:  Theme.of(context).primaryColor ,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  Text("${bannerProvider.mainBannerList!.indexOf(banner) + 1}/ ${bannerProvider.mainBannerList!.length}",style: const TextStyle(color: Colors.white,fontSize: 12),),

                      ):Container(height: 7, width: 7,
                        margin:  const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration:  BoxDecoration(
                          color: const Color(0xff1B7FED).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      );
                    }).toList(),
                  ),
                ),

            ],
            );
          },
        ),

        const SizedBox(height: 5),
      ],
    );
  }


}

