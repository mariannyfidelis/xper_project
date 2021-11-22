import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '/widgets/Dashboard/controller/controllers_dash.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  SimpleBarChart(this.seriesList, {this.animate});

  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalProgressoQuarter, String>> _createSampleData() {
    var mandalaController = Get.find<ControllerProjetoRepository>();
    List<OrdinalProgressoQuarter> data = [];
    var metrics = mandalaController.listaMetricas;
    double realizadoGeral = 0;
    double metasGeral = 0;

    double realizado1 = 0;
    double metas1 = 0;

    double realizado2 = 0;
    double metas2 = 0;

    double realizado3 = 0;
    double metas3 = 0;

    double realizado4 = 0;
    double metas4 = 0;

    for (var metric in metrics) {
      realizadoGeral += (metric.realizado1! +
          metric.realizado2! +
          metric.realizado3! +
          metric.realizado4!);
      realizado1 += metric.realizado1!;
      realizado2 += metric.realizado2!;
      realizado3 += metric.realizado3!;
      realizado4 += metric.realizado4!;

      metasGeral +=
          (metric.meta1! + metric.meta2! + metric.meta3! + metric.meta4!);
      metas1 += metric.meta1!;
      metas2 += metric.meta2!;
      metas3 += metric.meta3!;
      metas4 += metric.meta4!;
    }
    var geral = mandalaController.gerarProgresso(realizadoGeral, metasGeral,
        grafico: true);
    var q1 =
        mandalaController.gerarProgresso(realizado1, metas1, grafico: true);
    var q2 =
        mandalaController.gerarProgresso(realizado2, metas2, grafico: true);
    var q3 =
        mandalaController.gerarProgresso(realizado3, metas3, grafico: true);
    var q4 =
        mandalaController.gerarProgresso(realizado4, metas4, grafico: true);
    data.add(OrdinalProgressoQuarter("Total Geral", geral));
    data.add(OrdinalProgressoQuarter("Quarter 1", q1));
    data.add(OrdinalProgressoQuarter("Quarter 2", q2));
    data.add(OrdinalProgressoQuarter("Quarter 3", q3));
    data.add(OrdinalProgressoQuarter("Quarter 4", q4));

    return [
      new charts.Series<OrdinalProgressoQuarter, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalProgressoQuarter sales, _) => sales.year,
        measureFn: (OrdinalProgressoQuarter sales, _) => sales.sales,

        data: data,
        //insideLabelStyleAccessorFn: ,
        //displayName: "${(OrdinalProgressoQuarter sales, _) => sales.sales}",
      )
    ];
  }
}

class OrdinalProgressoQuarter {
  final String year;
  final int sales;

  OrdinalProgressoQuarter(this.year, this.sales);
}
