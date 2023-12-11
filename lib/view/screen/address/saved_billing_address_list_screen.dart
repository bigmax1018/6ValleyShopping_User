import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/widget/address_list_screen.dart';
import 'package:provider/provider.dart';

import 'add_new_address_screen.dart';
class SavedBillingAddressListScreen extends StatefulWidget {
  const SavedBillingAddressListScreen({Key? key}) : super(key: key);

  @override
  State<SavedBillingAddressListScreen> createState() => _SavedBillingAddressListScreenState();
}

class _SavedBillingAddressListScreenState extends State<SavedBillingAddressListScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AddNewAddressScreen(isBilling: true))),
        backgroundColor: ColorResources.getPrimary(context),
        child: Icon(Icons.add, color: Theme.of(context).highlightColor)),

      appBar: CustomAppBar(title: getTranslated('BILLING_ADDRESS_LIST', context),),

      body: SafeArea(child: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return SingleChildScrollView(
            child: Column(children: [
               profile.billingAddressList.isNotEmpty ?  SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profile.billingAddressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {Provider.of<OrderProvider>(context, listen: false).setBillingAddressIndex(index);
                        Navigator.pop(context);
                        },
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: Container(
                            margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.getIconBg(context),
                              border: index == Provider.of<OrderProvider>(context).billingAddressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                            ),
                            child: AddressListPage(address: profile.billingAddressList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                )  :  Padding(
                 padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                 child: Center(
                   child: Container(
                       alignment: Alignment.center,
                       margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
                       child: const NoInternetOrDataScreen(isNoInternet: false,
                         message: 'no_address_found',
                         icon: Images.noAddress,)
                   ),
                 ),
               ),
              ],
            ),
          );
        },
      )),
    );
  }
}
