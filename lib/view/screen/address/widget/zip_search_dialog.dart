import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/location_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';



class ZipSearchDialog extends StatelessWidget {
  const ZipSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
        builder: (context,locationProvider,_){
      return  locationProvider.restrictedZipList.isNotEmpty?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context, listen: false).darkTheme ? 800 : 400]!,
                  spreadRadius: .5, blurRadius: 12, offset: const Offset(3,5))]

          ),
          child: ListView.builder(
              itemCount: locationProvider.restrictedZipList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx,index){
                return InkWell(
                  onTap: (){
                    if (kDebugMode) {
                      print('you are clicked in ====>${locationProvider.restrictedZipList[index].zipcode}');
                    }
                    locationProvider.setZip(locationProvider.restrictedZipList[index].zipcode!);
                    locationProvider.getDeliveryRestrictedZipBySearch(context, 'xfbdhfdbgdfsbgsdfbgsgbsgfbsgbsfdgbsdgbsdgbsdf');

                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(locationProvider.restrictedZipList[index].zipcode!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(height: Dimensions.paddingSizeSmall,),
                          Divider(height: .5,color: Theme.of(context).hintColor),
                        ],
                      )),
                );

              }),
        ),
      ):const SizedBox.shrink();
    });
  }
}
