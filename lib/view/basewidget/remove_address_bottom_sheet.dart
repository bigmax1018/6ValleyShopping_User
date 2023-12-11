import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:provider/provider.dart';

class RemoveFromAddressBottomSheet extends StatelessWidget {
  final int addressId;
  final int index;
  const RemoveFromAddressBottomSheet({Key? key, required this.addressId, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,

          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40,height: 5,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(20)
        ),),
        const SizedBox(height: 40,),

        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: SizedBox(width: 60,child: Image.asset(Images.removeAddress)),),

        const SizedBox(height: Dimensions.paddingSizeDefault,),
        Text(getTranslated('remove_this_address', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
          child: Text('${getTranslated('address_will_remove', context)}'),),

        const SizedBox(height: Dimensions.paddingSizeSmall),

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('cancel', context)}',
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.5),
              textColor: Theme.of(context).textTheme.bodyLarge?.color,
              onTap: ()=> Navigator.pop(context),)),
            const SizedBox(width: Dimensions.paddingSizeDefault,),
            SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('remove', context)}',
                backgroundColor: Theme.of(context).colorScheme.error,
                onTap: (){
                  Provider.of<ProfileProvider>(context, listen: false).removeAddressById(addressId, index, context);
                  Navigator.of(context).pop();
                }))
          ],),
        )

      ],),
    );
  }
}
