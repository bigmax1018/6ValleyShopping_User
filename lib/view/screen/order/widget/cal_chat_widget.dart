
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CallAndChatWidget extends StatelessWidget {
  final OrderProvider? orderProvider;
  final Orders? orderModel;
  final bool isSeller;
  const CallAndChatWidget({Key? key, this.orderProvider, this.isSeller = false, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? phone = isSeller? orderProvider!.orderDetails![0].seller!.phone : orderModel!.deliveryMan!.phone;
    String? name = isSeller? orderProvider!.orderDetails![0].seller!.shop!.name : '${orderModel!.deliveryMan!.fName!} ${orderModel!.deliveryMan!.lName!}';
    int? id =  isSeller ? orderProvider!.orderDetails![0].seller!.id : orderModel!.deliveryMan!.id;
    return Row(children: [
      InkWell(
        onTap: ()=> _launchUrl("tel:$phone"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: Container(width: 40,height: 40,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.0525),
            border: Border.all(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(50),

          ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Image.asset(Images.callIcon,color: Theme.of(context).colorScheme.onTertiaryContainer)),
        ),
      ),

      InkWell(
        onTap: (){
          Provider.of<ChatProvider>(context, listen: false).setUserTypeIndex(context, 1);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(id: id, name: name)));

          },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: Container(width: 40,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.0525),
            border: Border.all(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(50),

          ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Image.asset(Images.smsIcon,color: Theme.of(context).primaryColor,),),
        ),
      )
    ],);
  }
}
Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}