import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_logged_in_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class MoreHeaderSection extends StatelessWidget {
  const MoreHeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    return Consumer<ProfileProvider>(
        builder: (context,profile,_) {
          return Container(decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).darkTheme ?
              Theme.of(context).primaryColor.withOpacity(.30) : Theme.of(context).primaryColor),
            child: Stack(children: [
              Container(transform: Matrix4.translationValues(-10, 0, 0),
                child: Padding(padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(width: 110, child: Image.asset(Images.shadow, opacity: const AlwaysStoppedAnimation(0.75))))),

              Positioned(right: -110,bottom: -100,
                child: Container(width: 200,height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Theme.of(context).cardColor.withOpacity(.05), width: 25)))),

              Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 70.0,Dimensions.paddingSizeDefault, 30),
                child: Row(children: [
                  InkWell(
                    onTap: () {
                      if(isGuestMode) {
                        showModalBottomSheet(backgroundColor: Colors.transparent,context:context, builder: (_)=> const NotLoggedInBottomSheet());
                      }else {
                        if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel != null) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
                        }
                      }
                    },
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                        child: Container(width: 70,height: 70,  decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle,),
                          child: Provider.of<AuthProvider>(context, listen: false).isLoggedIn()?
                          CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.customerImageUrl}/'
                              '${profile.userInfoModel?.image}', width: 70,height: 70,fit: BoxFit.cover,placeholder: Images.guestProfile):
                          Image.asset(Images.guestProfile),)),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(!isGuestMode?
                    '${profile.userInfoModel?.fName??''} ${profile.userInfoModel?.lName??''}' : 'Guest',
                        style: textMedium.copyWith(color: ColorResources.white)),

                    if(!isGuestMode)
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    if(!isGuestMode)
                    Text(profile.userInfoModel?.phone??'', style: textRegular.copyWith(color: ColorResources.white)),
                  ],)),

                  InkWell(onTap: ()=> Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(width: 40, child: Image.asset(Provider.of<ThemeProvider>(context).darkTheme ?  Images.sunnyDay: Images.theme, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white: null)),
                    ),
                  ),
                ],),
              ),
            ],
            ),);
        });
  }
}
