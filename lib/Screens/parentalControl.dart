import 'package:app_usage/app_usage.dart';
import 'package:apptime/storage/app_list.dart';
import 'package:apptime/widget/getusage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../widget/timerWidget.dart';
import 'home_screen.dart';

class ParentalControl extends StatefulWidget {
  const ParentalControl({Key key, this.app_sent}) : super(key: key);
  final List<Apps> app_sent;
  @override
  _ParentalControlState createState() => _ParentalControlState();
}

class _ParentalControlState extends State<ParentalControl> {
  List<Apps> app_sentl;
  int _hval=0,_mval=30,_sval=0;
  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      this.app_sentl=widget.app_sent;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: ListView.builder(
          itemCount: app_sentl.length,
          itemBuilder: (context, index) {

          return ListTile(
            leading: Image.memory(app_sentl[index].images),
            title: Text(app_sentl[index].appName),
            trailing: TextButton(
              child: Text("Set timer"),
              onPressed: (){
                             showModalBottomSheet(context: context,


                                 builder: (context) {

                                   return timerWidget();
                             },);
              }
              )
          ) ;
        },)

      ),
    );

  }
}
