import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';


class MapWidget extends StatefulWidget {
  final AddressModel address;
  const MapWidget({Key? key, required this.address}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  late LatLng _latLng;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    _latLng = LatLng(double.parse(widget.address.latitude!), double.parse(widget.address.longitude!));
    _setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [

        GoogleMap(
          initialCameraPosition: CameraPosition(target: _latLng, zoom: 17),
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          indoorViewEnabled: true,
          markers:_markers,
        ),
        CustomAppBar(title: getTranslated('delivery_address', context)),
        Positioned(
          left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeLarge,
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Colors.grey[300]!, spreadRadius: 3, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(children: [

                  Icon(
                    widget.address.addressType == 'Home' ? Icons.home_outlined : widget.address.addressType == 'Workplace'
                        ? Icons.work_outline : Icons.list_alt_outlined,
                    size: 30, color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                      Text(widget.address.addressType!, style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall, color: ColorResources.getGrey(context),
                      )),

                      Text(widget.address.address!, style: textRegular),

                    ]),
                  ),
                ]),

                Text('- ${widget.address.contactPersonName}', style: textRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeLarge,
                )),

                Text('- ${widget.address.phone}', style: textRegular),

              ],
            ),
          ),
        ),
      ]),
    );
  }

  void _setMarker() async {
    Uint8List destinationImageData = await convertAssetToUnit8List(Images.mapMarker, width: 70);

    _markers = <Marker>{};
    _markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: _latLng,
      icon: BitmapDescriptor.fromBytes(destinationImageData),
    ));

    setState(() {});
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }

}
