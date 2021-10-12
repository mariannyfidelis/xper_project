import 'package:flutter/material.dart';

import '/widgets/Dashboard/pages/overview/widgets/bar_chart_horizontal.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/pages/overview/widgets/bar_chart_dash.dart';

import '/utils/paleta_cores.dart';

class RevenueSectionLargeDash extends StatelessWidget {
  const RevenueSectionLargeDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 600,
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
            Row(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                        text: 'Geral',
                        size: 20,
                        weight: FontWeight.bold,
                        color: PaletaCores.corLightGrey),
                    Container(
                      width: 600,
                      height: 200,
                      //child: DonutPieChart.withSampleData(),
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 120,
                color: PaletaCores.corLightGrey,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                        text: 'Por Objetivo',
                        size: 20,
                        weight: FontWeight.bold,
                        color: PaletaCores.corLightGrey),
                    Container(
                      width: 600,
                      height: 200,
                      child: HorizontalBarChart.withSampleData(),
                    )
                  ],
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                        text: 'Por Dono',
                        size: 20,
                        weight: FontWeight.bold,
                        color: PaletaCores.corLightGrey),
                    Container(
                      width: 600,
                      height: 200,
                      child: HorizontalBarChart.withSampleData(),
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 120,
                color: PaletaCores.corLightGrey,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                        text: 'Por Resultados',
                        size: 20,
                        weight: FontWeight.bold,
                        color: PaletaCores.corLightGrey),
                    Container(
                      width: 600,
                      height: 200,
                      child: HorizontalBarChart.withSampleData(),
                    )
                  ],
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                        text: 'Por Quarter',
                        size: 20,
                        weight: FontWeight.bold,
                        color: PaletaCores.corLightGrey),
                    Container(
                      width: 600,
                      height: 200,
                      child: SimpleBarChart.withSampleData(),
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 120,
                color: PaletaCores.corLightGrey,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                        text: 'Por Metrica',
                        size: 20,
                        weight: FontWeight.bold,
                        color: PaletaCores.corLightGrey),
                    Container(
                      width: 600,
                      height: 200,
                      child: HorizontalBarChart.withSampleData(),
                    )
                  ],
                ),
              ),
            ]),
          ],
        ));
  }
}
