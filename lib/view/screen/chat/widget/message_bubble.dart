import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/message_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/image_diaglog.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isMe = message.sentByCustomer == 1;
    String? baseUrl = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl:
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl;
    String? image = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    message.sellerInfo != null? message.sellerInfo?.shops![0].image :'' : message.deliveryMan?.image;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isMe ? const SizedBox.shrink() : Container( width: 40, height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Theme.of(context).primaryColor)),
                child: ClipRRect(borderRadius: BorderRadius.circular(20.0),
                  child: CustomImage(fit: BoxFit.cover, width: 40, height: 40,
                    image: '$baseUrl/$image',
                  ),
                ),
              ),
              if(message.message != null && message.message!.isNotEmpty)
              Flexible(
                child: Container(
                    margin: isMe ?  const EdgeInsets.fromLTRB(70, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 70, 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
                        bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
                        topRight: const Radius.circular(10),),
                      color: isMe ? ColorResources.getImageBg(context) : ColorResources.chattingSenderColor(context)),
                    child: (message.message != null && message.message!.isNotEmpty) ? Text(message.message!,
                        textAlign: TextAlign.justify,
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color : isMe? Colors.white: Theme.of(context).textTheme.bodyLarge?.color)) :
                    const SizedBox.shrink(),
                ),
              ),

            ],
          ),

        if(message.attachment!.isNotEmpty) const SizedBox(height: Dimensions.paddingSizeSmall),
        message.attachment!.isNotEmpty?
        Directionality(textDirection:Provider.of<LocalizationProvider>(context, listen: false).isLtr ? isMe ?
        TextDirection.rtl : TextDirection.ltr : isMe ? TextDirection.ltr : TextDirection.rtl,
          child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1, crossAxisCount: 3,
              mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: Dimensions.paddingSizeSmall),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: message.attachment!.length,
            itemBuilder: (BuildContext context, index) {


              return  InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>  ImageDialog(
                  imageUrl: '${AppConstants.baseUrl}/storage/app/public/chatting/${message.attachment![index]}')),
                child: ClipRRect(borderRadius: BorderRadius.circular(5),
                    child:CustomImage(height: 100, width: 100, fit: BoxFit.cover,
                        image: '${AppConstants.baseUrl}/storage/app/public/chatting/${message.attachment![index]}')),);

            },),
        ):
        const SizedBox.shrink(),
        ],
      ),
    );
  }
}
