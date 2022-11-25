import 'package:flutter/material.dart';
import 'package:tcc/pages/menu.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: MenuPrincipal(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.mirror,
                colors: [
                  Colors.black,
                  Color.fromARGB(255, 9, 41, 58),
                  Color.fromARGB(255, 20, 81, 114),
                  Color.fromARGB(255, 18, 125, 175),
                  Color.fromARGB(255, 47, 166, 221),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: 25,
            left: 10,
            right: 10,
            bottom: 350,
          ),
          child: SfCartesianChart(
            title: ChartTitle(
              text: 'Dados do seu reservatório',
              textStyle: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 110, 107, 107),
                fontFamily: 'Staatliches',
              ),
              alignment: ChartAlignment.center,
            ),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_Dados, String>>[
              LineSeries<_Dados, String>(
                  name: 'Turbidez',
                  dataSource: <_Dados>[
                    _Dados('Jan', 1.0),
                    _Dados('Feb', 4.20),
                    _Dados('Mar', 3.00),
                    _Dados('Apr', 7.50),
                    _Dados('May', 4.20),
                    _Dados('Jun', 2.50),
                    _Dados('Jul', 2.20),
                    _Dados('Ago', 6.00),
                    _Dados('Set', 7.00),
                    _Dados('Out', 1.50),
                    _Dados('Nov', 4.20)
                  ],
                  xValueMapper: (_Dados agua, _) => agua.tempo,
                  yValueMapper: (_Dados agua, _) => agua.agua,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ],
            primaryXAxis: CategoryAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '{value} uT',
            ),
          ),
        ),
      );
}

class _Dados {
  _Dados(this.tempo, this.agua);

  final String tempo;
  final double agua;
}
