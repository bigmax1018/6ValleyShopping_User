import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/more_screen.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wishlist_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/loyaltyPoint/loyalty_point_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/offer/offers_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/wallet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

class MoreHorizontalSection extends StatelessWidget {
  const MoreHorizontalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider,_) {
        return SizedBox(height: 130,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
            child: Center(
              child: ListView(scrollDirection:Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(), children: [
                   if(Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme != "theme_fashion")
                    SquareButton(image: Images.offerIcon, title: getTranslated('offers', context),
                      navigateTo: const OffersScreen(),count: 0,hasCount: false,),

                    if(!isGuestMode && Provider.of<SplashProvider>(context,listen: false).configModel!.walletStatus == 1)
                      SquareButton(image: Images.wallet, title: getTranslated('wallet', context),
                          navigateTo: const WalletScreen(),count: 1,hasCount: false,
                          subTitle: 'amount', isWallet: true, balance: Provider.of<ProfileProvider>(context, listen: false).balance),


                    if(!isGuestMode && Provider.of<SplashProvider>(context,listen: false).configModel!.loyaltyPointStatus == 1)
                      SquareButton(image: Images.loyaltyPoint, title: getTranslated('loyalty_point', context),
                        navigateTo: const LoyaltyPointScreen(),count: 1,hasCount: false,isWallet: true,subTitle: 'point',
                        balance: Provider.of<ProfileProvider>(context, listen: false).loyaltyPoint, isLoyalty: true,
                      ),


                    if(!isGuestMode)
                    SquareButton(image: Images.shoppingImage, title: getTranslated('orders', context),
                      navigateTo: const OrderScreen(),count: 1,hasCount: false,isWallet: true,subTitle: 'orders',
                      balance: profileProvider.userInfoModel?.totalOrder??0, isLoyalty: true,
                    ),

                    SquareButton(image: Images.cartImage, title: getTranslated('cart', context),
                      navigateTo: const CartScreen(),
                      count: Provider.of<CartProvider>(context,listen: false).cartList.length, hasCount: true,),

                    SquareButton(image: Images.wishlist, title: getTranslated('wishlist', context),
                      navigateTo: const WishListScreen(),
                      count: Provider.of<AuthProvider>(context, listen: false).isLoggedIn() &&
                          Provider.of<WishListProvider>(context, listen: false).wishList != null &&
                          Provider.of<WishListProvider>(context, listen: false).wishList!.isNotEmpty ?
                      Provider.of<WishListProvider>(context, listen: false).wishList!.length : 0, hasCount: false,),
                  ]),
            ),
          ),
        );
      }
    );
  }
}
