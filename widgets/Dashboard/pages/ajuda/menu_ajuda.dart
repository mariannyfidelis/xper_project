import 'package:flutter/material.dart';

class AjudaPageDash extends StatelessWidget {
  const AjudaPageDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 600,
            child: Text(
              '''
Instruções Iniciais

Guia de Objetivos da Equipe

1. Depois de definir os OKRs com sua equipe, vá para a guia Objetivos da equipe e insira os objetivos de sua equipe. Use títulos objetivos distintos.

Guia de resultados principais

2. Na coluna Resultado principal, você insere os resultados principais. Lembre-se de que essas são as declarações de sua equipe que serão usadas para atingir a meta, portanto, certifique-se de que os principais resultados sejam mensuráveis.

Guia Dono

3. Na coluna Dono, você insere o nome do dono que ficará responsável por aquele resultado.

Guia Métrica

4. Na coluna Qual a Métrica, você insere o nome do indicador. A métrica é usada para mostrar se o resultado principal está sendo alcançado.

Guia Metas

5. Alvo da coluna Meta é usado para definir qual é o alvo da métrica.

6. Finalmente, atualize manualmente o valor atual na coluna de mesmo nome toda vez que você verificar os OKRs de suas equipes. A coluna Progresso será atualizada automaticamente.	''',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
          SizedBox(width: 20),
          Container(
            width: 500,
            child: Text('''O Dashboard
             
        Use o Dashboard como sua torre de vigia para obter uma visão geral dos OKRs de sua equipe.

1. Selecione o período de tempo que deseja exibir seja o Ano e/ou Quadrimestre(Quarter) .

2. O gráfico de medidor mostra o progresso geral, enquanto o gráfico de barras na parte inferior e à direita  mostra o progresso por objetivo, resultado, dono e métrica.

3. Você pode usar os filtros na parte superior para selecionar uma visão específica.''',
                style: TextStyle(color: Colors.black, fontSize: 17)),
          )
        ],
      ),
    );
  }
}
