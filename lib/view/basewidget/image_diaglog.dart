import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;
  const ImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

          Stack(children: [
              CustomImage(image: imageUrl),
            Align(alignment: Alignment.centerRight,
                child: IconButton(icon: Icon(Icons.cancel, color: Theme.of(context).hintColor,),
                    onPressed: () => Navigator.of(context).pop())),

            ],
          ),

        ],
      ),
    );
  }
}
