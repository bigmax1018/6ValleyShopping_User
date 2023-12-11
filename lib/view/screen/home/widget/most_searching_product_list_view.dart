import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class MostSearchingProductListView extends StatefulWidget {
  const MostSearchingProductListView({Key? key}) : super(key: key);
  @override
  State<MostSearchingProductListView> createState() => _MostSearchingProductListViewState();
}

class _MostSearchingProductListViewState extends State<MostSearchingProductListView> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('your_most_searching', context)),
      body:
      Consumer<ProductProvider>(
        builder: (context, productProvider,_) {
          return (productProvider.mostSearchingProduct != null && productProvider.mostSearchingProduct!.products != null) ? productProvider.mostSearchingProduct!.products!.isNotEmpty ?
          SingleChildScrollView(
            controller: scrollController,
            child: PaginatedListView(
              scrollController: scrollController,
              totalSize: productProvider.mostSearchingProduct!.totalSize,
              offset: (productProvider.mostSearchingProduct != null && productProvider.mostSearchingProduct!.offset != null) ? int.parse(productProvider.mostSearchingProduct!.offset.toString()) : null,
              onPaginate: (int? offset) async {
                await productProvider.getMostSearchingProduct(offset!);
              },

              itemView: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding, vertical: Dimensions.paddingSizeSmall),
                child: MasonryGridView.count(
                  itemCount: productProvider.mostSearchingProduct!.products!.length,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductWidget(productModel: productProvider.mostSearchingProduct!.products![index]);
                  }, crossAxisCount: 2,
                ),
              ),
            ),
          ): const Center(child: NoInternetOrDataScreen(isNoInternet: false)) :
           const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
