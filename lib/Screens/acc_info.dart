import 'package:apptime/Screens/splashScreen.dart';
import 'package:apptime/storage/securestorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class accountinfo extends StatefulWidget {
  accountinfo({Key key,@required this.isEditing}) : super(key: key);
  bool isEditing;
  @override
  _accountinfoState createState() => _accountinfoState();
}
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _accountinfoState extends State<accountinfo> {
  String name;
  String email;
  String name_a;
  String email_a;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  Future init()async{
    final name=await UserSecureStorage.getUsername()??'no name';
    final email=await UserSecureStorage.getEmail()??'no mail';
    setState(() {
      emailController.text=email;
      nameController.text=name;
    });

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
                              await UserSecureStorage.setStatus('logout');
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
                          SizedBox(width: MediaQuery.of(context).size.width*0.60,),
                          Container(
                              height: 50,
                              width:MediaQuery.of(context).size.width*0.25,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                  style: ButtonStyle(elevation: MaterialStateProperty.all<double>(8.0),
                                      backgroundColor:MaterialStateProperty.all<Color>( Colors.red) ),
                                  child:Icon(Icons.delete_outline,size: 30,),
                                  onPressed: ()async {
                                    await UserSecureStorage.deleteAll();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                            (context) =>
                                            landingPage()
                                        ) );
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
                              nameController.text=name_a;
                              emailController.text=email_a;
                              await UserSecureStorage.setEmail(email_a);
                              await UserSecureStorage.setUsername(name_a);
                              setState(() {
                                print(email_a);
                                widget.isEditing=false;
                              });
                            },
                          )),
                      SizedBox(height:20,),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.75,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                              style: ButtonStyle(elevation: MaterialStateProperty.all<double>(8.0),
                                  backgroundColor:MaterialStateProperty.all<Color>( Color(0xFF4D51BD)) ),
                              child: Text('Edit',style: TextStyle(color: Colors.white),),
                              onPressed: ()async {
                              if(emailController != null && nameController != null && nameController.text != '' &&  emailController.text != '') {
                                print(nameController.text);
                                await UserSecureStorage.setEmail(
                                    emailController.text);
                                await UserSecureStorage.setUsername(
                                    nameController.text);
                                setState(() {
                                  widget.isEditing = false;
                                });
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



 