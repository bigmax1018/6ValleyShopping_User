import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/carousel_options.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_slider/custom_slider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/transaction_filter_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/aster_theme_home_page.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/wallet_bonus_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/transaction_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/wallet_card_widget.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';


class WalletScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const WalletScreen({Key? key, this.isBacButtonExist = true}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final tooltipController = JustTheController();
  final TextEditingController inputAmountController = TextEditingController();
  final FocusNode focusNode = FocusNode();


  final ScrollController scrollController = ScrollController();
  bool darkMode = Provider.of<ThemeProvider>(Get.context!, listen: false).darkTheme;
  bool isGuestMode = !Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn();

  @override
  void initState() {
    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      Provider.of<WalletTransactionProvider>(context, listen: false).getWalletBonusBannerList();
      Provider.of<WalletTransactionProvider>(context, listen: false).setSelectedFilterType('All Transaction', 0, reload: false);

    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomInset: false,
        body: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            Provider.of<WalletTransactionProvider>(context, listen: false).getTransactionList(context,1, "all", reload: true);
          },
          child: CustomScrollView(
            controller: scrollController, slivers: [
              SliverAppBar(floating: true,
                pinned: true,
                iconTheme:  IconThemeData(color: ColorResources.getTextTitle(context)),
                backgroundColor: Theme.of(context).cardColor,
                title: Text(getTranslated('wallet', context)!,style: TextStyle(color: ColorResources.getTextTitle(context)),),),

            SliverToBoxAdapter(
              child: Column(children: [

                isGuestMode ? const NotLoggedInWidget() :
                Column(children: [
                  Consumer<WalletTransactionProvider>(
                      builder: (context, walletP,_) {
                        return Padding(
                          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                          child: Container(height: MediaQuery.of(context).size.width/3.0,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).cardColor : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                              boxShadow: [BoxShadow(color: Colors.grey[darkMode ? 900 : 200]!,
                                  spreadRadius: 0.5, blurRadius: 0.3)],
                            ),
                            child: WalletCardWidget(tooltipController: tooltipController, focusNode: focusNode, inputAmountController: inputAmountController),
                          ),
                        );
                      }
                  ),



                  Padding(padding: const EdgeInsets.only(top : Dimensions.paddingSizeSmall, bottom: 50),
                    child: Consumer<WalletTransactionProvider>(
                        builder: (context, walletProvider, _) {
                          return walletProvider.walletBonusModel != null ? (walletProvider.walletBonusModel!.bonusList != null && walletProvider.walletBonusModel!.bonusList!.isNotEmpty)?
                          Stack(clipBehavior: Clip.none, children: [
                            ClipRRect(borderRadius: BorderRadius.circular(8),
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  aspectRatio: 2,
                                  autoPlay: true,
                                  padEnds: false,
                                  onPageChanged: (index, reason) {
                                    walletProvider.setCurrentIndex(index);
                                  },
                                ),
                                itemCount: walletProvider.walletBonusModel?.bonusList?.length,
                                itemBuilder: (context, index, _) {

                                  return Stack(children: [
                                    Align(alignment: Alignment.centerRight,
                                        child: Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
                                            child: Image.asset(Images.walletBonus))),
                                    Container(width: double.infinity,
                                      margin: const EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                          border: Border.all(width: .75, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor.withOpacity(.5))
                                      ),
                                      child:  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment:
                                        CrossAxisAlignment.start, children: [

                                          Text('${walletProvider.walletBonusModel?.bonusList?[index].title}', style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                              color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor)),
                                          if(walletProvider.walletBonusModel!.bonusList![index].endDateTime != null)
                                            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                              child: Text('${getTranslated('valid_till', context)} ${DateConverter.dateFormatForWalletBonus(walletProvider.walletBonusModel!.bonusList![index].endDateTime!)}', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                                            ),


                                          walletProvider.walletBonusModel!.bonusList![index].bonusType == 'fixed'?
                                          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                            child: Text('${getTranslated('add_fund_to_wallet', context)} ${PriceConverter.convertPrice(context, walletProvider.walletBonusModel!.bonusList![index].minAddMoneyAmount)} ${getTranslated('and', context)} ${getTranslated('enjoy', context)} ${PriceConverter.convertPrice(context, walletProvider.walletBonusModel!.bonusList![index].bonusAmount)} ${getTranslated('bonus', context)}'),):
                                          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                            child: Text('${getTranslated('add_fund_to_wallet', context)} ${PriceConverter.convertPrice(context, walletProvider.walletBonusModel!.bonusList![index].minAddMoneyAmount)} ${getTranslated('and', context)} ${getTranslated('enjoy', context)} ${walletProvider.walletBonusModel!.bonusList![index].bonusAmount}% ${getTranslated('bonus', context)}'),),



                                          Text('${walletProvider.walletBonusModel?.bonusList?[index].description}', maxLines: 2,overflow: TextOverflow.ellipsis,
                                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                          color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor)),
                                        ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  );
                                },
                              ),
                            ),


                            Positioned(bottom: -45, right: 0, left: 0,
                              child: Center(
                                child: SizedBox(height: 50,
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: walletProvider.walletBonusModel?.bonusList?.length,
                                      itemBuilder: (context, index){
                                        return Container(width: index == walletProvider.currentIndex ? Dimensions.radiusDefault : Dimensions.radiusSmall,
                                          height: index == walletProvider.currentIndex ? Dimensions.radiusDefault : Dimensions.radiusSmall,
                                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
                                          decoration: BoxDecoration(shape: BoxShape.circle,
                                            color: (index == walletProvider.currentIndex ? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                          ):const SizedBox():const WalletBonusListShimmer();
                        }
                    ),
                  ),



                ]),
              ],
              ),
            ),

             SliverPersistentHeader(pinned: true,delegate: SliverDelegate(child: Container(
               color: Theme.of(context).scaffoldBackgroundColor,
               child: Column(children: [
                 const SizedBox(height: Dimensions.paddingSizeLarge,),
                 Consumer<WalletTransactionProvider>(
                   builder: (context, transactionProvider, child) {
                     return Padding(padding: const EdgeInsets.only(left: Dimensions.homePagePadding,right: Dimensions.homePagePadding),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                         Text('${getTranslated('wallet_history', context)}',
                           style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

                         InkWell(onTap: ()=> showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=> const TransactionFilterBottomSheet()),
                           child: Container(width: MediaQuery.of(context).size.width * .5, height: 35,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                   color: Theme.of(context).cardColor, border: Border.all(color: Colors.grey)),
                               child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                 child: Row(children: [
                                   Expanded(child: Text('${getTranslated(transactionProvider.selectedFilterType, context)}', maxLines: 1,overflow: TextOverflow.ellipsis)),
                                   const Icon(Icons.arrow_drop_down)

                                 ],),
                               )
                           ),
                         ),

                       ],
                       ),
                     );
                   }
                 ),
               ],),
             ),
               height: 60,

             )),
              SliverToBoxAdapter(
                child: Column(children: [

                    isGuestMode ? const NotLoggedInWidget() :
                    TransactionListView(scrollController: scrollController)
                  ],
                ),
              )
            ],
          ),
        )

    );
  }
}






