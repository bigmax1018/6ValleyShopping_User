import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/support_ticket_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/image_diaglog.dart';
import 'package:provider/provider.dart';

class SupportConversationScreen extends StatelessWidget {
  final SupportTicketModel supportTicketModel;
  SupportConversationScreen({Key? key, required this.supportTicketModel}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<SupportTicketProvider>(context, listen: false).getSupportTicketReplyList(context, supportTicketModel.id);
    }

    return Scaffold(
      appBar: CustomAppBar(title: supportTicketModel.subject,),
      body: Consumer<SupportTicketProvider>(
        builder: (context, support, child) {
          return Column(children: [

            Expanded(child: Consumer<SupportTicketProvider>(builder: (context, support, child) {
              return support.supportReplyList != null ?
              ListView.builder(
                itemCount: support.supportReplyList!.length,
                reverse: true,
                itemBuilder: (context, index) {
                  bool isMe = (support.supportReplyList![index].adminId !=  '1' || support.supportReplyList![index].customerMessage != null);
                  String? message = isMe ? support.supportReplyList![index].customerMessage : support.supportReplyList![index].adminMessage;
                  String dateTime = DateConverter.localDateToIsoStringAMPM(DateTime.parse(support.supportReplyList![index].createdAt!));

                  return Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start, children: [
                      Container(
                        margin: isMe ?  const EdgeInsets.fromLTRB(50, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 50, 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10),
                          bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
                          bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
                          topRight: const Radius.circular(10),
                        ), color: isMe ? Theme.of(context).primaryColor.withOpacity(.1) : Theme.of(context).highlightColor,
                        ),
                        child: Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min, children: [
                          Text(dateTime, style: titilliumRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall, color: ColorResources.getHint(context),)),


                          message != null ?
                          Text(message, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)) : const SizedBox.shrink(),

                        ]),
                      ),
                      if(support.supportReplyList![index].attachment != null && support.supportReplyList![index].attachment!.isNotEmpty) const SizedBox(height: Dimensions.paddingSizeSmall),
                      support.supportReplyList!.isNotEmpty?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: Directionality(textDirection:Provider.of<LocalizationProvider>(context, listen: false).isLtr ? isMe ?
                        TextDirection.rtl : TextDirection.ltr : isMe ? TextDirection.ltr : TextDirection.rtl,
                          child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1, crossAxisCount: 3,
                              mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: Dimensions.paddingSizeSmall),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: support.supportReplyList?[index].attachment?.length,
                            itemBuilder: (BuildContext context, attachmentIndex) {


                              return  InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>  ImageDialog(
                                  imageUrl: '${AppConstants.baseUrl}/storage/app/public/support-ticket/${support.supportReplyList![index].attachment?[attachmentIndex]}')),
                                child: ClipRRect(borderRadius: BorderRadius.circular(5),
                                    child:CustomImage(height: 100, width: 100, fit: BoxFit.cover,
                                        image: '${AppConstants.baseUrl}/storage/app/public/support-ticket/${support.supportReplyList![index].attachment?[attachmentIndex]}')),);

                            },),
                        ),
                      ):
                      const SizedBox.shrink(),
                    ],
                  );
                },
              ) : const Center(child: CircularProgressIndicator());
            })),




            support.pickedImageFileStored.isNotEmpty ?
            Container(height: 90, width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return  Stack(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ClipRRect(borderRadius: BorderRadius.circular(10),
                            child: SizedBox(height: 80, width: 80,
                                child: Image.file(File(support.pickedImageFileStored[index].path), fit: BoxFit.cover)))),


                    Positioned(right: 5,
                        child: InkWell(
                            child: const Icon(Icons.cancel_outlined, color: Colors.red),
                            onTap: () => support.pickMultipleImage(true,index: index))),
                  ],
                  );},
                itemCount: support.pickedImageFileStored.length,
              ),
            ) : const SizedBox(),
            SizedBox(height: 60,
              child: Card(color: Theme.of(context).highlightColor,
                shadowColor: Colors.grey[200],
                elevation: 2,
                margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(children: [
                    Expanded(child: TextField(
                      controller: _controller,
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: 'Type here...',
                          hintStyle: titilliumRegular.copyWith(color: ColorResources.hintTextColor),
                          border: InputBorder.none,
                          suffixIcon: InkWell(onTap: ()=> support.pickMultipleImage(false),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(Images.attachment),
                            ),
                          )
                        ),
                      ),
                    ),
                    InkWell(onTap: () {

                        if(_controller.text.isEmpty && support.pickedImageFileStored.isEmpty ){

                        }else{
                          support.sendReply(supportTicketModel.id, _controller.text);
                          _controller.text = '';
                        }
                      },
                      child: Icon(Icons.send, color: Theme.of(context).primaryColor, size: Dimensions.iconSizeDefault,),
                    ),
                  ]),
                ),
              ),
            ),

          ]);
        }
      ),
    );
  }
}
