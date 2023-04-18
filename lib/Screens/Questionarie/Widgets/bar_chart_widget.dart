import 'package:app_mental/Screens/Perfil/Widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

class BarChartWidget extends StatefulWidget {
  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  int showingTooltip = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .25,
                child: BarChart(
                  BarChartData(
                    backgroundColor: Colors.white,
                    barGroups: [
                      generateGroupData(0, 1),
                      generateGroupData(1, 10),
                      generateGroupData(2, 18),
                      generateGroupData(3, 4),
                      generateGroupData(4, 11),
                      generateGroupData(5, 0),
                    ],
                    borderData: FlBorderData(
                        border: const Border(
                            bottom: BorderSide(), left: BorderSide())),
                    gridData: FlGridData(drawVerticalLine: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                          axisNameWidget: Text("Semana"),
                          sideTitles: _bottomTitles),
                      leftTitles: AxisTitles(
                        axisNameWidget: Text("Soma PN1"),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          reservedSize:
                              MediaQuery.of(context).size.height * .03,
                        ),
                      ),
                      topTitles: AxisTitles(
                          axisNameWidget: Text("Questionário PN1"),
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),
              Text(
                  "Este texto deverá aparecer logo abaixo do gráfico com os resultados da escala PN1"),
              Container(
                height: MediaQuery.of(context).size.height * .25,
                child: BarChart(
                  BarChartData(
                    backgroundColor: Colors.white,
                    barGroups: [
                      generateGroupData(0, 1),
                      generateGroupData(1, 10),
                      generateGroupData(2, 18),
                      generateGroupData(3, 4),
                      generateGroupData(4, 11),
                      generateGroupData(5, 0),
                    ],
                    borderData: FlBorderData(
                        border: const Border(
                            bottom: BorderSide(), left: BorderSide())),
                    gridData: FlGridData(drawVerticalLine: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                          axisNameWidget: Text("Semana"),
                          sideTitles: _bottomTitles),
                      leftTitles: AxisTitles(
                        axisNameWidget: Text("Soma PN2"),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          reservedSize:
                              MediaQuery.of(context).size.height * .03,
                        ),
                      ),
                      topTitles: AxisTitles(
                          axisNameWidget: Text("Questionário PN2"),
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),
              Text(
                  "Este texto deverá aparecer logo abaixo do gráfico com os resultados da escala PN2"),
              Container(
                height: MediaQuery.of(context).size.height * .25,
                child: BarChart(
                  BarChartData(
                    backgroundColor: Colors.white,
                    barGroups: [
                      generateGroupData(0, 1),
                      generateGroupData(1, 10),
                      generateGroupData(2, 18),
                      generateGroupData(3, 4),
                      generateGroupData(4, 11),
                      generateGroupData(5, 0),
                    ],
                    borderData: FlBorderData(
                        border: const Border(
                            bottom: BorderSide(), left: BorderSide())),
                    gridData: FlGridData(drawVerticalLine: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                          axisNameWidget: Text("Semana"),
                          sideTitles: _bottomTitles),
                      leftTitles: AxisTitles(
                        axisNameWidget: Text("Soma PHQ15"),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 5,
                          reservedSize:
                              MediaQuery.of(context).size.height * .03,
                        ),
                      ),
                      topTitles: AxisTitles(
                          axisNameWidget: Text("Questionário PHQ15"),
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),
              Text(
                  "Este texto deverá aparecer logo abaixo do gráfico com os resultados da escala PHQ15"),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
            toY: y.toDouble(),
            borderRadius: BorderRadius.zero,
            width: 15,
            color: AppColors.verdementa),
      ],
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String xTitle = '';
          switch (value.toInt()) {
            case 0:
              xTitle = '1';
              break;
            case 1:
              xTitle = '3';
              break;
            case 2:
              xTitle = '5';
              break;
            case 3:
              xTitle = '7';
              break;
            case 4:
              xTitle = '9';
              break;
            case 5:
              xTitle = '11';
              break;
          }
          return Text(
            xTitle,
            style: TextStyle(fontSize: 10),
          );
        },
      );
}
