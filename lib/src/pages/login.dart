import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sundaytask/src/controllers/logincontroller.dart';
import 'package:sundaytask/src/controllers/welcome.dart';
import 'package:sundaytask/src/pages/index.dart';
import 'package:sundaytask/src/pages/phoneauthverify.dart';

import 'signup.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends StateMVC<Login> {

  LoginController _con;

  _LoginState() : super(LoginController()) {
    _con = controller;
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  Future<String> checkifuserloggedin()async {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      // return Navigator.pushNamed(context, '/Welcome');
    } else {
      print('User is signed in!');
         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyHomePage(email: emailInputController.text,);
                        },
                      ),
                    );
    }
  });
  }

  Future<String> login(String email, String password) async {
   try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       print('No user found for that email.');
       showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(e.code, style: TextStyle(
                              color: Colors.deepPurple
                          )),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
}
   );
      } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
       showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(e.code, style: TextStyle(
                              color: Colors.deepPurple
                          )),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
}
   );
  }
 }
}

bool switchview = true;

  void _toggle() {
    setState(() {
      switchview = !switchview;
    });
  }

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: size.height/14,),

          

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,
                child: IconButton(icon:Icon( Icons.arrow_back_ios,color: Colors.black,),
                onPressed: (){
                  Navigator.pop(context);
                },)),
            ),
            SizedBox(height: size.height/26,),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 
            

                 Text(
                   "Login",
                   style: TextStyle(fontWeight: FontWeight.bold,
                   fontSize: 24.0),
                 ),
                  SizedBox(height: size.height/200,),
             
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                        key: _loginFormKey,
                        // autovalidateMode: AutovalidateMode.always,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [



                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                controller: emailInputController,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle:
                                  TextStyle(color:  Colors.grey.shade500),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: 'johndoe@gmail.com',
                                  hintStyle: TextStyle(color: Colors.black),

                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                          color: Colors.purple)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                obscureText: switchview,
                                controller: pwdInputController,
                                
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle:
                                  TextStyle(color: Colors.grey.shade500),
                                  suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: new Icon(
                              switchview
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 15.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                  hintStyle: TextStyle(color: Colors.black),

                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                          color: Colors.purple)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent)),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),

              

              

                    SizedBox(height: size.height/60,),

                     Container(
                    height: size.height*0.08,
                    width: size.width*0.90,
                                    decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                            ),
                    child: FlatButton(
                      child: Text("Login",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 18.0,color: Colors.blueAccent))) ,
                     
                      textColor: Colors.white,
                      onPressed: () {
                        print("Login button pressed");
                        login(emailInputController.text,pwdInputController.text);
                         checkifuserloggedin();
                      },
                    ),
                  ),

                  SizedBox(height: size.height/60,),

                  Text("OR"),

                    SizedBox(height: size.height/60,),

                     Container(
                    height: size.height*0.08,
                    width: size.width*0.90,
                                    decoration: BoxDecoration(
                              color:  Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                            ),
                    child: FlatButton(
                      child: Text("Login with Phone Number",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 18.0,color: Colors.white))) ,
                     
                      textColor: Colors.white,
                      onPressed: () {
                        print("Login phone button pressed");
                         Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Signup()));
                        
                      },
                    ),
                  ),

                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}