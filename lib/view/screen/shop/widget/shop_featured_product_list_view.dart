import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ShopFeaturedProductViewList extends StatefulWidget {
  final ScrollController scrollController;
  final int sellerId;
  const ShopFeaturedProductViewList({Key? key, required this.scrollController, required this.sellerId}) : super(key: key);

  @override
  State<ShopFeaturedProductViewList> createState() => _ShopFeaturedProductViewListState();
}

class _ShopFeaturedProductViewListState extends State<ShopFeaturedProductViewList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          return productProvider.sellerWiseFeaturedProduct != null?
          (productProvider.sellerWiseFeaturedProduct!.products != null && productProvider.sellerWiseFeaturedProduct!.products!.isNotEmpty)?
          PaginatedListView(scrollController: widget.scrollController,
              onPaginate: (offset) async{
                await productProvider.getSellerProductList(widget.sellerId.toString(), offset!, context);
              },
              totalSize: productProvider.sellerWiseFeaturedProduct?.totalSize,
              offset: productProvider.sellerWiseFeaturedProduct?.offset,
              itemView: MasonryGridView.count(
                itemCount: productProvider.sellerWiseFeaturedProduct?.products?.length,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(productModel: productProvider.sellerWiseFeaturedProduct!.products![index]);
                },
              )): const SizedBox() : ProductShimmer(isEnabled: productProvider.sellerWiseFeaturedProduct == null, isHomePage: false);
        }
    );
  }
}
