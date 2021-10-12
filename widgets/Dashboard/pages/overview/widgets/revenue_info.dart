import 'package:flutter/material.dart';
import '/utils/paleta_cores.dart';

class RevenueInfoDash extends StatelessWidget {
  final String? title;
  final String? amount;

  const RevenueInfoDash({Key? key, this.title, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: '$title \n\n',
                style:
                    TextStyle(color: PaletaCores.corLightGrey, fontSize: 16)),
            TextSpan(
                text: '\$ $amount',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
