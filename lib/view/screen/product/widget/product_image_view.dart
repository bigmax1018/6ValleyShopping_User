import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_details_model.dart'  as pd;
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_logged_in_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/compare/controller/compare_controller.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_image_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ProductImageView extends StatelessWidget {
  final pd.ProductDetailsModel? productModel;
  ProductImageView({Key? key, required this.productModel}) : super(key: key);

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

        InkWell(
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
              ProductImageScreen(title: getTranslated('product_image', context),imageList: productModel!.images))),
          child: productModel!.images !=null ?


          Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
            child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: Container(decoration:  BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.25)),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                child: Stack(children: [
                  SizedBox(height: MediaQuery.of(context).size.width,
                    child: productModel!.images != null?

                    PageView.builder(
                      controller: _controller,
                      itemCount: productModel!.images!.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius:BorderRadius.circular(Dimensions.paddingSizeSmall),
                          child: CustomImage(height: MediaQuery.of(context).size.width, width: MediaQuery.of(context).size.width,
                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${productModel!.images![index]}'),
                        );

                      },
                      onPageChanged: (index) {
                        Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                      },
                    ):const SizedBox(),
                  ),


                  Positioned(left: 0, right: 0, bottom: 10,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(),
                        const Spacer(),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: _indicators(context),
                        ),
                        const Spacer(),


                        Provider.of<ProductDetailsProvider>(context).imageSliderIndex != null?
                        Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSizeDefault),
                          child: Text('${Provider.of<ProductDetailsProvider>(context).imageSliderIndex!+1}/${productModel!.images!.length.toString()}'),
                        ):const SizedBox(),
                      ],
                    ),
                  ),

                  Positioned(top: 16, right: 16,
                    child: Column(
                      children: [
                        FavouriteButton(
                          backgroundColor: ColorResources.getImageBg(context),
                          productId: productModel!.id,
                        ),

                        if(Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme != "default")
                        const SizedBox(height: Dimensions.paddingSizeSmall,),
                        if(Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme != "default")
                        InkWell(onTap: () {
                          if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()){
                            Provider.of<CompareProvider>(context, listen: false).addCompareList(productModel!.id!);

                          }else{
                            showModalBottomSheet(backgroundColor: Colors.transparent,
                                context: context, builder: (_)=> const NotLoggedInBottomSheet());
                          }
                        },
                          child: Consumer<CompareProvider>(
                            builder: (context, compare,_) {
                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                child: Container(width: 40, height: 40,
                                  decoration: BoxDecoration(color: compare.compIds.contains(productModel!.id) ? Theme.of(context).primaryColor: Theme.of(context).cardColor ,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    child: Image.asset(Images.compare, color: compare.compIds.contains(productModel!.id) ?Theme.of(context).cardColor : Theme.of(context).primaryColor),
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall,),


                        InkWell(onTap: () {
                            if(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink != null) {
                              Share.share(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink!);
                            }
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            child: Container(width: 40, height: 40,
                              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.share, color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),



                ]),
              ),
            ),
          ):const SizedBox(),
        ),
      Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
            right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
        child: SizedBox(height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: productModel!.images!.length,
            itemBuilder: (context, index) {
              return InkWell(onTap: (){
                Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                _controller.animateToPage(index, duration: const Duration(microseconds: 50), curve:Curves.ease);
              },
                child: Padding(
                  padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex? 2:0,
                        color: (index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex && Provider.of<ThemeProvider>(context, listen: false).darkTheme)? Theme.of(context).primaryColor:
                        (index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)?Theme.of(context).primaryColor: Colors.transparent),
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                      child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        child: CustomImage(height: 50, width: 50,
                            image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${productModel!.images![index]}'),
                      ),
                    ),
                  ),
                ),
              );

            },),
        ),
      )

      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < productModel!.images!.length; index++) {
      indicators.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraSmall),
        child: Container(width: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex? 20 : 6, height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex ?
            Theme.of(context).primaryColor : Theme.of(context).hintColor,
          ),

        ),
      ));
    }
    return indicators;
  }

}
