import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wishlist_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_logged_in_bottom_sheet.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;

  final int? productId;
  const FavouriteButton({Key? key, this.backgroundColor = Colors.black, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();


    return Consumer<WishListProvider>(
      builder: (context, wishProvider,_) {
        return GestureDetector(
          onTap: () {
            if (isGuestMode) {
             showModalBottomSheet(backgroundColor: Colors.transparent,
                 context: context, builder: (_)=> const NotLoggedInBottomSheet());
            } else {
              wishProvider.addedIntoWish.contains(productId)?
              wishProvider.removeWishList(productId,) :
              wishProvider.addWishList(productId);
            }
          },
          child: Container(width: 40, height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.125), spreadRadius: 1, blurRadius: 1, offset: const Offset(0,0))]
            ),
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Icon( wishProvider.addedIntoWish.contains(productId) ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: wishProvider.addedIntoWish.contains(productId) ? const Color(0xFFFF5050): Theme.of(context).primaryColor, size: 25),
            ),
          ),
        );
      }
    );
  }
}
