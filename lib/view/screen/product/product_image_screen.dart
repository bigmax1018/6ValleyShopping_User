import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class ProductImageScreen extends StatefulWidget {
  final String? title;
  final List<String>? imageList;
  const ProductImageScreen({Key? key, required this.title, required this.imageList}) : super(key: key);

  @override
  ProductImageScreenState createState() => ProductImageScreenState();
}

class ProductImageScreenState extends State<ProductImageScreen> {
  int? pageIndex;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    pageIndex = Provider.of<ProductDetailsProvider>(context, listen: false).imageSliderIndex;
    _pageController = PageController(initialPage: pageIndex!);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: widget.title),

        Expanded(
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${widget.imageList![index]}'),
                    initialScale: PhotoViewComputedScale.contained,
                    heroAttributes: PhotoViewHeroAttributes(tag: index.toString()),
                  );
                },
                backgroundDecoration: BoxDecoration(color: Theme.of(context).highlightColor),
                itemCount: widget.imageList!.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                pageController: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),

              pageIndex != 0 ? Positioned(
                left: 5, top: 0, bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      if(pageIndex! > 0) {
                        _pageController!.animateToPage(pageIndex!-1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                    child: const Icon(Icons.chevron_left_outlined, size: 40),
                  ),
                ),
              ) : const SizedBox.shrink(),

              pageIndex != widget.imageList!.length-1 ? Positioned(
                right: 5, top: 0, bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      if(pageIndex! < widget.imageList!.length) {
                        _pageController!.animateToPage(pageIndex!+1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                    child: const Icon(Icons.chevron_right_outlined, size: 40),
                  ),
                ),
              ) : const SizedBox.shrink(),
            ],
          ),
        ),

      ]),
    );
  }
}

