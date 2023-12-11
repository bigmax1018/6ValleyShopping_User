import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/banner_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/banner_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/shop/shop_screen.dart';
import 'package:provider/provider.dart';

class BannerProvider extends ChangeNotifier {
  final BannerRepo? bannerRepo;

  BannerProvider({required this.bannerRepo});

  List<BannerModel>? _mainBannerList;
  List<BannerModel>? _footerBannerList;
  BannerModel? mainSectionBanner;
  BannerModel? sideBarBanner;
  Product? _product;
  int? _currentIndex;

  List<BannerModel>? get mainBannerList => _mainBannerList;
  List<BannerModel>? get footerBannerList => _footerBannerList;

  Product? get product => _product;
  int? get currentIndex => _currentIndex;
  BannerModel? promoBannerMiddleTop;
  BannerModel? promoBannerRight;
  BannerModel? promoBannerMiddleBottom;
  BannerModel? promoBannerLeft;
  BannerModel? promoBannerBottom;
  BannerModel? sideBarBannerBottom;
  BannerModel? topSideBarBannerBottom;

  Future<void> getBannerList(bool reload) async {
      ApiResponse apiResponse = await bannerRepo!.getBannerList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _mainBannerList = [];
        _footerBannerList = [];

        apiResponse.response!.data.forEach((bannerModel) {
          if(bannerModel['banner_type'] == 'Main Banner'){
            _mainBannerList!.add(BannerModel.fromJson(bannerModel));
          }
          else if(bannerModel['banner_type'] == 'Promo Banner Middle Top'){
            promoBannerMiddleTop = BannerModel.fromJson(bannerModel);
          }
          else if(bannerModel['banner_type'] == 'Promo Banner Right'){
            promoBannerRight = BannerModel.fromJson(bannerModel);
          }else if(bannerModel['banner_type'] == 'Promo Banner Middle Bottom'){
            promoBannerMiddleBottom = BannerModel.fromJson(bannerModel);
          }
          else if(bannerModel['banner_type'] == 'Promo Banner Bottom'){
            promoBannerBottom = BannerModel.fromJson(bannerModel);
          }
          else if(bannerModel['banner_type'] == 'Promo Banner Left'){
            promoBannerLeft = BannerModel.fromJson(bannerModel);
          }else if(bannerModel['banner_type'] == 'Sidebar Banner'){
            sideBarBanner = BannerModel.fromJson(bannerModel);
          }else if(bannerModel['banner_type'] == 'Top Side Banner'){
            topSideBarBannerBottom = BannerModel.fromJson(bannerModel);
          }else if(bannerModel['banner_type'] == 'Footer Banner'){
            _footerBannerList?.add(BannerModel.fromJson(bannerModel));
          }else if(bannerModel['banner_type'] == 'Main Section Banner'){
            mainSectionBanner = BannerModel.fromJson(bannerModel);
          }
        });

        _currentIndex = 0;
        notifyListeners();
      } else {
        ApiChecker.checkApi( apiResponse);
      }

  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }


  void clickBannerRedirect(BuildContext context, int? id, Product? product,  String? type){
    final cIndex =  Provider.of<CategoryProvider>(context, listen: false).categoryList.indexWhere((element) => element.id == id);
    final bIndex =  Provider.of<BrandProvider>(context, listen: false).brandList.indexWhere((element) => element.id == id);
    final tIndex =  Provider.of<TopSellerProvider>(context, listen: false).topSellerList!.indexWhere((element) => element.id == id);


    if(type == 'category'){
      if(Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
          isBrand: false,
          id: id.toString(),
          name: '${Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name}',
        )));
      }

    }else if(type == 'product'){
      if(product != null) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(
          productId: product.id,slug: product.slug,
        )));
      }

    }else if(type == 'brand'){
      if(Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
          isBrand: true,
          id: id.toString(),
          name: '${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}',
        )));
      }

    }else if( type == 'shop'){
      if(Provider.of<TopSellerProvider>(context, listen: false).topSellerList?[tIndex].shop?.name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
          sellerId: id,
          temporaryClose: Provider.of<TopSellerProvider>(context,listen: false).topSellerList?[tIndex].shop?.temporaryClose,
          vacationStatus: Provider.of<TopSellerProvider>(context,listen: false).topSellerList?[tIndex].shop?.vacationStatus,
          vacationEndDate: Provider.of<TopSellerProvider>(context,listen: false).topSellerList?[tIndex].shop?.vacationEndDate,
          vacationStartDate: Provider.of<TopSellerProvider>(context,listen: false).topSellerList?[tIndex].shop?.vacationStartDate,
          name: Provider.of<TopSellerProvider>(context,listen: false).topSellerList?[tIndex].shop?.name,
          banner: Provider.of<TopSellerProvider>(context,listen: false).topSellerList?[tIndex].shop?.banner,
          image: Provider.of<TopSellerProvider>(context,listen: false).topSellerList?[tIndex].shop?.image,
        )));
      }

    }
  }

}
