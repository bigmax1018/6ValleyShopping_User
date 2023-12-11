import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/remove_address_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/add_new_address_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/inbox_shimmer.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    Provider.of<ProfileProvider>(context, listen: false).initAddressList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('addresses', context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddNewAddressScreen(isBilling: false))),
        backgroundColor: ColorResources.getPrimary(context),
        child: Icon(Icons.add, color: Theme.of(context).highlightColor),
      ),


      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return  !profileProvider.isLoading? profileProvider.shippingAddressList.isNotEmpty ?
          RefreshIndicator(
            onRefresh: () async {
              Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
              await Provider.of<ProfileProvider>(context, listen: false).initAddressList();
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: profileProvider.shippingAddressList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(child: Stack(children: [
                      Padding(padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text('${getTranslated('address', context)} : ${profileProvider.shippingAddressList[index].address}'),
                          subtitle: Row(children: [
                              Text('${getTranslated('city', context)} : ${profileProvider.shippingAddressList[index].city ?? ""}'),
                              const SizedBox(width: Dimensions.paddingSizeDefault),
                              Text('${getTranslated('zip', context)} : ${profileProvider.shippingAddressList[index].zip ?? ""}'),
                            ],
                          ),
                          trailing: InkWell(onTap: (){
                            showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=>  RemoveFromAddressBottomSheet(
                              addressId: profileProvider.shippingAddressList[index].id!, index: index,));

                          },
                              child: const Padding(
                                padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                                child: Icon(Icons.delete_forever, color: Colors.red),
                              )),
                        ),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Provider.of<LocalizationProvider>(context).isLtr? Alignment.topRight: Alignment.topLeft,
                          child: Container(decoration: BoxDecoration(
                              borderRadius: Provider.of<LocalizationProvider>(context).isLtr?
                              const BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5)):
                              const BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(padding: const EdgeInsets.all(7.0),
                              child: Text(profileProvider.shippingAddressList[index].isBilling ==0?
                          getTranslated('shipping', context)!:getTranslated('billing', context)!,
                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Provider.of<ThemeProvider>(context).darkTheme?Colors.white : Theme.of(context).cardColor),),),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ) : const NoInternetOrDataScreen(isNoInternet: false,
            message: 'no_address_found',
            icon: Images.noAddress,): const InboxShimmer();
        },
      ),
    );
  }
}
