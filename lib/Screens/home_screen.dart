import 'package:app_usage/app_usage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../page/pie_chart_page.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AppUsageInfo> _infos = [];
  DateTime total_screentime;
  @override
  void initState() {
    getUsageStats();
    super.initState();

  }

  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours:24));
      List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
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
          backgroundColor: Colors.deepPurpleAccent,
        ),


        body:  homescreen(_infos),
       
        drawer:Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [

                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                    ),
                    child: Row(

                        children: [
                          CircleAvatar(child: Icon(Icons.account_circle,size: 70,color: Colors.white,),
                            maxRadius: 50,backgroundColor: Colors.deepPurpleAccent,)  ,
                          SizedBox(width: 12,height: 30,),
                          Text("Dani Daniels",style: TextStyle(fontSize: 20),)
                       ]
                    ),

                  ),
                  ListTile(
                    title: const Text('Account Info'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(indent: 2,color: Colors.black,),
                  ListTile(
                    title: const Text('Tracker'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(indent: 2,color: Colors.black,),
                  ListTile(
                    title: const Text('Donate'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(indent: 2,color: Colors.black,),
                  ListTile(
                    trailing: Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(indent: 2,color: Colors.black,),
                ],
              ),
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
          child: Text('Third Page'),
        )
      ],
    );
  }
}
