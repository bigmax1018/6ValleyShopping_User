import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/category.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/category_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/sub_category_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import '../shimmer/category_shimmer.dart';

class SubCategoryView extends StatelessWidget {
  final bool isHomePage;
  final List<SubCategory?>? sub_category;
  const SubCategoryView({Key? key, required this.isHomePage, required this.sub_category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return
        SizedBox( height: 120,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: sub_category!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // if(index != 0) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>
                        BrandAndCategoryProductScreen(
                          isBrand: false,
                          id: sub_category![index]!.id.toString(),
                          name: sub_category![index]!.name,
                          index: index,
                        )));
                  },
                  child: SubCategoryWidget(sub_category: sub_category![index]!,
                      index: index,
                      length: sub_category!.length),
                );
              // }

            },
          ),
        );

      },
    );
  }
}



