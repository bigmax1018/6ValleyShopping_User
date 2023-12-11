import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_details_screen.dart';
import 'package:provider/provider.dart';

class GuestTrackOrderScreen extends StatefulWidget {
  const GuestTrackOrderScreen({Key? key}) : super(key: key);

  @override
  State<GuestTrackOrderScreen> createState() => _GuestTrackOrderScreenState();
}

class _GuestTrackOrderScreenState extends State<GuestTrackOrderScreen> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('TRACK_ORDER', context)),
      body: Consumer<OrderProvider>(
        builder: (context, orderTrackingProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ListView(children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomTextField(controller: orderIdController,
                prefixIcon: Images.orderIdIcon,
                isAmount: true,
                inputType: TextInputType.phone,
                hintText: getTranslated('order_id', context),
                labelText: getTranslated('order_id', context),),
              const SizedBox(height: Dimensions.paddingSizeDefault),


              CustomTextField(
                isAmount: true,
                inputType: TextInputType.phone,
                prefixIcon: Images.callIcon,
                controller: phoneNumberController,
                inputAction: TextInputAction.done,
                hintText: '123 1235 123',
                labelText: '${getTranslated('phone_number', context)}',),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),


              orderTrackingProvider.searching? const Center(child: CircularProgressIndicator()):
              CustomButton(buttonText: '${getTranslated('search_order', context)}', onTap: () async {
                String orderId = orderIdController.text.trim();
                String phone = phoneNumberController.text.trim();
                if(orderId.isEmpty){
                  showCustomSnackBar('${getTranslated('order_id_is_required', context)}', context);
                }else if(phone.isEmpty){
                  showCustomSnackBar('${getTranslated('phone_number_is_required', context)}', context);
                }else{
                  await Provider.of<OrderProvider>(Get.context!, listen: false).trackYourOrder(orderId: orderId.toString(), phoneNumber: phone).then((value) {
                    if(value.response?.statusCode == 200){
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(fromTrack: true,
                         orderId: int.parse(orderIdController.text.trim()), phone: phone)));
                    }
                  });

                }
              },),

            ],),
          );
        }
      )
    );
  }
}
