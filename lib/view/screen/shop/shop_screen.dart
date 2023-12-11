import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_filter_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/search_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/overview_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/widget/shop_info_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/widget/shop_product_view_list.dart';
import 'package:provider/provider.dart';

class TopSellerProductScreen extends StatefulWidget {
  final int? sellerId;
  final int? temporaryClose;
  final int? vacationStatus;
  final String? vacationEndDate;
  final String? vacationStartDate;
  final String? name;
  final String? banner;
  final String? image;
  const TopSellerProductScreen({Key? key, this.sellerId, this.temporaryClose, this.vacationStatus, this.vacationEndDate, this.vacationStartDate, this.name, this.banner, this.image}) : super(key: key);

  @override
  State<TopSellerProductScreen> createState() => _TopSellerProductScreenState();
}

class _TopSellerProductScreenState extends State<TopSellerProductScreen> with TickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool vacationIsOn = false;
  TabController? _tabController;
  int selectedIndex = 0;

  void _load() {
    Provider.of<ProductProvider>(context, listen: false).getSellerProductList(widget.sellerId.toString(), 1, context);
    Provider.of<SellerProvider>(context, listen: false).initSeller(widget.sellerId.toString(), context);
    Provider.of<ProductProvider>(context, listen: false).getSellerWiseBestSellingProductList(widget.sellerId.toString(), 1);
    Provider.of<ProductProvider>(context, listen: false).getSellerWiseFeaturedProductList(widget.sellerId.toString(), 1);
    Provider.of<ProductProvider>(context, listen: false).getSellerWiseRecommandedProductList(widget.sellerId.toString(), 1);
    Provider.of<CouponProvider>(context, listen: false).getSellerWiseCouponList(widget.sellerId!, 1);
    Provider.of<CategoryProvider>(context, listen: false).getSellerWiseCategoryList(widget.sellerId!);
    Provider.of<BrandProvider>(context, listen: false).getSellerWiseBrandList(widget.sellerId!);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SellerProvider>(context, listen: false).setMenuItemIndex(0, notify: false);
    searchController.clear();
    _load();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    if (widget.vacationEndDate != null) {
      DateTime vacationDate = DateTime.parse(widget.vacationEndDate!);
      DateTime vacationStartDate = DateTime.parse(widget.vacationStartDate!);
      final today = DateTime.now();
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if (difference >= 0 && widget.vacationStatus == 1 && startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: widget.name),
      body: Consumer<SellerProvider>(
        builder: (context, sellerProvider, _) {
          return CustomScrollView(
            controller: _scrollController, slivers: [
            SliverToBoxAdapter(
              child: ShopInfoWidget(
                  vacationIsOn: vacationIsOn,
                  sellerName: widget.name ?? "",
                  sellerId: widget.sellerId!,
                  banner: widget.banner ?? '',
                  shopImage: widget.image ?? '',
                  temporaryClose: widget.temporaryClose!),
            ),
            SliverPersistentHeader(pinned: true,
                delegate: SliverDelegate(
                    height: sellerProvider.shopMenuIndex == 1? 110: 40,
                    child: Container(color: Theme.of(context).canvasColor,
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                            child: Container(height: 40,
                              color: Theme.of(context).canvasColor,
                              child: TabBar(physics: const NeverScrollableScrollPhysics(),
                                isScrollable: true,
                                padding: const EdgeInsets.all(0),
                                controller: _tabController,
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: Theme.of(context).hintColor,
                                indicatorColor: Theme.of(context).primaryColor,
                                indicatorWeight: 1,
                                onTap: (value){
                                  sellerProvider.setMenuItemIndex(value);
                                  searchController.clear();},
                                indicatorPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                unselectedLabelStyle: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    fontWeight: FontWeight.w400),
                                labelStyle: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w700,
                                ),
                                tabs: [
                                  Tab(text: getTranslated("overview", context)),
                                  Tab(text: getTranslated("all_products", context)),
                                ],
                              ),
                            ),
                          ),


                          if(sellerProvider.shopMenuIndex == 1)
                            Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                              child: InkWell(onTap: () => showModalBottomSheet(context: context,
                                  isScrollControlled: true, backgroundColor: Colors.transparent,
                                  builder: (c) =>  ProductFilterDialog(sellerId: widget.sellerId!)),

                                child: Container(decoration: BoxDecoration(
                                    color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white: Theme.of(context).cardColor,
                                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                                    width: 30,height: 30,
                                    child: Padding(padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(Images.filterImage))),
                              ),
                            )
                        ],
                        ),


                        if(sellerProvider.shopMenuIndex == 1)

                          Container(
                            color: Theme.of(context).canvasColor,
                            child: SearchWidget(hintText: '${getTranslated('search_hint', context)}',
                                sellerId: widget.sellerId!),
                          )
                      ],
                      ),
                    ))),

            SliverToBoxAdapter(
              child: sellerProvider.shopMenuIndex == 0?
                ShopOverviewScreen(sellerId: widget.sellerId!, scrollController: _scrollController,):

              Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,0),
                child: ShopProductViewList(scrollController: _scrollController, sellerId: widget.sellerId!))),

          ]);
        }
      )

    );
  }
}
