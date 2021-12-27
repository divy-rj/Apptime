import 'dart:convert';

import 'package:apptime/Screens/logon_screen.dart';
import 'package:apptime/Screens/splashScreen.dart';
import 'package:apptime/Services/httpService.dart';
import 'package:apptime/storage/App_Db.dart';
import 'package:apptime/storage/UsersModel.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:apptime/storage/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class accountinfo extends StatefulWidget {
  accountinfo({Key key,@required this.isEditing}) : super(key: key);
  bool isEditing;
  @override
  _accountinfoState createState() => _accountinfoState();
}
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController old_passwordController =TextEditingController();
TextEditingController new_passwordController =TextEditingController();
TextEditingController confirm_new_passwordController =TextEditingController();
class _accountinfoState extends State<accountinfo> {
  Shared_Prefs shared_prefs=Shared_Prefs();
  Services services=Services();
  String name_a;
  String password_a;
  var password;
  String id;
  String email_a;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    init();

  }

  Future init()async{
    Users user = await shared_prefs.getUsersInfo();
    setState(() {
      emailController.text=user.email;
      nameController.text=user.name;
      this.password=user.password;
    });
    // Data d;
    // d=(await shared_prefs.getData()) as Data;
    // print(d);

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
            child: Builder(
              builder: (context) {
                name_a=nameController.text;
                email_a=emailController.text;
                password_a=password;
                if(widget.isEditing == false) {
                  return Column(

                    children: [
                      SizedBox(height: 20,),
                      Row(

                        children: [
                          SizedBox(width: 20,),
                          CircleAvatar(
                            child: Icon(Icons.person, size: 50,), maxRadius: 50,),
                          SizedBox(width: 40,),
                          Column(
                            children: [
                              SizedBox(height: 60,),
                              Text("Hi, ${nameController.text.toUpperCase() ?? 'no name'}",
                                  style: TextStyle(fontSize: 25)),
                            ],
                          )
                        ],

                      ),
                      SizedBox(height: 60,),
                      TextFormField(
                        controller: emailController,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            prefixText: "Email: "
                        ),
                        enabled: false,
                      ),
                      SizedBox(height: 80),
                      Container(
                          height: 50,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.75,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(

                            style: ButtonStyle(elevation: MaterialStateProperty.all<double>(1),
                                backgroundColor:MaterialStateProperty.all<Color>( Colors.white) ),
                            child: Text('Edit',style: TextStyle(color: Colors.black)),
                            onPressed: (){
                              setState(() {
                                widget.isEditing=true;
                              });
                            },
                          )),
                      SizedBox(height: 20,),
                      Container(
                          height: 50,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.75,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(8.0),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Color(0xFF4D51BD))),
                            child: Text(
                              'Log Out', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              await shared_prefs.setLoginStatus(false);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                      landingPage()
                                  ));

                              final snackBar = SnackBar(content: Text(
                                  'Logged Out!!'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                          )),
                    ],
                  );
                }
                else{
                  return Column(
                    children: [
                      SizedBox(height: 40,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width*0.61,),
                          Container(
                              height: 50,
                              width:MediaQuery.of(context).size.width*0.27,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                  style: ButtonStyle(elevation: MaterialStateProperty.all<double>(8.0),
                                      backgroundColor:MaterialStateProperty.all<Color>( Colors.red) ),
                                  child:Icon(Icons.delete_outline,size: 30,),
                                  onPressed: ()async {
                                    int status= await services.deleteUser(email_a);
                                    if(status == 200) {
                                      SharedPreferences preferences = await SharedPreferences
                                          .getInstance();
                                      await preferences.clear();
                                      await shared_prefs.setLoginStatus(false);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder:
                                              (context) =>
                                              landingPage()
                                          ));
                                    }
                                  })),

                        ],
                      ),
                      SizedBox(height: 50,),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                              gapPadding: 4
                          ),
                          labelText: "Name",
                          hintText: "Example:Apptime",
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          if (value == null && value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0,),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                              gapPadding: 4
                          ),
                          labelText: "Email",
                          hintText: "Example:Apptime@mail.com",
                        ),

                        keyboardType: TextInputType.emailAddress,

                        onChanged: (value) {
                          if (value == null && value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },

                      ),
                      SizedBox(height: 10.0,),
                      TextFormField(
                        controller: old_passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                              gapPadding: 4
                          ),
                          labelText: " Password",
                          hintText: "Example:Apptime@123",
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,

                        onChanged: (value) {
                          if (value == null && value.isEmpty && value == '') {
                            return 'Please enter some text';
                          }

                          return null;
                        },

                      ),
                      SizedBox(height: 10.0,),
                      TextFormField(
                        controller: new_passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                              gapPadding: 4
                          ),
                          labelText: "New Password",
                          hintText: "Change:appTime@123",
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,

                        onChanged: (value) {


                          return null;
                        },

                      ),
                      SizedBox(height: 10.0,),
                      TextFormField(
                        controller: confirm_new_passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                              gapPadding: 4
                          ),
                          labelText: "Confirm New Password",
                          hintText: "Example:appTime@123",
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,

                        onChanged: (value) {
                             if(new_passwordController.text != passwordController.text){
                               return 'new password is not same to this';
                             }

                          return null;
                        },

                      ),
                      SizedBox(height:80),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.75,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(

                            style: ButtonStyle(elevation: MaterialStateProperty.all<double>(1),
                                backgroundColor:MaterialStateProperty.all<Color>( Colors.white) ),
                            child: Text('Cancel',style: TextStyle(color: Colors.black)),
                            onPressed: ()async{
                              await shared_prefs.saveUsersInfo(name_a,email_a,password_a);
                              setState(() {
                                print(email_a);
                                widget.isEditing=false;
                              });
                            },
                          )),
                      SizedBox(
                        height:20,),

                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.75,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                              style: ButtonStyle(elevation: MaterialStateProperty.all<double>(8.0),
                                  backgroundColor:MaterialStateProperty.all<Color>( Color(0xFF4D51BD)) ),
                              child: Text('Edit',style: TextStyle(color: Colors.white),),
                              onPressed: ()async {
                                String pass;

                              if(emailController != null && nameController != null && nameController.text != '' &&  emailController.text != '' && old_passwordController.text != null && old_passwordController.text != '' &&
                                  old_passwordController.text == password) {
                                pass=old_passwordController.text;
                                if(new_passwordController.text != null && new_passwordController.text != ''
                                && confirm_new_passwordController.text != null && confirm_new_passwordController.text != ''){
                                  pass=new_passwordController.text;
                                }
                                print(nameController.text);
                                Users users=Users(password: pass,
                                  name:nameController.text,email: emailController.text);
                                print("nice:: $users");
                                int status=await services.updateUser(email_a,users);
                                if(status != 200){
                                  emailController.text = email_a;
                                }
                                print(status);
                                setState(() {
                                  widget.isEditing = false;

                                });
                                old_passwordController.text='';
                                new_passwordController.text='';
                                confirm_new_passwordController.text='';

                                }
                              else{
                                final snackBar = SnackBar(content: Text('Incomplete Field ',style: TextStyle(color:Colors.white),),backgroundColor:Colors.red);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                               }
                              }
                          )),
                    ],
                  );
                }
              }
            ),
        ),
      ),
    );
  }
}



 