import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class RelatedProductView extends StatelessWidget {
  const RelatedProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        return Column(children: [

          prodProvider.relatedProductList != null ? prodProvider.relatedProductList!.isNotEmpty ?
          MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: prodProvider.relatedProductList!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(productModel: prodProvider.relatedProductList![index]);
            },
          ):  Center(child: Text(getTranslated('no_related_product', context)??"")) :
          ProductShimmer(isHomePage: false, isEnabled: Provider.of<ProductProvider>(context).relatedProductList == null),
        ]);
      },
    );
  }
}
