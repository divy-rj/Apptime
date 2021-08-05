import 'dart:async';
import 'dart:math';
import 'package:app_usage/app_usage.dart';
import '../widget/getusage.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  List<double>totaltime=[0,0,0,0,0,0,0];
  double largest=0;
  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    getUsage();
    super.initState();

  }

  void getUsage() async {
    try {
      for(int i=0;i<7;i++){
        List<AppUsageInfo> infoList = await getUsageStats(i);
        if(infoList.isEmpty)
          continue;
        for(var t in infoList){
          if(t.appName=="apptime")
            continue;
          totaltime[i]+=t.usage.inMinutes.toDouble();
        }
        if(totaltime[i]>largest)
          largest=totaltime[i];

      }



    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Daily Usage',
                    style: TextStyle(
                        color: const Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Total Screen Time',
                    style: TextStyle(
                        color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xff0f4a3c),
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = Colors.white,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: largest+15,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, totaltime[6], isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, totaltime[5], isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, totaltime[4], isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, totaltime[3], isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, totaltime[2], isTouched: i == touchedIndex);
      case 5:
        return makeGroupData(5, totaltime[1], isTouched: i == touchedIndex);
      case 6:
        return makeGroupData(6,totaltime[0], isTouched: i == touchedIndex);
      default:
        return throw Error();
    }
  });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  {
                    DateTime now = new DateTime.now();
                    DateTime endDate = new DateTime(now.year,now.month,now.day-6);
               weekDay= DateFormat('EEEE').format(endDate);
               break;
                  }
                case 1:
                  {
                    DateTime now = new DateTime.now();
                    DateTime endDate = new DateTime(now.year,now.month,now.day-5);
                    weekDay= DateFormat('EEEE').format(endDate);
                    break;
                  }
                case 2:
                  {
                    DateTime now = new DateTime.now();
                    DateTime endDate = new DateTime(now.year,now.month,now.day-4);
                    weekDay= DateFormat('EEEE').format(endDate);
                    break;
                  }
                case 3:
                  {
                    DateTime now = new DateTime.now();
                    DateTime endDate = new DateTime(now.year,now.month,now.day-3);
                    weekDay= DateFormat('EEEE').format(endDate);
                    break;
                  }
                case 4:
                  {
                    DateTime now = new DateTime.now();
                    DateTime endDate = new DateTime(now.year,now.month,now.day-2);
                    weekDay= DateFormat('EEEE').format(endDate);
                    break;
                  }
                case 5:
                  {
                    DateTime now = new DateTime.now();
                    DateTime endDate = new DateTime(now.year,now.month,now.day-1);
                    weekDay= DateFormat('EEEE').format(endDate);
                    break;
                  }
                case 6:
                  {
                    DateTime now = new DateTime.now();
                    DateTime endDate = new DateTime(now.year,now.month,now.day);
                    weekDay= DateFormat('EEEE').format(endDate);
                    break;
                  }
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                {
                  DateTime now = new DateTime.now();
                  DateTime endDate = new DateTime(now.year,now.month,now.day-6);
                 return DateFormat('EEEE').format(endDate).substring(0,3);
                }
              case 1:
              {
                DateTime now = new DateTime.now();
                DateTime endDate = new DateTime(now.year,now.month,now.day-5);
                return DateFormat('EEEE').format(endDate).substring(0,3);
              }
              case 2:
               {
                 DateTime now = new DateTime.now();
                 DateTime endDate = new DateTime(now.year,now.month,now.day-4);
                 return DateFormat('EEEE').format(endDate).substring(0,3);
               }
              case 3:
                {
                  DateTime now = new DateTime.now();
                  DateTime endDate = new DateTime(now.year,now.month,now.day-3);
                  return DateFormat('EEEE').format(endDate).substring(0,3);
                }
              case 4:
               {
                 DateTime now = new DateTime.now();
                 DateTime endDate = new DateTime(now.year,now.month,now.day-2);
                 return DateFormat('EEEE').format(endDate).substring(0,3);
               }
              case 5:
                {
                  DateTime now = new DateTime.now();
                  DateTime endDate = new DateTime(now.year,now.month,now.day-1);
                  return DateFormat('EEEE').format(endDate).substring(0,3);
                }
              case 6:
               {
                 DateTime now = new DateTime.now();
                 DateTime endDate = new DateTime(now.year,now.month,now.day);
                 return DateFormat('EEEE').format(endDate).substring(0,3);
               }
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}