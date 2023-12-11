import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/message_body.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/chat_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/message_bubble.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatefulWidget {
  final int? id;
  final String? name;
  final bool isDelivery;
  final String? image;
  final String? phone;
  const ChatScreen({Key? key,  this.id, required this.name,  this.isDelivery = false,  this.image, this.phone}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool emojiPicker = false;

  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).getMessageList( context, widget.id, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: ()async{
        Provider.of<ChatProvider>(context, listen: false).getMessageList( context, widget.id, 1);
      },
      child: Scaffold(

        appBar: AppBar(backgroundColor: Theme.of(context).cardColor,
          titleSpacing: 0,
          elevation: 1,
          leading: InkWell(onTap: ()=> Navigator.pop(context),
              child: Icon(CupertinoIcons.back, color: Theme.of(context).textTheme.bodyLarge?.color)),
          title: Row(children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.125))
                  ),
                  height: 40, width: 40,child: CustomImage(image: widget.image??'')),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: Text(widget.name??'', style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),),
            ),

          ],),
          actions: widget.isDelivery? [InkWell(
            onTap: ()=> _launchUrl("tel:${widget.phone}"),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.125),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                  height: 35, width: 35,child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Image.asset(Images.callIcon, color: Theme.of(context).primaryColor),
                  )),
            ),
          )]:[],
        ),

        body: Consumer<ChatProvider>(
            builder: (context, chatProvider,child) {
            return Column(children: [


              chatProvider.messageModel != null? (chatProvider.messageModel!.message != null && chatProvider.messageModel!.message!.isNotEmpty)?
              Expanded(
                child:  SingleChildScrollView(controller: scrollController,
                    reverse: true,
                    child: Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: PaginatedListView(
                        reverse: false,
                        scrollController: scrollController,
                        onPaginate: (int? offset) => chatProvider.getMessageList(context,widget.id,offset!),
                        totalSize: chatProvider.messageModel!.totalSize,
                        offset: int.parse(chatProvider.messageModel!.offset!),
                        enabledPagination: chatProvider.messageModel == null,
                        itemView: ListView.builder(
                          itemCount: chatProvider.dateList.length,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return  Column(mainAxisSize: MainAxisSize.min, children: [
                              Padding(padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeExtraSmall,
                                vertical: Dimensions.paddingSizeSmall),
                                child: Text(chatProvider.dateList[index].toString(),
                                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: chatProvider.messageList[index].length,
                                  itemBuilder: (context, subIndex){
                                return MessageBubble(message: chatProvider.messageList[index][subIndex]);
                              })
                            ],);
                          },
                        ),
                      ),
                    )),
              ) : const Expanded(child: NoInternetOrDataScreen(isNoInternet: false)):  const Expanded(child: ChatShimmer()),


              // Bottom TextField

              chatProvider.pickedImageFileStored != null && chatProvider.pickedImageFileStored!.isNotEmpty ?
              Container(height: 90, width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return  Stack(children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(borderRadius: BorderRadius.circular(10),
                              child: SizedBox(height: 80, width: 80,
                                  child: Image.file(File(chatProvider.pickedImageFileStored![index].path), fit: BoxFit.cover)))),


                      Positioned(right: 5,
                          child: InkWell(
                              child: const Icon(Icons.cancel_outlined, color: Colors.red),
                              onTap: () => chatProvider.pickMultipleImage(true,index: index))),
                    ],
                    );},
                  itemCount: chatProvider.pickedImageFileStored!.length,
                ),
              ) : const SizedBox(),
              Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,  0,  Dimensions.paddingSizeDefault,  Dimensions.paddingSizeDefault),
                child: SizedBox(height: 50,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                     Expanded(child: CustomTextField(
                       inputAction: TextInputAction.send,
                      showLabelText: false,
                      prefixIcon: Images.emoji,
                      suffixIcon: Images.attachment,
                      onTap: (){
                         setState(() {
                           emojiPicker = false;
                         });
                      },
                      prefixOnTap: (){
                         setState(() {
                           emojiPicker = !emojiPicker;
                           FocusManager.instance.primaryFocus?.unfocus();
                         });
                      },
                         suffixOnTap: (){
                         chatProvider.pickMultipleImage(false);
                         },
                      controller: _controller,
                      labelText: getTranslated('send_a_message', context),
                      hintText: getTranslated('send_a_message', context))),

                    chatProvider.isSendButtonActive? const Padding(
                      padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                      child: Center(child: CircularProgressIndicator()),
                    ):
                    InkWell(
                      onTap: (){
                        if(_controller.text.isEmpty && chatProvider.pickedImageFileStored!.isEmpty){

                        }else{
                          MessageBody messageBody = MessageBody(id : widget.id,  message: _controller.text);
                          chatProvider.sendMessage(messageBody).then((value){
                            _controller.clear();
                          });
                        }

                      },
                      child: chatProvider.isLoading? const Padding(padding: EdgeInsets.all(8.0),
                        child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),
                      ) : Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                        child: Container(width: 50, height: 50, decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          border: Border.all(width: 2, color: Theme.of(context).hintColor)
                        ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraExtraSmall, Dimensions.paddingSizeExtraExtraSmall, Dimensions.paddingSizeExtraExtraSmall,8),
                            child: Image.asset(Images.send, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white: null),
                          )),),
                      ),
                    ),
                  ],),
                ),
              ),

              if(emojiPicker)
                SizedBox(height: 250,
                  child: EmojiPicker(

                    onBackspacePressed: () {
                      // Do something when the user taps the backspace button (optional)
                      // Set it to null to hide the Backspace-Button
                    },
                    textEditingController: _controller, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      recentTabBehavior: RecentTabBehavior.RECENT,
                      recentsLimit: 28,
                      noRecents: const Text(
                        'No Recents',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ), // Needs to be const Widget
                      loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                ),
            ]);
          }
        ),
      ),
    );
  }
}



Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

