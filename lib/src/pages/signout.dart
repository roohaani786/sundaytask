

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sundaytask/src/controllers/logincontroller.dart';
import 'package:sundaytask/src/controllers/welcome.dart';

class Signout extends StatefulWidget{
  @override
  _SignoutState createState() => _SignoutState();
}

class _SignoutState extends StateMVC<Signout> {

  LoginController _con;

  _SignoutState() : super(LoginController()) {
    _con = controller;
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> checkifuserloggedin()async {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      return Navigator.pushNamed(context, '/Welcome');
    } else {
      print('User is signed in!');
      return Navigator.pushNamed(context, '/Home');
    }
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
       var deviceHeight =  MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    // This size provide us total height and width of our screen
    return new WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(

          

          body: Align(
            alignment: Alignment.center,

          
            child: Column(
              children: [
                   SizedBox(
            height: size.height/4,
          ),
                
              
              
                Text("Log Out",style: 
                TextStyle(color: Colors.blueAccent,
                fontSize: 20.0),),
                IconButton(icon:Icon( Icons.logout,
                size: 40.0,),color: Colors.redAccent,
                onPressed: (){
                  signout();
                  checkifuserloggedin();
                },),

              ],
            ),
          ),
        ),
    );
  }
}