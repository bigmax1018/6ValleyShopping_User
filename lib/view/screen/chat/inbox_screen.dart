import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/chat_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/chat_type_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/inbox_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/search_inbox_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';


class InboxScreen extends StatefulWidget {
  final bool isBackButtonExist;
  const InboxScreen({Key? key, this.isBackButtonExist = true}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {

  TextEditingController searchController = TextEditingController();

  late bool isGuestMode;
  @override
  void initState() {

    isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      if(!isGuestMode) {
        Provider.of<ChatProvider>(context, listen: false).getChatList(context, 1, reload: false);
      }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(Navigator.of(context).canPop()){
          Navigator.of(context).pop();
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));

        }

        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: getTranslated('inbox', context), isBackButtonExist: widget.isBackButtonExist,
        onBackPressed: (){
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));

          }
        },),
        body: Column(children: [
          if(!isGuestMode)
          Consumer<ChatProvider>(
            builder: (context, chat, _) {
              return Padding(padding: const EdgeInsets.fromLTRB( Dimensions.homePagePadding, Dimensions.paddingSizeSmall, Dimensions.homePagePadding, 0),
                child: SearchInboxWidget(
                  hintText: getTranslated('search', context),
                ));
            }
          ),

            if(!isGuestMode)
          Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
            child: Row(children: [
              ChatTypeButton(text: getTranslated('seller', context), index: 0),
              ChatTypeButton(text: getTranslated('delivery-man', context), index: 1)])),

          Expanded(
              child: isGuestMode ? const NotLoggedInWidget() :  RefreshIndicator(
                onRefresh: () async {
                  searchController.clear();
                  await Provider.of<ChatProvider>(context, listen: false).getChatList(context, 1);
                },
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    return chatProvider.chatModel != null? (chatProvider.chatModel!.chat != null && chatProvider.chatModel!.chat!.isNotEmpty )?
                    ListView.builder(
                      itemCount: chatProvider.chatModel?.chat?.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return ChatItemWidget(chat: chatProvider.chatModel!.chat![index], chatProvider: chatProvider);
                      },
                    ) : const NoInternetOrDataScreen(isNoInternet: false, message: 'no_conversion', icon: Images.noInbox,): const InboxShimmer();
                  },
                ),
              ),
            ),
        ]),
      ),
    );
  }
}



