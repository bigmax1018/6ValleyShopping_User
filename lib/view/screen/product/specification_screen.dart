import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpecificationScreen extends StatelessWidget {
  final String specification;
  const SpecificationScreen({Key? key, required this.specification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();


    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: getTranslated('specification', context)),

        Expanded(child: SingleChildScrollView(child: Html(data: specification,

          style: {
            "table": Style(
              backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            ),
            "tr": Style(
              border: const Border(bottom: BorderSide(color: Colors.grey)),
            ),
            "th": Style(
              padding:  HtmlPaddings.all(6),
              backgroundColor: Colors.grey,
            ),
            "td": Style(
              padding: HtmlPaddings.all(6),
              alignment: Alignment.topLeft,
            ),

          },),)),

      ]),
    );
  }
}
