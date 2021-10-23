import 'permissaoACLModel.dart';
import '/models/metricasModel.dart';
import 'objetivosPrincipaisModel.dart';
import '/models/resultadoPrincipalModel.dart';
import '/models/donoResultadoMetricaModel.dart';

class ProjectModel{

  String? idProjeto;
  String? nome;
  String? proprietario;
  List<ObjetivosPrincipais>? objetivosPrincipais;
  List<ResultadosPrincipais>? resultadosPrincipais;
  List<MetricasPrincipais>? metricasPrincipais;
  List<DonosResultadoMetricas>? listaDonos;
  List<ACL>? acl;
  //List<MetasPrincipais> metas;

  ProjectModel(
      {this.idProjeto,
        this.nome,
        this.proprietario,
        this.objetivosPrincipais,
        this.resultadosPrincipais,
        this.metricasPrincipais,
        this.listaDonos,
        this.acl,
        //this.metas,
        });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    idProjeto = json['idProjeto'];
    nome = json['nome'];
    proprietario = json['proprietario'];
    if (json['objetivosPrincipais'] != null) {
      objetivosPrincipais = <ObjetivosPrincipais>[];
      json['objetivosPrincipais'].forEach((v) {
        objetivosPrincipais!.add(new ObjetivosPrincipais.fromJson(v));
      });
    }
    if (json['resultadosPrincipais'] != null) {
      resultadosPrincipais = <ResultadosPrincipais>[];
      json['resultadosPrincipais'].forEach((v) {
        resultadosPrincipais!.add(new ResultadosPrincipais.fromJson(v));
      });
    }
    if (json['metricasPrincipais'] != null) {
      metricasPrincipais = <MetricasPrincipais>[];
      json['metricasPrincipais'].forEach((v) {
        metricasPrincipais!.add(new MetricasPrincipais.fromJson(v));
      });
    }
    if (json['listaDonos'] != null) {
      listaDonos = <DonosResultadoMetricas>[];
      json['listaDonos'].forEach((v) {
        listaDonos!.add(new DonosResultadoMetricas.fromJson(v));
      });
    }
    // if (json['metas'] != null) {
    //   metas = <MetasModel>[];
    //   json['metas'].forEach((v) {
    //     metas.add(new MetasModel.fromJson(v));
    //   });
    // }
    if (json['acl'] != null) {
      acl = <ACL>[];
      json['acl'].forEach((v) {
        acl!.add(new ACL.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProjeto']=this.idProjeto;
    data['nome'] = this.nome;
    data['proprietario'] = this.proprietario;
    if (this.objetivosPrincipais != null) {
      data['objetivosPrincipais'] =
          this.objetivosPrincipais!.map((v) => v.toJson()).toList();
    }
    if (this.resultadosPrincipais != null) {
      data['resultadosPrincipais'] =
          this.resultadosPrincipais!.map((v) => v.toJson()).toList();
    }
    if (this.metricasPrincipais != null) {
      data['metricasPrincipais'] =
          this.metricasPrincipais!.map((v) => v.toJson()).toList();
    }
    if (this.listaDonos != null) {
      data['listaDonos'] = this.listaDonos!.map((v) => v.toJson()).toList();
    }
    // if (this.metas != null) {
    //   data['metas'] = this.metas!.map((v) => v.toJson()).toList();
    // }
    if (this.acl != null) {
      data['acl'] = this.acl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}