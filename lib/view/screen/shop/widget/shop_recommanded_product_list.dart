import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ShopRecommandedProductViewList extends StatefulWidget {
  final ScrollController scrollController;
  final int sellerId;
  const ShopRecommandedProductViewList({Key? key, required this.scrollController, required this.sellerId}) : super(key: key);

  @override
  State<ShopRecommandedProductViewList> createState() => _ShopRecommandedProductViewListState();
}

class _ShopRecommandedProductViewListState extends State<ShopRecommandedProductViewList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          return productProvider.sellerWiseRecommandedProduct != null?
          (productProvider.sellerWiseRecommandedProduct != null && productProvider.sellerWiseRecommandedProduct!.products != null && productProvider.sellerWiseRecommandedProduct!.products!.isNotEmpty)?
          PaginatedListView(scrollController: widget.scrollController,
              onPaginate: (offset) async{
                await productProvider.getSellerProductList(widget.sellerId.toString(), offset!, context);
              },
              totalSize: productProvider.sellerWiseRecommandedProduct?.totalSize,
              offset: productProvider.sellerWiseRecommandedProduct?.offset,
              itemView: MasonryGridView.count(
                itemCount: productProvider.sellerWiseRecommandedProduct?.products?.length,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(productModel: productProvider.sellerWiseRecommandedProduct!.products![index]);
                },
              )) : const SizedBox() : ProductShimmer(isEnabled: productProvider.sellerWiseRecommandedProduct == null, isHomePage: false);
        }
    );
  }
}
