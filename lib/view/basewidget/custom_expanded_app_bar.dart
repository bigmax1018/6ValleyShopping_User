import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:provider/provider.dart';

class CustomExpandedAppBar extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? bottomChild;
  final bool isGuestCheck;
  const CustomExpandedAppBar({Key? key, required this.title, required this.child, this.bottomChild, this.isGuestCheck = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    return Scaffold(
      floatingActionButton: isGuestCheck ? isGuestMode ? null : bottomChild : bottomChild,
      body: Stack(children: [

        // Background
        Image.asset(
          Images.morePageHeader, height: 150, fit: BoxFit.fill, width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Theme.of(context).primaryColor,
        ),

        Positioned(
          top: 40,
          left: Dimensions.paddingSizeSmall,
          right: Dimensions.paddingSizeSmall,
          child: Row(children: [
            CupertinoNavigationBarBackButton(color: Colors.white, onPressed: () {
              Provider.of<SplashProvider>(context, listen: false).setFromSetting(false);
              Navigator.pop(context);
            } ),
            Text(title!, style: titilliumRegular.copyWith(fontSize: 20, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: const EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: isGuestCheck ? isGuestMode ? const NotLoggedInWidget() : child : child,
        ),
      ]),
    );
  }
}
