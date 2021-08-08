import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../page/pie_chart_page.dart';
import '../widget/getusage.dart';
import '../page/bargraph.dart';
import 'acc_info.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AppUsageInfo> _infos = [];
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  DateTime total_screentime;
  String name;
  @override
  void initState() {
    getUsage();
    super.initState();
     init();
  }

  Future init()async{
    final name=await UserSecureStorage.getUsername();
    setState(() {
       this.name=name;
    });

  }
  void getUsage() async {
    try {
      List<AppUsageInfo> infoList = await getUsageStats(0);
      setState(() {
        _infos = infoList;
      });


    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppTime'),
          backgroundColor: Color(0xFF4D51BD),
        ),


        body: Builder(
            builder: (context) {
             if(_page ==1 ){
               return homescreen(_infos);
             }
             else if(_page == 3){
               return accountinfo(isEditing: false,);
             }
             else{
               return homescreen(_infos);
             }
            },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.home, size: 30,color: Colors.white,),
            Icon(Icons.app_blocking, size: 30,color: Colors.white,),
            Icon(Icons.analytics, size: 30,color: Colors.white,),
            Icon(Icons.person, size: 30,color: Colors.white,),
          ],

          color: Color(0xFF4D51BD),
          buttonBackgroundColor:Color(0xFF07335C),
          backgroundColor: Colors.white,

          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        ),


    );
  }
}


class homescreen extends StatelessWidget {
  List<AppUsageInfo> _infos;
  homescreen(this._infos);
  @override

  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      children:  <Widget>[
        Center(
          child: ListView.builder(
              itemCount: _infos.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(_infos[index].appName),
                    trailing: Text(_infos[index].usage.toString()));
              }),
        ),
        Center(
          child:PieChartPage(_infos),
        ),
        Center(
          child: BarChartSample1(),
        )
      ],
    );
  }
}
