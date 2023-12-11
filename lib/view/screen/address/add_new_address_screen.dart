import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/restricted_zip_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/location_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/success_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/select_location_screen.dart';
import 'package:geolocator/geolocator.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddNewAddressScreen extends StatefulWidget {
  final bool isEnableUpdate;
  final bool fromCheckout;
  final AddressModel? address;
  final bool? isBilling;
  const AddNewAddressScreen({Key? key, this.isEnableUpdate = false, this.address, this.fromCheckout = false, this.isBilling}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonEmailController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _zipNode = FocusNode();
  GoogleMapController? _controller;
  CameraPosition? _cameraPosition;
  bool _updateAddress = true;
  Address? _address;

  String zip = '',  country = '';

  @override
  void initState() {
    super.initState();
    if(widget.isBilling!){
      _address = Address.billing;
    }else{
      _address = Address.shipping;
    }

    country = 'BD';
    _countryCodeController.text = country;
    Provider.of<LocationProvider>(context, listen: false).initializeAllAddressType(context: context);
    Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    Provider.of<LocationProvider>(context, listen: false).getRestrictedDeliveryCountryList(context);
    Provider.of<LocationProvider>(context, listen: false).getRestrictedDeliveryZipList(context);


    Provider.of<LocationProvider>(context, listen: false).updateAddressStatusMessae(message: '');
    Provider.of<LocationProvider>(context, listen: false).updateErrorMessage(message: '');
    _checkPermission(() => Provider.of<LocationProvider>(context, listen: false).getCurrentLocation(context, true, mapController: _controller),context);
    if (widget.isEnableUpdate && widget.address != null) {
      _updateAddress = false;
      Provider.of<LocationProvider>(context, listen: false).updatePosition(CameraPosition(target: LatLng(double.parse(widget.address!.latitude!), double.parse(widget.address!.longitude!))), true, widget.address!.address, context);
      _contactPersonNameController.text = '${widget.address!.contactPersonName}';
      _contactPersonNumberController.text = '${widget.address!.phone}';
      if (widget.address!.addressType == 'Home') {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(0, false);
      } else if (widget.address!.addressType == 'Workplace') {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(1, false);
      } else {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(2, false);
      }
    }else {
      if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null){
        _contactPersonNameController.text = '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.fName ?? ''}'
            ' ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.lName ?? ''}';
        _contactPersonNumberController.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.phone ?? '';
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.isEnableUpdate ? getTranslated('update_address', context) : getTranslated('add_new_address', context)),
      body: SingleChildScrollView(
        child: Column(children: [
            Consumer<LocationProvider>(
              builder: (context, locationProvider, child) {
                return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [




                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                      child: CustomTextField(
                        prefixIcon: Images.user,
                        labelText: getTranslated('enter_contact_person_name', context),
                        hintText: getTranslated('enter_contact_person_name', context),
                        inputType: TextInputType.name,
                        controller: _contactPersonNameController,
                        focusNode: _nameNode,
                        nextFocus: _numberNode,
                        inputAction: TextInputAction.next,
                        capitalization: TextCapitalization.words,
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefaultAddress),
                    Consumer<AuthProvider>(
                        builder: (context, authProvider,_) {
                          return CustomTextField(
                            labelText: getTranslated('phone', context),
                            hintText: getTranslated('enter_mobile_number', context),
                            controller: _contactPersonNumberController,
                            focusNode: _numberNode,
                            nextFocus: _emailNode,
                            showCodePicker: true,
                            countryDialCode: authProvider.countryDialCode,
                            onCountryChanged: (CountryCode countryCode) {
                              authProvider.countryDialCode = countryCode.dialCode!;
                              authProvider.setCountryCode(countryCode.dialCode!);
                            },
                            isAmount: true,
                            validator: (value)=> ValidateCheck.validateEmptyText(value, "phone_must_be_required"),
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.phone,
                          );
                        }
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefaultAddress),

                    if(!Provider.of<AuthProvider>(context, listen: false).isLoggedIn())
                    CustomTextField(
                      prefixIcon: Images.email,
                      labelText: getTranslated('email', context),
                      hintText: getTranslated('enter_contact_person_email', context),
                      inputType: TextInputType.name,
                      controller: _contactPersonEmailController,
                      focusNode: _emailNode,
                      nextFocus: _addressNode,
                      inputAction: TextInputAction.next,
                      capitalization: TextCapitalization.words,),
                    const SizedBox(height: Dimensions.paddingSizeDefaultAddress),



                      SizedBox(height: MediaQuery.of(context).size.width/2, width: MediaQuery.of(context).size.width,
                        child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          child: Stack(clipBehavior: Clip.none, children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: widget.isEnableUpdate ?
                                LatLng(double.parse(widget.address!.latitude!), double.parse(widget.address!.longitude!)) :
                                LatLng(locationProvider.position.latitude, locationProvider.position.longitude),
                                zoom: 15),
                              onTap: (latLng) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SelectLocationScreen(googleMapController: _controller)));
                              },
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              indoorViewEnabled: true,
                              mapToolbarEnabled: false,
                              onCameraIdle: () {
                                if(_updateAddress) {
                                  locationProvider.updatePosition(_cameraPosition, true, null, context);
                                }else {
                                  _updateAddress = true;
                                }
                              },
                              onCameraMove: ((position) => _cameraPosition = position),
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                                if (!widget.isEnableUpdate && _controller != null) {
                                  Provider.of<LocationProvider>(context, listen: false).getCurrentLocation(context, true, mapController: _controller);
                                }
                              },
                            ),
                            locationProvider.loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme
                                .of(context).primaryColor))) : const SizedBox(),
                            Container(width: MediaQuery.of(context).size.width, alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height,
                                child: Icon(Icons.location_on, size: 40, color: Theme.of(context).primaryColor,)),

                            Positioned(top: 10, right: 0,
                              child: InkWell(onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => SelectLocationScreen(googleMapController: _controller))),
                                child: Container(width: 30, height: 30,
                                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                    color: Colors.white,),
                                  child: Icon(Icons.fullscreen, color: Theme.of(context).primaryColor, size: 20,),
                                ),
                              ),
                            ),
                          ],
                          ),
                        ),
                      ),


                      // for label us
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Text(getTranslated('label_us', context)!,
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.fontSizeLarge),),),

                      SizedBox(height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: locationProvider.addressTypeList.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => locationProvider.updateAddressIndex(index, true),
                            child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeLarge),
                              margin: const EdgeInsets.only(right: 17),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  border: Border.all(color: locationProvider.selectAddressIndex == index ?
                                  Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.125))),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                SizedBox(width: 20, child: Image.asset(locationProvider.addressTypeList[index].icon,color: locationProvider.selectAddressIndex == index ?
                                Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.35))),
                                const SizedBox(width: Dimensions.paddingSizeSmall,),
                                Text(getTranslated(locationProvider.addressTypeList[index].title, context)!,
                                    style: textRegular.copyWith(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),


                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: SizedBox(height: 50,
                          child: Row(children: <Widget>[
                            Row(children: [
                                Radio<Address>(
                                  value: Address.shipping,
                                  groupValue: _address,
                                  onChanged: (Address? value) {
                                    setState(() {
                                      _address = value;
                                    });
                                  },
                                ),
                                Text(getTranslated('shipping_address', context)!),]),


                            Row(children: [
                              Radio<Address>(
                                value: Address.billing,
                                groupValue: _address,
                                onChanged: (Address? value) {
                                  setState(() {
                                    _address = value;
                                  });},
                                ),
                                Text(getTranslated('billing_address', context)!),
                              ],
                          ),
                    ],
                  ),),
                      ),



                      CustomTextField(labelText: getTranslated('delivery_address', context),
                        hintText: getTranslated('usa', context),
                        inputType: TextInputType.streetAddress,
                        inputAction: TextInputAction.next,
                        focusNode: _addressNode,
                        prefixIcon: Images.address,
                        nextFocus: _cityNode,
                        controller: locationProvider.locationController,),
                      const SizedBox(height: Dimensions.paddingSizeDefaultAddress),

                    SizedBox(height: 50,
                      child: Consumer<LocationProvider>(
                          builder: (context, locationProvider, _) {
                            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Provider.of<SplashProvider>(context, listen: false).configModel!.deliveryCountryRestriction == 1?

                              DropdownSearch<String>(
                                popupProps: const PopupProps.menu(
                                    showSelectedItems: true),
                                items: locationProvider.restrictedCountryList,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    prefixIconConstraints: const BoxConstraints(minHeight: 40, maxWidth: 40),
                                    prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                      child: SizedBox(width: 20,height: 20,child: Image.asset(Images.country, color: Theme.of(context).primaryColor.withOpacity(.6),)),),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                    labelText: "country",
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Theme.of(context).hintColor,
                                          width: 0.5,)),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Theme.of(context).hintColor,
                                            width: 0.5)),

                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Theme.of(context).hintColor,
                                            width:0.5)),
                                  ),
                                ),
                                onChanged: (value){
                                  _countryCodeController.text = value!;
                                },

                              ):
                              Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,
                                  vertical: Dimensions.paddingSizeSmall),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25)),
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                                child: Row(children: [
                                    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                      child: SizedBox(width: 20,height: 20,child: Image.asset(Images.country, color: Theme.of(context).primaryColor.withOpacity(.6),)),),
                                    Expanded(
                                      child: CountryPickerDropdown(
                                        initialValue: country,
                                        itemBuilder: _buildDropdownItemForCountry,
                                        onValuePicked: (Country? country) {
                                          _countryCodeController.text = country!.name??'';
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // CountrySearchDialog(),
                            ]);
                          }
                      ),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeDefaultAddress),

                      CustomTextField(
                        labelText: getTranslated('city', context),
                        hintText: getTranslated('city', context),
                        inputType: TextInputType.streetAddress,
                        inputAction: TextInputAction.next,
                        focusNode: _cityNode,
                        nextFocus: _zipNode,
                        prefixIcon: Images.city,
                        controller: _cityController,
                      ),
                    const SizedBox(height: Dimensions.paddingSizeDefaultAddress),


                    Provider.of<SplashProvider>(context, listen: false).configModel!.deliveryZipCodeAreaRestriction == 0?
                    CustomTextField(
                      labelText: getTranslated('zip', context),
                        hintText: getTranslated('zip', context),
                        inputAction: TextInputAction.done,
                        focusNode: _zipNode,
                        prefixIcon: Images.city,
                        controller: _zipCodeController,

                      ):
                      SizedBox(height: 50,
                        child: DropdownSearch<RestrictedZipModel>(
                          items: locationProvider.restrictedZipList,
                          itemAsString: (RestrictedZipModel u) => u.zipcode!,
                          onChanged: (value){
                            _zipCodeController.text = value!.zipcode!;
                          },
                          dropdownDecoratorProps:  DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(labelText: "zip",
                              contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              prefixIconConstraints: const BoxConstraints(minHeight: 40, maxWidth: 40),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                child: SizedBox(width: 20,height: 20,child: Image.asset(Images.city)),
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Theme.of(context).hintColor,
                                    width: 0.5,)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Theme.of(context).hintColor,
                                    width: 0.5)),

                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Theme.of(context).hintColor,
                                    width:0.5)),
                            ),
                          ),

                        ),
                      ),
                    const SizedBox(height: Dimensions.paddingSizeDefaultAddress),




                    Container(height: 50.0,
                        margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: !locationProvider.isLoading ? CustomButton(
                          buttonText: widget.isEnableUpdate ? getTranslated('update_address', context) : getTranslated('save_location', context),
                          onTap: locationProvider.loading ? null : () { AddressModel addressModel = AddressModel(
                            addressType: locationProvider.addressTypeList[locationProvider.selectAddressIndex].title,
                            contactPersonName: _contactPersonNameController.text,
                            phone: '${Provider.of<AuthProvider>(context, listen: false).countryDialCode}${_contactPersonNumberController.text.trim()}',
                            email: _contactPersonEmailController.text.trim(),
                            city: _cityController.text,
                            zip: _zipCodeController.text,
                            country:  _countryCodeController.text,
                            guestId: Provider.of<AuthProvider>(context, listen: false).getGuestToken(),
                            isBilling: _address == Address.billing ? 1:0,
                            address: locationProvider.locationController.text,
                            latitude: widget.isEnableUpdate ? locationProvider.position.latitude.toString() : locationProvider.position.latitude.toString(),
                            longitude: widget.isEnableUpdate ? locationProvider.position.longitude.toString()
                                : locationProvider.position.longitude.toString(),
                          );


                          if (widget.isEnableUpdate) {
                            addressModel.id = widget.address!.id;
                            locationProvider.updateAddress(context, addressModel: addressModel, addressId: addressModel.id).then((value) {});
                          }else if(_contactPersonNameController.text.trim().isEmpty){
                            showCustomSnackBar('${getTranslated('contact_person_name_is_required', context)}', context);
                          }else if(_contactPersonNumberController.text.trim().isEmpty){
                            showCustomSnackBar('${getTranslated('contact_person_phone_is_required', context)}', context);
                          }else if(locationProvider.locationController.text.trim().isEmpty){
                            showCustomSnackBar('${getTranslated('address_is_required', context)}', context);
                          }else if(_cityController.text.trim().isEmpty){
                            showCustomSnackBar('${getTranslated('city_is_required', context)}', context);
                          }else if(_zipCodeController.text.trim().isEmpty){
                            showCustomSnackBar('${getTranslated('zip_code_is_required', context)}', context);
                          }else if(_contactPersonEmailController.text.trim().isEmpty && !Provider.of<AuthProvider>(context, listen: false).isLoggedIn()){
                            showCustomSnackBar('${getTranslated('email_is_required', context)}', context);
                          }
                          else {
                            locationProvider.addAddress(addressModel, context).then((value) {
                              if (value.isSuccess) {
                                Provider.of<ProfileProvider>(context, listen: false).initAddressList();
                                Navigator.pop(context);
                                if (widget.fromCheckout) {
                                  Provider.of<ProfileProvider>(context, listen: false).initAddressList();
                                  Provider.of<OrderProvider>(context, listen: false).setAddressIndex(-1);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message!), duration: const Duration(milliseconds: 600), backgroundColor: Colors.green));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message!), duration: const Duration(milliseconds: 600), backgroundColor: Colors.red));
                              }
                            });
                          }
                          },
                        ) : Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                            )),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  void _checkPermission(Function callback, BuildContext context) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.whileInUse) {
      InkWell(
        onTap: () async{
            Navigator.pop(context);
            await Geolocator.requestPermission();
            if(context.mounted){}
            _checkPermission(callback,  Get.context!);
        },
          child: AlertDialog(content: SuccessDialog(icon: Icons.location_on_outlined, title: '',
              description: getTranslated('you_denied', Get.context!))));
    }else if(permission == LocationPermission.deniedForever) {
      InkWell(
          onTap: () async{
            if(context.mounted){}
              Navigator.pop(context);
              await Geolocator.openAppSettings();
              if(context.mounted){}
              _checkPermission(callback, Get.context!);
          },

          child: AlertDialog(content: SuccessDialog(icon: Icons.location_on_outlined, title: '',

              description: getTranslated('you_denied', Get.context!))));
    }else {
      callback();
    }
  }
}

enum Address {shipping, billing }

Widget _buildDropdownItemForCountry(Country country) => SizedBox(
    width: MediaQuery.of(Get.context!).size.width-116,
    child: Text("${country.name}"));