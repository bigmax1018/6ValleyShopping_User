import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/shop_again_from_recent_store_card.dart';
import 'package:provider/provider.dart';

class ShopAgainFromYourRecentStore extends StatelessWidget {

  const ShopAgainFromYourRecentStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, shopAgainProvider,_) {
        return ListView.builder(
          shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: shopAgainProvider.shopAgainFromRecentStoreList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
          return ShopAgainFromRecentStoreCard(shopAgainFromRecentStoreModel: shopAgainProvider.shopAgainFromRecentStoreList[index], index: index,length: shopAgainProvider.shopAgainFromRecentStoreList.length,);
        });
      }
    );
  }
}
