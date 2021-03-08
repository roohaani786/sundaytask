import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sundaytask/src/controllers/welcome.dart';

class Welcome extends StatefulWidget{
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends StateMVC<Welcome> {

  WelcomeController _con;

  _WelcomeState() : super(WelcomeController()) {
    _con = controller;
  }

  // Future<String> checkifuserloggedin()async {
  //   FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //     return Navigator.pushNamed(context, '/Welcome');
  //   } else {
  //     print('User is signed in!');
  //     return Navigator.pushNamed(context, '/Home');
  //   }
  // });
  // }

  @override

  void initState() {
      // TODO: implement initState
      super.initState();
      // checkifuserloggedin();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return new WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(

          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height/5,),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                     Container(
                       height: size.height/4,
                      
                       child: Image.asset("assets/index.png")), 

                        SizedBox(height: size.height/8,),

                     Text(
                       "Let's Get Started",
                       style: TextStyle(fontWeight: FontWeight.bold,
                       fontSize: 20.0),
                     ),
                      SizedBox(height: size.height/20,),
                    //  SizedBox(height: size.height * 0.05),
                     
                      // SizedBox(height: size.height * 0.05),

                       Container(
                        height: size.height*0.08,
                        width: size.width*0.90,
                         decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                        child: FlatButton(
                          child: Text("Log in",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 18.0,color: Colors.blueAccent))),
                          
                          textColor: Colors.blueAccent,
                          onPressed: () {
                            print("Login button pressed");
                            Navigator.pushNamed(context, '/Login');
                          },
                        ),
                      ),

                  

                        SizedBox(height: size.height/20,),

                         Container(
                        height: size.height*0.08,
                        width: size.width*0.90,
                                        decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                        child: FlatButton(
                          child: Text("Register new account",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 18.0,color: Colors.white))) ,
                         
                          textColor: Colors.white,
                          onPressed: () {
                            print("Signup button pressed");
                            Navigator.pushNamed(context, '/Signup');
                          },
                        ),
                      ),

                    
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}