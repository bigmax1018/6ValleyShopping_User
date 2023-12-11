import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/flash_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wishlist_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/featured_product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/order_again_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/top_store_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/announcement.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/aster_theme/find_what_you_need_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/aster_theme/find_what_you_need_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/aster_theme/more_store_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/aster_theme/order_again_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/banners_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/cart_widget_home_page.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/featured_deal_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/featured_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/flash_deal_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/flash_deals_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/footer_banner.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/home_category_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/just_for_you/just_for_you.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/latest_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/more_store_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/recommended_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/search_widget_home_page.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/top_seller_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/view_all_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/search_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/all_shop_screen.dart';
import 'package:provider/provider.dart';


class AsterThemeHomePage extends StatefulWidget {
  const AsterThemeHomePage({Key? key}) : super(key: key);

  @override
  State<AsterThemeHomePage> createState() => _AsterThemeHomePageState();
}

class _AsterThemeHomePageState extends State<AsterThemeHomePage> {
  final ScrollController _scrollController = ScrollController();


  Future<void> _loadData(bool reload) async {
    await Provider.of<BannerProvider>(Get.context!, listen: false).getBannerList(reload);
    await Provider.of<CategoryProvider>(Get.context!, listen: false).getCategoryList(reload);
    await Provider.of<HomeCategoryProductProvider>(Get.context!, listen: false).getHomeCategoryProductList(reload);
    await Provider.of<TopSellerProvider>(Get.context!, listen: false).getTopSellerList(reload);
    await Provider.of<BrandProvider>(Get.context!, listen: false).getBrandList(reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).getLatestProductList(1, reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).getFeaturedProductList('1', reload: reload);
    await Provider.of<FeaturedDealProvider>(Get.context!, listen: false).getFeaturedDealList(reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).getLProductList('1', reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).getRecommendedProduct();
    await Provider.of<ProductProvider>(Get.context!, listen: false).findWhatYouNeed();
    await Provider.of<ProductProvider>(Get.context!, listen: false).getJustForYouProduct();
    await Provider.of<SellerProvider>(Get.context!, listen: false).getMoreStore();
    await Provider.of<NotificationProvider>(Get.context!, listen: false).getNotificationList(1);
    if(Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn()){
      await Provider.of<ProfileProvider>(Get.context!, listen: false).getUserInfo(Get.context!);
      await Provider.of<ProductProvider>(Get.context!, listen: false).getShopAgainFromRecentStore();
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderList(1,'delivered', type: 'reorder' );
      await Provider.of<WishListProvider>(Get.context!, listen: false).getWishList();

    }
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

    singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode == "single";
    Provider.of<FlashDealProvider>(context, listen: false).getMegaDealList(true, true);

    _loadData(false);

    Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);

  }


  @override
  Widget build(BuildContext context) {
    List<String?> types =[getTranslated('new_arrival', context),getTranslated('top_product', context), getTranslated('best_selling', context),  getTranslated('discounted_product', context)];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadData( true);
            await Provider.of<FlashDealProvider>(Get.context!, listen: false).getMegaDealList(true, false);
          },
          child: CustomScrollView(controller: _scrollController, slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).highlightColor,
              title: Image.asset(Images.logoWithNameImage, height: 35), actions: const [
              CartWidgetHomePage(),
            ],
            ),

            SliverToBoxAdapter(child: Provider.of<SplashProvider>(context, listen: false).configModel!.announcement!.status == '1'?
            Consumer<SplashProvider>(
              builder: (context, announcement, _){
                return (announcement.configModel!.announcement!.announcement != null && announcement.onOff)?
                AnnouncementScreen(announcement: announcement.configModel!.announcement):const SizedBox();
              },

            ):const SizedBox(),),

            // Search Button
            SliverPersistentHeader(pinned: true,
                delegate: SliverDelegate(
                    child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
                        child: const SearchWidgetHomePage()))),

            SliverToBoxAdapter(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const BannersView(),
                const SizedBox(height: Dimensions.homePagePadding),

                // Flash Deal
                Consumer<FlashDealProvider>(
                  builder: (context, megaDeal, child) {
                    return  megaDeal.flashDeal != null ? megaDeal.flashDealList.isNotEmpty ?
                    Column(children: [
                      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.homePagePadding,
                          Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraExtraSmall),
                        child: TitleRow(title: getTranslated('flash_deal', context),
                            eventDuration: megaDeal.flashDeal != null ? megaDeal.duration : null,
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashDealScreen()));
                            },isFlash: true),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Text(getTranslated('hurry_up_the_offer_is_limited_grab_while_it_lasts', context)??'',
                          style: textRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor)),
                      const SizedBox(height: Dimensions.paddingSizeDefault),

                      SizedBox(height: MediaQuery.of(context).size.width * .94, child: const Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                          child: FlashDealsView())),],
                    ) : const SizedBox.shrink(): const FlashDealShimmer();},),


                // Find what you need
                Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                    return productProvider.findWhatYouNeedModel != null ? (productProvider.findWhatYouNeedModel!.findWhatYouNeed != null && productProvider.findWhatYouNeedModel!.findWhatYouNeed!.isNotEmpty)?
                    Padding(padding:  const EdgeInsets.only(bottom: Dimensions.homePagePadding, top: Dimensions.homePagePadding),
                      child: Column(children: [
                        TitleRow(title: getTranslated('find_what_you_need', context)),
                        const SizedBox(height: Dimensions.homePagePadding),
                        const SizedBox(height: 145, child: FindWhatYouNeedView()),
                      ],
                      ),
                    ):const SizedBox() : const FindWhatYouNeedShimmer();
                  }
                ),



                //Order Again
                (Provider.of<AuthProvider>(context, listen: false).isLoggedIn())?
                Consumer<OrderProvider>(
                  builder: (context, orderProvider,_) {
                    return orderProvider.deliveredOrderModel != null ? (orderProvider.deliveredOrderModel!.orders != null && orderProvider.deliveredOrderModel!.orders!.isNotEmpty)?
                      const Padding(padding: EdgeInsets.all(Dimensions.homePagePadding),
                      child: OrderAgainView(),
                    ):Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                      return bannerProvider.sideBarBanner != null?
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.bannerPadding, right: Dimensions.bannerPadding ),
                          child: SingleBannersView(bannerModel : bannerProvider.sideBarBanner, height: MediaQuery.of(context).size.width * 1.2)):const SizedBox();}): const OrderAgainShimmerShimmer();
                  }
                ): Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.sideBarBanner != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.bannerPadding, right: Dimensions.bannerPadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.sideBarBanner, height: MediaQuery.of(context).size.width * 1.2)):const SizedBox();}),
                const SizedBox(height: Dimensions.paddingSizeDefault,),




                //top seller
                singleVendor? const SizedBox():
                    Consumer<TopSellerProvider>(
                      builder: (context, sellerProvider,_) {
                        return sellerProvider.topSellerList != null? sellerProvider.topSellerList!.isNotEmpty ?
                        Column(children: [
                          TitleRow(title: getTranslated('top_stores', context),
                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const AllTopSellerScreen(topSeller: null, title: 'top_stores',)))),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                              child: SizedBox(height: 165, child: TopSellerView(isHomePage: true))),
                        ]): const SizedBox(): const TopStoreShimmer();
                      }
                    ),






                // Featured Deal

                Consumer<FeaturedDealProvider>(
                  builder: (context, featuredDealProvider, child) {
                    return featuredDealProvider.featuredDealProductList != null? featuredDealProvider.featuredDealProductList!.isNotEmpty ?
                    Stack(children: [
                      Container(width: MediaQuery.of(context).size.width,height: 150,
                          color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(.20):Theme.of(context).primaryColor.withOpacity(.125)),
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                          child: Column(children: [
                            Padding(padding: const EdgeInsets.fromLTRB(0, Dimensions.paddingSizeDefault,0 , Dimensions.paddingSizeDefault),
                              child: TitleRow(title: '${getTranslated('featured_deals', context)}',
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturedDealScreen())),),
                            ),
                            const FeaturedDealsView(),
                          ],
                          )),
                    ]) : const SizedBox.shrink() : const FindWhatYouNeedShimmer();},),

                //footer banner
                Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                  return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.length>1?
                   Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.homePagePadding, right: Dimensions.homePagePadding ),
                      child: SingleBannersView(bannerModel: footerBannerProvider.footerBannerList?[1],)):const SizedBox();}),




                // Featured Products
                Consumer<ProductProvider>(
                    builder: (context, featured,_) {
                      return  featured.featuredProductList != null?  featured.featuredProductList!.isNotEmpty ?
                      Stack(children: [
                          Padding(padding: const EdgeInsets.only(left: 50, bottom: 25),
                            child: Container(width: MediaQuery.of(context).size.width - 50,
                              height: Dimensions.featuredProductCard,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft : Radius.circular(Dimensions.paddingSizeDefault),
                                      bottomLeft: Radius.circular(Dimensions.paddingSizeDefault)),
                                  color: Theme.of(context).colorScheme.onSecondaryContainer
                              ),),
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                child: Padding(padding: const EdgeInsets.only(top: 20, left: 50,bottom: Dimensions.paddingSizeSmall),
                                    child: TitleRow( title: getTranslated('featured_products', context),
                                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.featuredProduct))))),
                              ),
                              Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                                child: FeaturedProductView(scrollController: _scrollController, isHome: true,),),
                            ],
                          ),
                        ],
                      ):const SizedBox() :  const FeaturedProductShimmer();}),




                //Cyber Monday Banner
                Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.topSideBarBannerBottom != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.bannerPadding, right: Dimensions.bannerPadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.topSideBarBannerBottom, height: MediaQuery.of(context).size.width * 1.2)):const SizedBox();}),



                const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                    child: RecommendedProductView(fromAsterTheme: true)),


                // Latest Products

                const LatestProductView(),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                //blackFriday
                Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.footerBannerList != null && bannerProvider.footerBannerList!.isNotEmpty?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.homePagePadding, right: Dimensions.homePagePadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.footerBannerList![0], height: MediaQuery.of(context).size.width * 0.5)):const SizedBox();}),




                //Just For You


                 SizedBox( child: Consumer<ProductProvider>(
                  builder: (context, productProvider,_) {
                    return (productProvider.justForYouProduct != null && productProvider.justForYouProduct!.isNotEmpty)?
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        TitleRow(title: getTranslated('just_for_you', context), onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.justForYou)));
                        },),
                        JustForYouView(productList: productProvider.justForYouProduct),
                      ],
                    ):const SizedBox();
                  }
                )),


                //More Store
                Consumer<SellerProvider>(
                  builder: (context, moreStoreProvider, _) {

                    return moreStoreProvider.moreStoreList.isNotEmpty ?
                    Padding(padding:  const EdgeInsets.fromLTRB(0, Dimensions.paddingSizeSmall, 0, Dimensions.paddingSizeSmall,),
                      child: Column(children: [
                        TitleRow(title: getTranslated('more_store', context),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  MoreStoreViewListView(title: getTranslated('more_store', context),)))
                        ),
                        const SizedBox(height: Dimensions.homePagePadding),
                        const SizedBox(height: 100, child: MoreStoreView(isHome: true,)),
                      ],
                      ),
                    ):const SizedBox();
                  }
                ),





                //Home category
                const Padding(padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: HomeCategoryProductView(isHomePage: true),
                ),
                const SizedBox(height: Dimensions.homePagePadding),


                Consumer<BannerProvider>(builder: (context, footerBannerProvider, child){
                  return footerBannerProvider.mainSectionBanner != null?
                  SingleBannersView(bannerModel: footerBannerProvider.mainSectionBanner, height: MediaQuery.of(context).size.width/4,):const SizedBox();}),
                // const SizedBox(height: Dimensions.homePagePadding),




                //Category filter
                Consumer<ProductProvider>(
                    builder: (ctx,prodProvider,child) {
                      return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeSmall, Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Expanded(child: Text(prodProvider.title == 'xyz' ? getTranslated('new_arrival',context)!:prodProvider.title!, style: titleHeader)),
                          prodProvider.latestProductList != null ? PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(value: ProductType.newArrival, textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ), child: Text(getTranslated('new_arrival',context)!)),
                                  PopupMenuItem(value: ProductType.topProduct, textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ), child: Text(getTranslated('top_product',context)!)),
                                  PopupMenuItem(value: ProductType.bestSelling, textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ), child: Text(getTranslated('best_selling',context)!)),
                                  PopupMenuItem(value: ProductType.discountedProduct, textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ), child: Text(getTranslated('discounted_product',context)!)),
                                ];
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical:Dimensions.paddingSizeSmall ),
                                  child: Image.asset(Images.dropdown, scale: 3)),
                              onSelected: (dynamic value) {
                                if(value == ProductType.newArrival){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[0]);
                                }else if(value == ProductType.topProduct){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[1]);
                                }else if(value == ProductType.bestSelling){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[2]);
                                }else if(value == ProductType.discountedProduct){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[3]);
                                }

                                ProductView(isHomePage: false, productType: value, scrollController: _scrollController);
                                Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, reload: true);


                              }
                          ) : const SizedBox(),
                        ]),
                      );
                    }),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                  child: ProductView(isHomePage: false, productType: ProductType.newArrival, scrollController: _scrollController),
                ),
                const SizedBox(height: Dimensions.homePagePadding),

              ],
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
