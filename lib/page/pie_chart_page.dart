import 'package:app_usage/app_usage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widget/indicators_widget.dart';
import '../widget/pie_chart_sections.dart';
import 'package:flutter/material.dart';

class PieChartPage extends StatefulWidget {
  List<AppUsageInfo> _infos;
  PieChartPage(this._infos);
  @override
  State<StatefulWidget> createState() => PieChartPageState(_infos);
}

class PieChartPageState extends State {
  List<AppUsageInfo> infos;
  PieChartPageState(this.infos);
  List<ChartData> chartData=[];
  @override
  void initState() {
    for (var info in infos) {
      if(info.appName != 'apptime'){
        int time_mill= info.usage.inMilliseconds;

        ChartData data=ChartData(info.appName,time_mill);
        chartData.add(data);
      }
    }

    super.initState();

  }

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child:Container(
                  child: SfCircularChart(
                      legend: Legend(
                        isVisible: true,
                        // Legend title
                        title: LegendTitle(
                            text:'Apps',
                            textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900
                            )
                        ),
                      ),
                      series: <CircularSeries>[

                        PieSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelMapper:(ChartData data, _) => data.x,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              showZeroValue: false,
                              labelPosition: ChartDataLabelPosition.outside

                          ),

                        )
                      ])
              ),
                
            ),
          ],
        ),
      );
}
class ChartData {
  ChartData(this.x, this.y,[this.color]);
  final String x;
  final int y;
  final Color color;
}