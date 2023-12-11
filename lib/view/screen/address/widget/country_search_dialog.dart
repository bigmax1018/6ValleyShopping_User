import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/location_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';



class CountrySearchDialog extends StatelessWidget {
  const CountrySearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
        builder: (context,locationProvider,_){
          return  locationProvider.restrictedCountryList.isNotEmpty?
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
                  itemCount: locationProvider.restrictedCountryList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx,index){
                    return InkWell(
                      onTap: (){
                        locationProvider.setCountry(locationProvider.restrictedCountryList[index]);
                        locationProvider.getDeliveryRestrictedCountryBySearch(context, 'xfbdhfdbgdfsbgsdfbgsgbsgfbsgbsfdgbsdgbsdgbsdf');
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locationProvider.restrictedCountryList[index], style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
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
