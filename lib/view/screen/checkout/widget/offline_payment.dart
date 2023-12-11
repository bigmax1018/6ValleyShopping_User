import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';

class OfflinePaymentDialog extends StatelessWidget {
  final double rotateAngle;
  final Function()? onTap;
  final TextEditingController? paymentBy;
  final TextEditingController? transactionId;
  final TextEditingController? paymentNote;
  const OfflinePaymentDialog({Key? key,  this.rotateAngle = 0,  required this.onTap, this.paymentBy, this.transactionId, this.paymentNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated('offline_payment', context)!, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                      child: const SizedBox(child: Icon(Icons.clear),)),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
              Text(getTranslated('payment_by', context)!, style: textRegular,),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              CustomTextField(controller: paymentBy,
                inputAction: TextInputAction.next,),

              const SizedBox(height: Dimensions.paddingSizeDefault,),
              Text(getTranslated('transaction_id', context)!, style: textRegular,),
              const SizedBox(height: Dimensions.paddingSizeSmall,),

              CustomTextField(controller: transactionId,
                inputAction: TextInputAction.next,),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              Text(getTranslated('payment_note', context)!, style: textRegular,),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              CustomTextField(
                controller: paymentNote,
                inputAction: TextInputAction.done,
              ),

              const SizedBox(height: Dimensions.paddingSizeExtraLarge),

              Row(children: [
                Expanded(child: CustomButton(buttonText: getTranslated('cancel', context),
                backgroundColor: Theme.of(context).hintColor,
                onTap: ()=> Navigator.of(context).pop())),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(child: CustomButton(buttonText: getTranslated('submit', context),
                  onTap: onTap
                )),
              ],)

              ]
        ),
      ),
    );
  }
}
