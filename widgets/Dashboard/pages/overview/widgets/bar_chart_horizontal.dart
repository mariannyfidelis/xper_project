import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '/widgets/Dashboard/controller/controllers_dash.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  HorizontalBarChart(this.seriesList, {this.animate});

  factory HorizontalBarChart.withSampleData(String por, BuildContext context) {
    return new HorizontalBarChart(
      _createSampleData(por, context),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalProgresso, String>> _createSampleData(String? por, BuildContext context) {
    List<OrdinalProgresso> data = [];
    var mandalaController = Get.find<ControllerProjetoRepository>();

    if (por == 'Por Objetivo') {
      var objs = mandalaController.listaObjectives;
      double realizadoGeral = 0;
      double metasGeral = 0;

      for (var obj in objs) {
        data.add(OrdinalProgresso(
            (obj.nome!.length <= 20)
                ? obj.nome.toString()
                : obj.nome.toString().substring(0, 20) + '...',
            mandalaController.gerarProgresso(
                mandalaController.realizadoObjetivos(0.0, obj.idObjetivo!),
                mandalaController.metaObjetivos(0.0, obj.idObjetivo!),
                grafico: true)));
        realizadoGeral +=
            mandalaController.realizadoObjetivos(0.0, obj.idObjetivo!);
        metasGeral += mandalaController.metaObjetivos(0.0, obj.idObjetivo!);
      }
      var geral = mandalaController.gerarProgresso(realizadoGeral, metasGeral,
          grafico: true);
      data.add(OrdinalProgresso("Total Geral", geral));
    }
    if (por == 'Por Resultados') {
      var results = mandalaController.listaResultados;
      double realizadoGeral = 0;
      double metasGeral = 0;
      for (var result in results) {
        data.add(OrdinalProgresso(
            (result.nomeResultado!.length <= 20)
                ? result.nomeResultado.toString()
                : result.nomeResultado.toString().substring(0, 20) + '...',
            mandalaController.gerarProgresso(
                mandalaController.realizadoResulMetric(
                    0.0, result.idResultado!),
                mandalaController.metasResulMetric(0.0, result.idResultado!),
                grafico: true)));
        realizadoGeral +=
            mandalaController.realizadoResulMetric(0.0, result.idResultado!);
        metasGeral +=
            mandalaController.metasResulMetric(0.0, result.idResultado!);
      }
      var geral = mandalaController.gerarProgresso(realizadoGeral, metasGeral,
          grafico: true);
      data.add(OrdinalProgresso("Total Geral", geral));
    }
    if (por == "Por Métrica") {
      var metrics = mandalaController.listaMetricas;
      double realizadoGeral = 0;
      double metasGeral = 0;
      for (var metric in metrics) {
        data.add(OrdinalProgresso(
          (metric.nomeMetrica!.length <= 20)
              ? metric.nomeMetrica.toString()
              : metric.nomeMetrica.toString().substring(0, 20) + '...',
          mandalaController.gerarProgressoGeral(
              metric.realizado1!,
              metric.realizado2!,
              metric.realizado3!,
              metric.realizado4!,
              metric.meta1!,
              metric.meta2!,
              metric.meta3!,
              metric.meta4!,
              grafico: true),
        ));
        realizadoGeral += (metric.realizado1! +
            metric.realizado2! +
            metric.realizado3! +
            metric.realizado4!);
        metasGeral +=
        (metric.meta1! + metric.meta2! + metric.meta3! + metric.meta4!);
      }
      var geral = mandalaController.gerarProgresso(realizadoGeral, metasGeral,
          grafico: true);
      data.add(OrdinalProgresso("Total Geral", geral));
    }
    if (por == 'Por Dono') {
      var donos = mandalaController.listaDonos;
      double realizadoGeral = 0;
      double metasGeral = 0;

      for (var dono in donos) {
        data.add(OrdinalProgresso(
            (dono.nome!.length <= 20)
                ? dono.nome.toString()
                : dono.nome.toString().substring(0, 20) + '...',
            mandalaController.gerarProgresso(
                mandalaController.realizadosDono(0.0, dono.email),
                mandalaController.metasDono(0.0, dono.email),
                grafico: true)));
        realizadoGeral += mandalaController.realizadosDono(0.0, dono.email);
        metasGeral += mandalaController.metasDono(0.0, dono.email);
      }
      var geral = mandalaController.gerarProgresso(realizadoGeral, metasGeral,
          grafico: true);
      data.add(OrdinalProgresso("Total Geral", geral));
    }
    return [
      new charts.Series<OrdinalProgresso, String>(
        id: 'Sales',
        domainFn: (OrdinalProgresso sales, _) => sales.year,
        measureFn: (OrdinalProgresso sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class OrdinalProgresso {
  final String year;
  final int sales;

  OrdinalProgresso(this.year, this.sales);
}
