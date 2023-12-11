import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:provider/provider.dart';

class ChatItemWidget extends StatefulWidget {
  final Chat? chat;
  final ChatProvider chatProvider;
  const ChatItemWidget({Key? key, this.chat, required this.chatProvider}) : super(key: key);

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  String? baseUrl = '', image = '', call = '', name = '';
  int? id;
  @override
  void initState() {
     baseUrl = widget.chatProvider.userTypeIndex == 0 ?
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl:
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl;

     image = widget.chatProvider.userTypeIndex == 0 ?
    widget.chat!.sellerInfo != null? widget.chat!.sellerInfo?.shops![0].image :'' : widget.chat!.deliveryMan?.image??'';

     call = widget.chatProvider.userTypeIndex == 0 ?
    '' : '${widget.chat!.deliveryMan?.code}${widget.chat!.deliveryMan?.phone}';

     id = widget.chatProvider.userTypeIndex == 0 ?
    widget.chat!.sellerId : widget.chat!.deliveryManId;
     name = widget.chatProvider.userTypeIndex == 0 ?
    widget.chat!.sellerInfo != null ? widget.chat!.sellerInfo!.shops![0].name??'' : 'Shop not found': "${widget.chat!.deliveryMan?.fName??''} ${widget.chat!.deliveryMan?.lName??''}";

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(children: [
        ListTile(leading: Stack(
          children: [
            Container(width: 50,height: 50,decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25),width: .5),
                borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(100),
                    child: CustomImage(image: '$baseUrl/$image', height: 50,width: 50, fit: BoxFit.cover))),

          ],
        ),

          title: Text(name??'', style: titilliumSemiBold),

          subtitle: Text(widget.chat!.message??'', maxLines: 4,overflow: TextOverflow.ellipsis,
              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),

          trailing: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(DateConverter.customTime(DateTime.parse(widget.chat!.createdAt!)),
                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor)),
           if(widget.chat!.unseenMessageCount != null && widget.chat!.unseenMessageCount! > 0)
            CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,
              child: Text('${widget.chat!.unseenMessageCount}', style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall)),),
          ]),
          onTap: (){
          Provider.of<ChatProvider>(context, listen: false).seenMessage( context, id,id,);
          if(name!.trim().isEmpty || name == 'Shop not found' || name!.trim()==''){
            showCustomSnackBar(getTranslated('user_account_was_deleted', context), context);
          }else{
            Navigator.push(Get.context!, MaterialPageRoute(builder: (_) => ChatScreen(id: id, name: name, image: '$baseUrl/$image',
                isDelivery: widget.chatProvider.userTypeIndex == 1, phone: call)));
          }
        }),

        const Divider(height: 1, color: ColorResources.chatIconColor),
      ],
    );
  }
}
