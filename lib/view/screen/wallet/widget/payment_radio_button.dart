import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
enum SingingCharacter { bkash, mercado, sslcommerz}

class PaymentRadioButton extends StatefulWidget {
  const PaymentRadioButton({super.key});

  @override
  State<PaymentRadioButton> createState() => _PaymentRadioButtonState();
}

class _PaymentRadioButtonState extends State<PaymentRadioButton> {
  SingingCharacter? _paymentPartner = SingingCharacter.bkash;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          title: Row(children: [
            Image.asset(Images.bKash, width: 50, height: 50),
              const Text('Bkash'),
              const SizedBox(width: Dimensions.marginSizeSmall),
            ],
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.bkash,
            groupValue: _paymentPartner,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _paymentPartner = value;
              });
            },
          ),
        ),
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          title: Row(children: [
            Image.asset(Images.mercadopago, width: 50, height: 50),
            const Text('Mercado'),
            const SizedBox(width: Dimensions.marginSizeSmall),
          ],
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.mercado,
            groupValue: _paymentPartner,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _paymentPartner = value;
              });
            },
          ),
        ),
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          title: Row(children: [
            Image.asset(Images.sslCommerz, width: 50, height: 50),
            const Text('SSL COMMERZ'),
            const SizedBox(width: Dimensions.marginSizeSmall),
          ],
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.sslcommerz,
            groupValue: _paymentPartner,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _paymentPartner = value;
              });
            },
          ),
        ),
        const SizedBox(height: Dimensions.marginSizeAuthSmall),

      ],
    );
  }
}
