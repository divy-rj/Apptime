import 'package:apptime/storage/UsersModel.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:apptime/storage/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';
import 'logon_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
     String email;
     String password;
     Shared_Prefs shared_prefs=Shared_Prefs();
     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  Future init()async{
    Users user=await shared_prefs.getUsersInfo();
    setState(() {
      this.email=user.email;
      this.password=user.password;
    });
  }
    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return Scaffold(
          body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      width: width,
                      height: height * 0.45,
                      child: Image.asset('assets/apptime_anime.gif',
                          fit: BoxFit.contain)
                    //child:Image.asset('assets/APPTIME.png',fit: BoxFit.cover)
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                       // errorText: 'Wrong Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      //forgot password screen
                    },
                    textColor: Colors.deepPurpleAccent,
                    child: Text('Forgot Password'),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        //style: ButtonStyle(backgroundColor: Color(0xFF8185E2)),
                        child: Text('Login'),
                        onPressed: ()async{
                         if (nameController.text == email && passwordController.text == password) {
                           await shared_prefs.setLoginStatus(true);
                           bool isLogin=await shared_prefs.getLoginStatus()??false;
                           print(isLogin);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  MyHomePage()
                              ) ); }
                         else{
                           // final snackBar = SnackBar(content: Text('Login Failed'));
                           // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                           Navigator.pushReplacement(context,
                               MaterialPageRoute(builder:
                               (context) =>
                               MyHomePage() ) );
                         }
                        },
                      )),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          TextButton(
                          //  textColor:  Colors.deepPurpleAccent,

                            child: Text(
                              'Create An Account',
                              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => SignupPage()));
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                ],
              )));
    }
  }