import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';

class HtmlViewScreen extends StatelessWidget {
  final String? title;
  final String? url;
  const HtmlViewScreen({Key? key, required this.url, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          CustomAppBar(title: title),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              physics: const BouncingScrollPhysics(),
              child: Html(
                style: {
                  'html': Style(textAlign: TextAlign.justify)
                },
                data: url,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
