import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class timerWidget extends StatefulWidget {
  const timerWidget({Key key}) : super(key: key);

  @override
  _timerWidget createState() => _timerWidget();
}

class _timerWidget extends State<timerWidget> {
  int h_val=0,m_val=30,s_val=0;

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 1),
        height: 270,
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("HH"),
                      NumberPicker(
                       selectedTextStyle: TextStyle(color: Color(0xFF4D51BD),fontSize: 30),
                        value: h_val,
                        minValue: 0,
                        maxValue: 24,
                        onChanged: (value) => setState(() => h_val = value),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("MM"),
                      NumberPicker(
                        selectedTextStyle: TextStyle(color: Color(0xFF4D51BD),fontSize: 30),
                        value: m_val,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (value) => setState(() => m_val = value),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SS"),
                      NumberPicker(
                        selectedTextStyle: TextStyle(color: Color(0xFF4D51BD),fontSize: 30),
                        value: s_val,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (value) => setState(() => s_val = value),
                      )
                    ],
                  ) ,
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("Cancel"),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFFF))),),
                  SizedBox(width: 20,),
                  ElevatedButton(onPressed: (){

                     },
                      child: Text("Save"),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF4D51BD)))),
                ],
              )
            ],

          ),
        ),
    );
  }
}
