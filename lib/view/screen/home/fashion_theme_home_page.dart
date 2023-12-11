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
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
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
import 'package:flutter_sixvalley_ecommerce/view/screen/category/all_category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/featured_product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/announcement.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/aster_theme/find_what_you_need_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/aster_theme/more_store_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/cart_widget_home_page.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/category_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/fashion_theme/most_demanded_product.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/fashion_theme/shop_again_from_your_recent_store.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/fashion_theme_banner.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/featured_deal_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/featured_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/flash_deal_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/flash_deals_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/footer_banner.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/just_for_you/just_for_you.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/latest_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/more_store_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/most_searching_product_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/recommended_product_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/search_widget_home_page.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/shop_again_from_recent_store_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/top_seller_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/view_all_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/search_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/all_shop_screen.dart';
import 'package:provider/provider.dart';


class FashionThemeHomePage extends StatefulWidget {
  const FashionThemeHomePage({Key? key}) : super(key: key);

  @override
  State<FashionThemeHomePage> createState() => _FashionThemeHomePageState();
}

class _FashionThemeHomePageState extends State<FashionThemeHomePage> {
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
    await Provider.of<ProductProvider>(Get.context!, listen: false).getMostDemandedProduct();
    await Provider.of<ProductProvider>(Get.context!, listen: false).getMostSearchingProduct(1);
    await Provider.of<SellerProvider>(Get.context!, listen: false).getMoreStore();
    await Provider.of<NotificationProvider>(Get.context!, listen: false).getNotificationList(1);
    if(Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn()){
      await Provider.of<ProfileProvider>(Get.context!, listen: false).getUserInfo(Get.context!);
      await Provider.of<ProductProvider>(Get.context!, listen: false).getShopAgainFromRecentStore();
      await Provider.of<WishListProvider>(Get.context!, listen: false).getWishList();

    }

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
              child: Column(children: [
                const FashionBannersView(),
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
                            },isFlash: true)),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Text(getTranslated('flash_sale_fore_any_item', context)??'', style: textRegular.copyWith(color: Theme.of(context).primaryColor)),
                      const SizedBox(height: Dimensions.paddingSizeDefault),

                      SizedBox(height: MediaQuery.of(context).size.width*.94, child: const Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                          child: FlashDealsView())),
                    ],
                    ) : const SizedBox.shrink(): const FlashDealShimmer();},),



                // Category
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                  child: TitleRow(title: getTranslated('CATEGORY', context),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllCategoryScreen()))),),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0 ,0 , Dimensions.homePagePadding),
                    child: CategoryView(isHomePage: true)),



                // Featured Deal

                Consumer<FeaturedDealProvider>(
                  builder: (context, featuredDealProvider, child) {
                    return  featuredDealProvider.featuredDealProductList != null? featuredDealProvider.featuredDealProductList!.isNotEmpty ?
                    Stack(children: [
                      Container(width: MediaQuery.of(context).size.width,height: 150,
                          color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(.20):Theme.of(context).primaryColor.withOpacity(.125)),
                       Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                          child: Column(children: [
                           Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                             child: TitleRow(title: '${getTranslated('featured_deals', context)}',
                               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturedDealScreen())),),
                           ),
                            const FeaturedDealsView(),
                          ],
                          )),
                    ]) : const SizedBox.shrink() : const FindWhatYouNeedShimmer();},),



                //footer banner
                Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.promoBannerMiddleTop != null?
                   Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.homePagePadding, right: Dimensions.homePagePadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.promoBannerMiddleTop, height: MediaQuery.of(context).size.width/3,)):const SizedBox();}),




                // Featured Products
                Consumer<ProductProvider>(
                    builder: (context, featured,_) {
                      return  featured.featuredProductList != null? featured.featuredProductList!.isNotEmpty ?
                      Stack(children: [
                          Padding(padding: const EdgeInsets.only(left: 50, bottom: 20),
                            child: Container(width: MediaQuery.of(context).size.width - 50,
                              height: Dimensions.featuredProductCard,
                              decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft : Radius.circular(Dimensions.paddingSizeDefault),
                                      bottomLeft: Radius.circular(Dimensions.paddingSizeDefault)),
                                  color: Theme.of(context).colorScheme.onSecondaryContainer
                              ),),
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall,vertical: Dimensions.paddingSizeExtraSmall),
                                child: Padding(padding: const EdgeInsets.only(top: 20, left: 50,bottom: Dimensions.paddingSizeSmall),
                                    child: TitleRow(title: getTranslated('featured_products', context),
                                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.featuredProduct))))),
                              ),
                              Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                                child: FeaturedProductView(scrollController: _scrollController, isHome: true,),),
                            ],
                          ),
                        ],
                      ):const SizedBox(): const FeaturedProductShimmer();}),



                // top seller
                singleVendor?const SizedBox():
                Consumer<TopSellerProvider>(
                  builder: (context, topStoreProvider,_) {
                    return (topStoreProvider.topSellerList != null && topStoreProvider.topSellerList!.isNotEmpty)?
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        TitleRow(title: getTranslated('top_fashion_house', context),
                            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const AllTopSellerScreen(topSeller: null,title: 'top_fashion_house',)))),
                        singleVendor?const SizedBox(height: 0):const SizedBox(height: Dimensions.paddingSizeSmall),
                        singleVendor?const SizedBox():
                        const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                            child: SizedBox(height: 165, child: TopSellerView(isHomePage: true))),

                      ],
                    ): const SizedBox();
                  }
                ),


                Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.promoBannerLeft != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.homePagePadding, right: Dimensions.homePagePadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.promoBannerLeft, height: MediaQuery.of(context).size.width * .90)):const SizedBox();}),





                const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                    child: RecommendedProductView(fromAsterTheme: true)),


                // Latest Products


                const LatestProductView(),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                //big Sale
                Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.promoBannerMiddleBottom != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge, left:Dimensions.homePagePadding, right: Dimensions.paddingSizeSmall ),
                      child: SingleBannersView(bannerModel : bannerProvider.promoBannerMiddleBottom, height: MediaQuery.of(context).size.width/3)):const SizedBox();}),




                //most Searching
                Consumer<ProductProvider>(
                    builder: (context, productProvider, _) {
                      return (productProvider.mostSearchingProduct != null && productProvider.mostSearchingProduct!.products != null && productProvider.mostSearchingProduct!.products!.isNotEmpty)?
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          TitleRow(title: getTranslated('your_most_searching', context),
                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const MostSearchingProductListView()))),
                          JustForYouView(productList: productProvider.mostSearchingProduct?.products),
                        ],
                      ):const SizedBox();
                    }
                ),





                // Most demanded product
                Consumer<ProductProvider>(
                  builder: (context, demandProvider, _) {
                    return demandProvider.mostDemandedProductModel != null?
                    InkWell(onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetails(productId: demandProvider.mostDemandedProductModel?.productId,slug: demandProvider.mostDemandedProductModel?.slug))),
                      child: Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
                        child: Column(children: [
                          Text(getTranslated('most_demanded_product', context)!, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          const MostDemandedProductView()])),
                    ): const SizedBox();
                  }
                ),



                //Shop Again From Your Recent Store
                if(Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn())
                Consumer<ProductProvider>(
                  builder: (context, shopAgainProvider,_) {
                    return shopAgainProvider.shopAgainFromRecentStoreList.isNotEmpty?
                    Padding(padding: const EdgeInsets.only(top: Dimensions.homePagePadding),
                      child: Column(children: [
                        TitleRow(title: getTranslated('shop_again_from_recent_store', context),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=> const ShopAgainFromYourRecentStoreView()))),
                        const SizedBox(height: 160, child: ShopAgainFromYourRecentStore()),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                      ],
                      ),
                    ):const SizedBox();
                  }
                ),

                Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.promoBannerRight != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.bannerPadding, right: Dimensions.bannerPadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.promoBannerRight, height: MediaQuery.of(context).size.width * 1.5)):const SizedBox();}),


                Consumer<BannerProvider>(builder: (context, bannerProvider, child){
                  return bannerProvider.promoBannerBottom != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding ),
                      child: SingleBannersView(noRadius: true, bannerModel : bannerProvider.promoBannerBottom, height: MediaQuery.of(context).size.width / 10)):const SizedBox();}),



                //other Store
                Consumer<SellerProvider>(
                  builder: (context, moreSellerProvider, _) {
                    return moreSellerProvider.moreStoreList.isNotEmpty?
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                        child: TitleRow(title: getTranslated('other_store', context),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MoreStoreViewListView()))),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      const SizedBox(height: 100, child: MoreStoreView(isHome: true,)),
                    ],):const SizedBox();
                  }
                ),





                Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.125)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(top: Dimensions.homePagePadding, bottom: Dimensions.paddingSizeSmall),
                      child: TitleRow(title : getTranslated('all_products', context)!)),

                    Consumer<ProductProvider>(
                      builder: (context, productProvider, _) {
                        return Padding(padding: const EdgeInsets.only(bottom : Dimensions.paddingSizeSmall),
                          child: SizedBox(height: 35,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: productProvider.productTypeList.length,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index){
                                  return InkWell(onTap: ()=> productProvider.changeTypeOfProduct(productProvider.productTypeList[index].productType, productProvider.productTypeList[index].title, index: index),
                                    child: Padding(padding: EdgeInsets.only(left : Provider.of<LocalizationProvider>(context, listen: false).isLtr ? Dimensions.paddingSizeDefault : 0,
                                        right: index+1 == productProvider.productTypeList.length? Dimensions.paddingSizeDefault : Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 0 : Dimensions.paddingSizeDefault),
                                      child: Container(padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeDefault),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                              color: Theme.of(context).cardColor,
                                              border: Border.all(width: 1, color: index == productProvider.selectedProductTypeIndex?
                                              Theme.of(context).primaryColor.withOpacity(.5) : Theme.of(context).cardColor)),
                                          child: Center(child: Text('${getTranslated(productProvider.productTypeList[index].title!, context)}',
                                              style: textMedium.copyWith(color: index == productProvider.selectedProductTypeIndex?
                                              Theme.of(context).primaryColor : Theme.of(context).hintColor)))),
                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                  ),


                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: ProductView(isHomePage: false, productType: ProductType.newArrival, scrollController: _scrollController)),
                  const SizedBox(height: Dimensions.homePagePadding),
                ],),),



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
