import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/search_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_filter_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/widget/search_filter_bottom_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SearchProductWidget extends StatefulWidget {

  const SearchProductWidget({Key? key, }) : super(key: key);

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Consumer<SearchProvider>(
        builder: (context, searchProductProvider,_) {
          return Column(children: [

              Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(children: [
                  Expanded(child: Text('${getTranslated('product_list', context)}',style: robotoBold,)),


                  InkWell(onTap: () => showModalBottomSheet(context: context,
                      isScrollControlled: true, backgroundColor: Colors.transparent,
                      builder: (c) => const SearchFilterBottomSheet()),
                    child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                        horizontal: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                      child: SizedBox(width: 25,height: 24,child: Image.asset(Images.sort, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white:Theme.of(context).primaryColor)),
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),

                  InkWell(onTap: () => showModalBottomSheet(context: context,

                      isScrollControlled: true, backgroundColor: Colors.transparent,
                      builder: (c) =>  const ProductFilterDialog(fromShop: false,)),

                    child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                        horizontal: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                      child: SizedBox(width: 25,height: 24, child: Image.asset(Images.dropdown, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white:Theme.of(context).primaryColor)),
                    ),
                  ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),


              SingleChildScrollView(
                controller: scrollController,
                child: PaginatedListView(scrollController: scrollController,
                    onPaginate: (offset) async{
                  await searchProductProvider.searchProduct(query: searchProductProvider.searchController.text, offset: offset!);
                    },
                    totalSize: searchProductProvider.searchedProduct?.totalSize,
                    offset: searchProductProvider.searchedProduct?.offset,
                    itemView: MasonryGridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      itemCount: searchProductProvider.searchedProduct!.products!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(productModel: searchProductProvider.searchedProduct!.products![index]);},
                    )),
              ),
            ],
          );
        }
      ),
    );
  }
}
