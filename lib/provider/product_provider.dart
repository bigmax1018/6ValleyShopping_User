import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/find_what_you_need.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/most_demanded_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/product_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/model/shop_again_from_recent_store_model.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo? productRepo;
  ProductProvider({required this.productRepo});

  // Latest products
  List<Product>? _latestProductList = [];
  List<Product>? _lProductList;
  List<Product>? get lProductList=> _lProductList;
  List<Product>? _featuredProductList;



  ProductType _productType = ProductType.newArrival;
  String? _title = 'xyz';

  bool _filterIsLoading = false;
  bool _filterFirstLoading = true;

  bool _isLoading = false;
  bool _isFeaturedLoading = false;
  bool get isFeaturedLoading => _isFeaturedLoading;
  bool _firstFeaturedLoading = true;
  bool _firstLoading = true;
  int? _latestPageSize = 1;
  int _lOffset = 1;
  int? _lPageSize;
  int? get lPageSize=> _lPageSize;
  int? _featuredPageSize;

  ProductType get productType => _productType;
  String? get title => _title;
  int get lOffset => _lOffset;


  List<int> _offsetList = [];
  List<String> _lOffsetList = [];
  List<String> get lOffsetList=>_lOffsetList;
  List<String> _featuredOffsetList = [];

  List<Product>? get latestProductList => _latestProductList;
  List<Product>? get featuredProductList => _featuredProductList;

  Product? _recommendedProduct;
  Product? get recommendedProduct=> _recommendedProduct;

  bool get filterIsLoading => _filterIsLoading;
  bool get filterFirstLoading => _filterFirstLoading;
  bool get isLoading => _isLoading;
  bool get firstFeaturedLoading => _firstFeaturedLoading;
  bool get firstLoading => _firstLoading;
  int? get latestPageSize => _latestPageSize;
  int? get featuredPageSize => _featuredPageSize;




  //latest product
  Future<void> getLatestProductList(int offset, {bool reload = false}) async {
    if(reload || offset == 1) {
      _offsetList = [];
      _latestProductList = [];
    }
    _lOffset = offset;
    if(!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getLatestProductList(Get.context!, offset.toString(), _productType, title);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        if(offset==1){
          _latestProductList = [];
        }

          if(ProductModel.fromJson(apiResponse.response!.data).products != null){
            _latestProductList!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
            _latestPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
          }

          _filterFirstLoading = false;
          _filterIsLoading = false;
          _filterIsLoading = false;
          removeFirstLoading();
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }else {
      if(_filterIsLoading) {
        _filterIsLoading = false;
        notifyListeners();
      }
    }

  }
  //latest product
  Future<void> getLProductList(String offset, {bool reload = false}) async {
    if(reload) {
      _lOffsetList = [];
      _lProductList = [];
    }
    if(!_lOffsetList.contains(offset)) {
      _lOffsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getLProductList(offset);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _lProductList = [];
        _lProductList?.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        _lPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _firstLoading = false;
        _isLoading = false;
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }else {
      if(_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }

  }


  List<ProductTypeModel> productTypeList = [
    ProductTypeModel('new_arrival', ProductType.newArrival),
    ProductTypeModel('top_product', ProductType.topProduct),
    ProductTypeModel('best_selling', ProductType.bestSelling),
    ProductTypeModel('discounted_product', ProductType.discountedProduct),
  ];

  
int selectedProductTypeIndex = 0;
 void changeTypeOfProduct(ProductType type, String? title, {int index = 0}){
    _productType = type;
    _title = title;
    _latestProductList = null;
    _latestPageSize = 1;
    _filterFirstLoading = true;
    _filterIsLoading = true;
    selectedProductTypeIndex = index;
    getLatestProductList(1, reload: true);
    notifyListeners();
 }

  void showBottomLoader() {
    _isLoading = true;
    _filterIsLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }


  TextEditingController sellerProductSearch = TextEditingController();
  void clearSearchField( String id){
    sellerProductSearch.clear();
    notifyListeners();
  }



  ProductModel? sellerProduct;
  Future <ApiResponse> getSellerProductList(String sellerId, int offset, BuildContext context, {bool reload = true, String search = '', String categoryIds = '', String brandIds = ''}) async {

    sellerProduct = null;
    notifyListeners();
    ApiResponse apiResponse = await productRepo!.getSellerProductList(sellerId, offset.toString(), search, categoryIds, brandIds);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        sellerProduct = null;
        if(ProductModel.fromJson(apiResponse.response!.data).products != null){
          sellerProduct = (ProductModel.fromJson(apiResponse.response!.data));
        }
      }else{
        sellerProduct?.products?.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        sellerProduct?.offset = (ProductModel.fromJson(apiResponse.response!.data).offset!);
        sellerProduct?.totalSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
      }
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }



  final List<Product> _brandOrCategoryProductList = [];
  bool? _hasData;

  List<Product> get brandOrCategoryProductList => _brandOrCategoryProductList;
  bool? get hasData => _hasData;

  void initBrandOrCategoryProductList(bool isBrand, String id, BuildContext context) async {
    _brandOrCategoryProductList.clear();
    _hasData = true;
    ApiResponse apiResponse = await productRepo!.getBrandOrCategoryProductList(isBrand, id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((product) => _brandOrCategoryProductList.add(Product.fromJson(product)));
      _hasData = _brandOrCategoryProductList.length > 1;
      List<Product> products = [];
      products.addAll(_brandOrCategoryProductList);
      _brandOrCategoryProductList.clear();
      _brandOrCategoryProductList.addAll(products.reversed);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  // Related products
  List<Product>? _relatedProductList;
  List<Product>? get relatedProductList => _relatedProductList;

  void initRelatedProductList(String id, BuildContext context) async {
    ApiResponse apiResponse = await productRepo!.getRelatedProductList(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _relatedProductList = [];
      apiResponse.response!.data.forEach((product) => _relatedProductList!.add(Product.fromJson(product)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = null;
  }


  int featuredIndex = 0;
  void setFeaturedIndex(int index){
    featuredIndex = index;
    notifyListeners();
  }


  //featured product

  Future<void> getFeaturedProductList(String offset, {bool reload = false}) async {
    if(reload) {
      _featuredOffsetList = [];
      _featuredProductList = [];
    }
    if(!_featuredOffsetList.contains(offset)) {
      _featuredOffsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getFeaturedProductList(offset);
      if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {
        _featuredProductList = [];
        if(apiResponse.response!.data['products'] != null){
          _featuredProductList?.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
          _featuredPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        }

        _firstFeaturedLoading = false;
        _isFeaturedLoading = false;
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }else {
      if(_isFeaturedLoading) {
        _isFeaturedLoading = false;
        notifyListeners();
      }
    }

  }


  bool recommendedProductLoading = false;
  Future<void> getRecommendedProduct() async {
    ApiResponse apiResponse = await productRepo!.getRecommendedProduct();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _recommendedProduct = Product.fromJson(apiResponse.response!.data);
      }
      notifyListeners();
  }



  ProductModel? productModel;
  Future<void> getSellerWiseBestSellingProductList(String sellerId, int offset) async {

    _firstLoading = true;
    _filterFirstLoading = true;
      ApiResponse apiResponse = await productRepo!.getSellerWiseBestSellingProductList(sellerId, offset.toString());
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
          if(offset == 1){
            productModel = ProductModel.fromJson(apiResponse.response!.data);
          }else {

            productModel!.products!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
            productModel!.offset = ProductModel.fromJson(apiResponse.response!.data).offset;
            productModel!.totalSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
          }
          _firstLoading = false;
          _filterFirstLoading = false;
      } else {
        _firstLoading = false;
        _filterFirstLoading = false;
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
  }



  ProductModel? sellerWiseFeaturedProduct;
  Future<void> getSellerWiseFeaturedProductList(String sellerId, int offset) async {
    ApiResponse apiResponse = await productRepo!.getSellerWiseFeaturedProductList(sellerId, offset.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        sellerWiseFeaturedProduct = ProductModel.fromJson(apiResponse.response!.data);
      }else {
        sellerWiseFeaturedProduct!.products!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        sellerWiseFeaturedProduct!.offset = ProductModel.fromJson(apiResponse.response!.data).offset;
        sellerWiseFeaturedProduct!.totalSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
      }
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  ProductModel? sellerWiseRecommandedProduct;
  Future<void> getSellerWiseRecommandedProductList(String sellerId, int offset) async {
    ApiResponse apiResponse = await productRepo!.getSellerWiseRecomendedProductList(sellerId, offset.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        sellerWiseRecommandedProduct = ProductModel.fromJson(apiResponse.response!.data);
      }else {
        sellerWiseRecommandedProduct!.products!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        sellerWiseRecommandedProduct!.offset = ProductModel.fromJson(apiResponse.response!.data).offset;
        sellerWiseRecommandedProduct!.totalSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
      }
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  // int cardCurrentIndex = 2;
  // void setCardCurrentIndex(int index){
  //   cardCurrentIndex = index;
  //   notifyListeners();
  // }

  MostDemandedProductModel? mostDemandedProductModel;
  Future<void> getMostDemandedProduct() async {
    ApiResponse apiResponse = await productRepo!.getMostDemandedProduct();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(apiResponse.response?.data != null && apiResponse.response?.data.isNotEmpty && apiResponse.response?.data != '[]'){
        mostDemandedProductModel = MostDemandedProductModel.fromJson(apiResponse.response!.data);
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  List<ShopAgainFromRecentStoreModel> shopAgainFromRecentStoreList = [];

  Future<void> getShopAgainFromRecentStore() async {
    ApiResponse apiResponse = await productRepo!.getShopAgainFromRecentStoreList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response?.data.forEach((shopAgain)=> shopAgainFromRecentStoreList.add(ShopAgainFromRecentStoreModel.fromJson(shopAgain)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  FindWhatYouNeedModel? findWhatYouNeedModel;
  Future<void> findWhatYouNeed() async {
    ApiResponse apiResponse = await productRepo!.getFindWhatYouNeed();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      findWhatYouNeedModel = FindWhatYouNeedModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  List<Product>? justForYouProduct;
  Future<void> getJustForYouProduct() async {
    justForYouProduct = [];
    ApiResponse apiResponse = await productRepo!.getJustForYouProductList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    apiResponse.response?.data.forEach((justForYou)=> justForYouProduct?.add(Product.fromJson(justForYou)));
    }
    notifyListeners();
  }

  ProductModel? mostSearchingProduct;
  Future<void> getMostSearchingProduct(int offset, {bool reload = false}) async {
    ApiResponse apiResponse = await productRepo!.getMostSearchingProductList(offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(apiResponse.response?.data['products'] != null && apiResponse.response?.data['products'] != 'null'){
        if(offset == 1) {
          mostSearchingProduct = ProductModel.fromJson(apiResponse.response?.data);
        }else {
          mostSearchingProduct!.products!.addAll(ProductModel.fromJson(apiResponse.response?.data).products!);
          mostSearchingProduct!.offset = ProductModel.fromJson(apiResponse.response?.data).offset;
          mostSearchingProduct!.totalSize = ProductModel.fromJson(apiResponse.response?.data).totalSize;
        }
      }


    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();


  }

  int currentJustForYouIndex = 0;
  void setCurrentJustForYourIndex(int index){
    currentJustForYouIndex = index;
    notifyListeners();
  }

}


class ProductTypeModel{
  String? title;
  ProductType productType;

  ProductTypeModel(this.title, this.productType);
}