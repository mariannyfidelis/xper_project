import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/models/usuario.dart';
import 'package:provider/provider.dart';

import '/utils/paleta_cores.dart';

/// Example without datasource
class ClientsList extends StatelessWidget {
  const ClientsList();

  @override
  Widget build(BuildContext context) {
    final usuarios = Provider.of<List<Usuario>?>(context);
    return (usuarios != null)
        ? Container(
            margin: EdgeInsets.only(bottom: 30),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      text: "Clientes",
                      color: PaletaCores.corLightGrey,
                      weight: FontWeight.bold,
                    )
                  ],
                ),
                DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: [
                    DataColumn2(
                      label: Text('Nome'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('Email'),
                    ),
                    DataColumn(
                      label: Text('Tipo de conta'),
                    )
                  ],
                  rows: List<DataRow>.generate(
                    usuarios.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          CustomText(text: usuarios[index].nome),
                        ),
                        DataCell(
                          CustomText(text: usuarios[index].email),
                        ),
                        DataCell(
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: PaletaCores.active, width: .5),
                                  color: PaletaCores.corLight,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: CustomText(
                                text: usuarios[index].tipoUsuario,
                                color: PaletaCores.active.withOpacity(.7),
                                weight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
