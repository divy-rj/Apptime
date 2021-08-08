import 'package:apptime/storage/securestorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';
import 'login_screen.dart';

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController cpasswordController = TextEditingController();


class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text ("Sign up", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 20,),
                        Text("Create an Account,Its free",style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),),
                        SizedBox(height: 20,)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0
                      ),
                      child: formField(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3,left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black)
                            )
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height:60,
                          onPressed: (){
                            
                          },
                          color:Color(0xFF8185E2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: GestureDetector(
                            onTap: ()async{
                              if(emailController != null && passwordController != null && cpasswordController != null && nameController != null &&
                                  emailController.text != '' && passwordController.text != '' && cpasswordController.text != '' && nameController.text != '' &&
                                 passwordController.text == cpasswordController.text){
                                final snackBar = SnackBar(content: Text('Yay! Account Created!!Welcome:  ${nameController.text}!',
                                  style: TextStyle(color:Colors.white),),backgroundColor:Colors.green);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                await UserSecureStorage.setUsername(nameController.text);
                                await UserSecureStorage.setPassword(passwordController.text);
                                await UserSecureStorage.setEmail(emailController.text);
                                await UserSecureStorage.setStatus('logout');
                                Navigator.pushReplacement(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    LoginScreen()
                                ) );
                              }
                              else{
                                final snackBar = SnackBar(content: Text('Incomplete Field ',style: TextStyle(color:Colors.white),),backgroundColor:Colors.red);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            child: Text("Sign Up",style: TextStyle(
                              fontWeight: FontWeight.w600,fontSize: 16,

                            ),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    LoginScreen()
                                ) );
                          },
                          child: Text("Login",style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                          ),
                        
                      ],
                    )
                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class formField extends StatefulWidget {
  const formField({Key key}) : super(key: key);

  @override
  _formFieldState createState() => _formFieldState();
}

class _formFieldState extends State<formField> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: SingleChildScrollView(
      child: Column(
          children: [
            SizedBox(height: 8.0,),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                    gapPadding: 4
                    ),
                labelText: "Name",
                hintText: "Example:Apptime",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null && value.isEmpty && value == '') {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 10.0,),
            TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                      gapPadding: 4
                  ),
                  labelText: "Email",
                  hintText: "Example:Apptime@mail.com",
                ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,

                validator: (value) {
                  if (value == null && value.isEmpty && value == '') {
                    return 'Please enter some text';
                  }
                   
                  return null;
                },

            ),
            SizedBox(height: 10.0,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                    gapPadding: 4
                ),
                labelText: "Password",
                hintText: "Example:Apptime@0202",

              ),
              // obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null && value.isEmpty && value == '') {
                  return 'Please enter some text';
                }
                return value.length <8 ? 'Your Password is too small':null;
                return null;
              },
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              controller: cpasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),
                    gapPadding: 4
                ),
                labelText: "Confirm Password",
                hintText: "Example:Apptime@0202",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null && value.isEmpty && value == '') {
                  return 'Please enter some text';
                }
                if(passwordController.text != cpasswordController){
                  return 'Both Passwords not equal';
                }
                return null;
              },
            ),
            SizedBox(height: 10.0,),
          ],
      ), ),
    );
  }
}
