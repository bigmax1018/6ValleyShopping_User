import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class IconWithTextRow extends StatelessWidget {
  const IconWithTextRow({
    super.key, required this.text, required this.icon, this.iconColor, this.textColor,
  });

  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color:  Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white : Theme.of(context).primaryColor.withOpacity(.30)),
        const SizedBox(width: Dimensions.marginSizeSmall,),

        Expanded(
          child: Text(maxLines: 2, overflow : TextOverflow.ellipsis,
              text, style: titilliumRegular.copyWith(fontSize: 15, color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color)),
        ),
      ],
    );
  }
}
