import 'package:flutter/material.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/pages/overview/widgets/bar_chart_dash.dart';
import 'revenue_info.dart';

import '/utils/paleta_cores.dart';

class RevenueSectionSmallDash extends StatelessWidget {
  const RevenueSectionSmallDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              color: PaletaCores.corLightGrey.withOpacity(.1),
              blurRadius: 12,
            ),
          ],
          border: Border.all(color: PaletaCores.corLightGrey, width: .5)),
      child: Column(
        children: [
          Container(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                    text: "Tabela de Controle",
                    size: 20,
                    weight: FontWeight.bold,
                    color: PaletaCores.corLightGrey),
                Container(
                  width: 600,
                  height: 200,
                  child: SimpleBarChart.withSampleData(),
                ),
              ],
            ),
          ),
          Container(width: 120, height: 1, color: PaletaCores.corLightGrey),
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  RevenueInfoDash(
                    title: "Hoje\'s revenue",
                    amount: '23',
                  ),
                  RevenueInfoDash(
                    title: "Ultimos 7 dias",
                    amount: '150',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ]),
                Row(
                  children: [
                    RevenueInfoDash(
                      title: "Ultimos 30 dias",
                      amount: '1,203',
                    ),
                    RevenueInfoDash(
                      title: "Ultimos 12 meses",
                      amount: '3,234',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
