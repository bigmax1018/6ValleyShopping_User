
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

class CustomSearchTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool suffix;
  final Color? fillColor;

  const CustomSearchTextField(
      {Key? key, this.hintText = 'Write something...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSubmit,
        this.onChanged,
        this.prefixIcon,
        this.suffixIcon,
        this.suffix = false,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.fillColor,
      }) : super(key: key);

  @override
  CustomSearchTextFieldState createState() => CustomSearchTextFieldState();
}

class CustomSearchTextFieldState extends State<CustomSearchTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5), width: 1),
        ),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 0.5)
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        hintStyle: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
        filled: true,
        prefixIcon: widget.prefixIcon != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: Image.asset(widget.prefixIcon!, height: 20, width: 20),
        ) : null,

        suffixIcon: widget.suffix? Container(width:Dimensions.iconSizeSmall, height: Dimensions.iconSizeSmall,
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Image.asset(widget.suffixIcon!, scale: 4,color: Theme.of(context).primaryColor,)) :widget.isPassword ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
          onPressed: _toggle,
        ) : null,
      ),
      onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged as void Function(String)?,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}