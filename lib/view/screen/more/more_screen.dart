import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/logout_confirm_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/all_category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/compare/compare_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/contact_us/contact_us.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/coupon/coupon_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/guest/track_order.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/html_view_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/more_header_section.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/more_horizontal_section.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/notification/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/profile/address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/profile/profile_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/refer_and_earn/refer_and_earn_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/setting/settings_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/support/support_ticket_screen.dart';
import 'package:provider/provider.dart';

import 'faq_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late bool isGuestMode;
  String? version;
  bool singleVendor = false;
  @override
  void initState() {
    isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      version = Provider.of<SplashProvider>(context,listen: false).configModel!.softwareVersion ?? 'version';
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      if(Provider.of<SplashProvider>(context,listen: false).configModel!.walletStatus == 1){
        Provider.of<WalletTransactionProvider>(context, listen: false).getTransactionList(context,1, 'all');
      }
      if(Provider.of<SplashProvider>(context,listen: false).configModel!.loyaltyPointStatus == 1){
        Provider.of<WalletTransactionProvider>(context, listen: false).getLoyaltyPointList(context,1);
      }
    }
    singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode == "single";

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [

          const MoreHeaderSection(),


          Container(decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Center(child: MoreHorizontalSection())),




                    Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,  Dimensions.paddingSizeDefault,  Dimensions.paddingSizeDefault,0),
                      child: Text(getTranslated('general', context)??'',style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).colorScheme.onPrimary), ),),

                    Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                        boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.05), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,1))],
                        color: Provider.of<ThemeProvider>(context).darkTheme ?
                        Colors.white.withOpacity(.05) : Theme.of(context).cardColor),
                        child: Column(children: [


                          TitleButton(image: Images.trackOrderIcon, title: getTranslated('TRACK_ORDER', context),
                              navigateTo: const GuestTrackOrderScreen()),

                        if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn())
                          TitleButton(image: Images.user, title: getTranslated('profile', context),
                              navigateTo: const ProfileScreen()),

                        TitleButton(image: Images.address, title: getTranslated('addresses', context),
                            navigateTo: const AddressListScreen()),

                          TitleButton(image: Images.coupon, title: getTranslated('coupons', context),
                              navigateTo: const CouponList()),

                          if(!isGuestMode)
                            TitleButton(image: Images.refIcon, title: getTranslated('refer_and_earn', context),
                                isProfile: true,
                                navigateTo: const ReferAndEarnScreen()),


                          TitleButton(image: Images.category, title: getTranslated('CATEGORY', context),
                            navigateTo: const AllCategoryScreen()),

                          if(Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme != "default" && Provider.of<AuthProvider>(context, listen: false).isLoggedIn())
                          TitleButton(image: Images.compare, title: getTranslated('compare_products', context),
                              navigateTo: const CompareProductScreen()),

                        TitleButton(image: Images.notification, title: getTranslated('notification', context,),
                            isNotification: true,
                            navigateTo: const NotificationScreen()),

                        TitleButton(image: Images.settings, title: getTranslated('settings', context),
                            navigateTo: const SettingsScreen()),


                      ],),),
                    ),


                    Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,  Dimensions.paddingSizeDefault,  Dimensions.paddingSizeDefault,0),
                      child: Text(getTranslated('help_and_support', context)??'',style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                          color: Theme.of(context).colorScheme.onPrimary)),
                    ),


                    Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                            boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.05), blurRadius: 1, spreadRadius: 1,offset: const Offset(0,1))],
                            color: Provider.of<ThemeProvider>(context).darkTheme ?
                            Colors.white.withOpacity(.05) : Theme.of(context).cardColor),
                        child: Column(children: [

                          singleVendor?const SizedBox():
                          TitleButton(image: Images.chats, title: getTranslated('inbox', context),
                              navigateTo: const InboxScreen()),

                          TitleButton(image: Images.callIcon, title: getTranslated('contact_us', context),
                              navigateTo: const ContactUsScreen()),


                          TitleButton(image: Images.preference, title: getTranslated('support_ticket', context),
                              navigateTo: const SupportTicketScreen()),

                          TitleButton(image: Images.termCondition, title: getTranslated('terms_condition', context),
                              navigateTo: HtmlViewScreen(title: getTranslated('terms_condition', context),
                                url: Provider.of<SplashProvider>(context, listen: false).configModel!.termsConditions,)),

                          TitleButton(image: Images.privacyPolicy, title: getTranslated('privacy_policy', context),
                              navigateTo: HtmlViewScreen(title: getTranslated('privacy_policy', context),
                                url: Provider.of<SplashProvider>(context, listen: false).configModel!.privacyPolicy,)),

                          if(Provider.of<SplashProvider>(context, listen: false).configModel!.refundPolicy!.status ==1)
                            TitleButton(image: Images.termCondition, title: getTranslated('refund_policy', context),
                                navigateTo: HtmlViewScreen(title: getTranslated('refund_policy', context),
                                  url: Provider.of<SplashProvider>(context, listen: false).configModel!.refundPolicy!.content,)),

                          if(Provider.of<SplashProvider>(context, listen: false).configModel!.returnPolicy!.status ==1)
                            TitleButton(image: Images.termCondition, title: getTranslated('return_policy', context),
                                navigateTo: HtmlViewScreen(title: getTranslated('return_policy', context),
                                  url: Provider.of<SplashProvider>(context, listen: false).configModel!.returnPolicy!.content,)),

                          if(Provider.of<SplashProvider>(context, listen: false).configModel!.cancellationPolicy!.status ==1)
                            TitleButton(image: Images.termCondition, title: getTranslated('cancellation_policy', context),
                                navigateTo: HtmlViewScreen(title: getTranslated('cancellation_policy', context),
                                  url: Provider.of<SplashProvider>(context, listen: false).configModel!.cancellationPolicy!.content,)),

                          TitleButton(image: Images.faq, title: getTranslated('faq', context),
                              navigateTo: FaqScreen(title: getTranslated('faq', context),)),

                          TitleButton(image: Images.user, title: getTranslated('about_us', context),
                              navigateTo: HtmlViewScreen(title: getTranslated('about_us', context),
                                url: Provider.of<SplashProvider>(context, listen: false).configModel!.aboutUs,)),



                        ],),),
                    ),

                     ListTile(
                      leading: SizedBox(width: 30, child: Image.asset(Images.logOut, color: Theme.of(context).primaryColor,)),
                      title: Text(isGuestMode? getTranslated('sign_in', context)! : getTranslated('sign_out', context)!,
                          style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                      onTap: (){
                        if(isGuestMode){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                        }else{
                          showModalBottomSheet(backgroundColor: Colors.transparent,
                              context: context, builder: (_)=>  const LogoutCustomBottomSheet());
                        }
                      },
                    ),

                    Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('${getTranslated('version', context)} ${AppConstants.appVersion}',
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor)),],),
                    )



                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String? title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;
  final bool isWallet;
  final double? balance;
  final bool isLoyalty;
  final String? subTitle;

  const SquareButton({Key? key, required this.image,
    required this.title, required this.navigateTo, required this.count,
    required this.hasCount, this.isWallet = false, this.balance, this.subTitle,
     this.isLoyalty = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Padding(padding: const EdgeInsets.all(8.0),
          child: Container(width: 120, height: 90,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Provider.of<ThemeProvider>(context).darkTheme ?
              Theme.of(context).primaryColor.withOpacity(.30) : Theme.of(context).primaryColor),
            child: Stack(children: [
                Positioned(top: -80,left: -10,right: -10,
                  child: Container(height: 120, decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(.07), width: 15),
                  borderRadius: BorderRadius.circular(100)))),


              isWallet?
              Padding(padding: const EdgeInsets.all(8.0),
                child: SizedBox(width: 30, height: 30,child: Image.asset(image, color: Colors.white)),
              ):

              Center(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                    child: Image.asset(image, color: ColorResources.white))),

                if(isWallet)
                  Positioned(right: 10,bottom: 10,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text(getTranslated(subTitle, context)??'', style: textRegular.copyWith(color: Colors.white),),
                      isLoyalty? Text(balance != null? balance!.toStringAsFixed(0) : '0',
                        style: textMedium.copyWith(color: Colors.white)):
                      Text(balance != null? PriceConverter.convertPrice(context, balance):'0',
                        style: textMedium.copyWith(color: Colors.white)),
                    ],),
                  ),

                hasCount?
                Positioned(top: 5, right: 5,
                  child: Consumer<CartProvider>(builder: (context, cart, child) {
                    return CircleAvatar(radius: 10, backgroundColor: ColorResources.red,
                      child: Text(count.toString(),
                          style: titilliumSemiBold.copyWith(color: Theme.of(context).cardColor,
                            fontSize: Dimensions.fontSizeExtraSmall,
                          )),
                    );
                  }),
                ):const SizedBox(),
              ],
            ),
          ),
        ),
        Text(title??'', maxLines: 1,overflow: TextOverflow.clip,
            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color)),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String? title;
  final Widget navigateTo;
  final bool isNotification;
  final bool isProfile;
  const TitleButton({Key? key, required this.image, required this.title, required this.navigateTo,  this.isNotification = false, this.isProfile = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: isNotification? Consumer<NotificationProvider>(
        builder: (context, notificationProvider, _) {
          return CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,
            child: Text(notificationProvider.notificationModel?.newNotificationItem.toString() ?? '0',
                style: textRegular.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeSmall,
                )),
          );
        }
      ): isProfile? Consumer<ProfileProvider>(
          builder: (context, profileProvider, _) {
            return CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,
              child: Text(profileProvider.userInfoModel?.referCount.toString() ?? '0',
                  style: textRegular.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeSmall,
                  )),
            );
          }
      ): const SizedBox(),
      leading: Image.asset(image, width: 25, height: 25, fit: BoxFit.fill, color: Theme.of(context).primaryColor.withOpacity(.6),),
      title: Text(title!, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
      onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (_) => navigateTo),
      ),
    );
  }
}

