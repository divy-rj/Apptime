import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_screen.dart';
import 'logon_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

//     TextEditingController  emailcontroler = TextEditingController();
//     String passwordcontroler = '';
//     bool isvisible = false;
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     void initState() {
//       super.initState();
//     }
//
//     return Scaffold(
//       body: Container(
//         height: height,
//         width: width,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                   width: width,
//                   height: height * 0.45,
//                   child: Image.asset('assets/apptime_anime.gif',
//                       fit: BoxFit.contain)
//                   //child:Image.asset('assets/APPTIME.png',fit: BoxFit.cover)
//                   ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Login',
//                       style: TextStyle(
//                           fontSize: 25.0, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: emailcontroler,
//                   decoration: InputDecoration(
//                     hintText: 'abc@example.com',
//                     labelText: 'Email',
//                     icon: Icon(Icons.email),
//                     suffixIcon: emailcontroler.text.isEmpty
//                         ? Container(
//                             width: 0,
//                           )
//                         : IconButton(
//                            // onPressed: () => emailcontroler.clear(),
//                             icon: Icon(Icons.close)),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   onChanged: (value) => setState(() {
//                     value = passwordcontroler;
//                   }),
//                   onSubmitted: (value) => setState(() {
//                     value = passwordcontroler;
//                   }),
//                   obscureText: isvisible,
//                   decoration: InputDecoration(
//                     icon: Icon(Icons.password),
//                     hintText: 'Password',
//                     suffixIcon: IconButton(
//                         icon: isvisible
//                             ? Icon(Icons.visibility_off)
//                             : Icon(Icons.visibility),
//                         onPressed: () {
//                           setState(() {
//                             isvisible=!isvisible;
//                           });
//                         }),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Forget password?',
//                       style: TextStyle(fontSize: 12.0),
//                     ),
//                     ElevatedButton(
//                       child: Text('Login'),
//                       onPressed: () {
//                            print(emailcontroler.text);
//                         Navigator.pushReplacement(context,
//                             MaterialPageRoute(builder:
//                                 (context) =>
//                                 MyHomePage()
//                             ) );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               GestureDetector(
//                 onTap: () {},
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => SignupPage()));
//                   },
//                   child: Text.rich(
//                     TextSpan(text: 'Don\'t have an account', children: [
//                       TextSpan(
//                         text: 'Signup',
//                         style: TextStyle(color: Color(0xffEE7B23)),
//                       ),
//                     ]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return Scaffold(
          // appBar: AppBar(
          //   title: Text('APPTIME'),
          // ),
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
                        onPressed: () {
                          print(nameController.text);
                          print(passwordController.text);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  MyHomePage()
                              ) );
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