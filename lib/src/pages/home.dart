

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sundaytask/src/controllers/logincontroller.dart';
import 'package:sundaytask/src/controllers/welcome.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {

  LoginController _con;

  _HomeState() : super(LoginController()) {
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



          body: Column(
            children: [
                Expanded(
                  child: ListView.builder(
                     itemCount: 12,
               itemBuilder: (BuildContext ctxt, int index) {
                   return new  Container(
              margin: new EdgeInsets.only(top: 20.0,bottom: 20.0),
              height: deviceHeight*0.16,
              width: deviceWidth*0.90,
              child: Card(
                  elevation: 1.7,
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: deviceHeight*0.12,
                            width: deviceHeight*0.12,
                            child: Image.network("https://g1.img-dpreview.com/80513CED05A944D08EDD9F1A75A58764.jpg")
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: deviceWidth * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Stock marker for beginners',
                                        style: TextStyle(fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.bold,),
                                      ),
                                    ],
                                  ),

                                ),

                                RichText(
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'lorem ipsum is simply dummy text of the printing and typieng industry',
                                        style: TextStyle(fontSize: 11.0, color: Colors.black,),
                                      ),
                                    ],
                                  ),

                                ),

                                RichText(
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Video 1 of 10',
                                        style: TextStyle(fontSize: 13.0, color: Colors.black,),
                                      ),
                                      TextSpan(
                                        text: ' . ',
                                        style: TextStyle(fontSize: 25.0, color: Colors.black,fontWeight: FontWeight.bold,),
                                      ),
                                      TextSpan(
                                        text: '817k views',
                                        style: TextStyle(fontSize: 13.0, color: Colors.black,),
                                      ),
                                    ],
                                  ),

                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  ,

              ),
            );
                    }
                  ),
                )
                
            

        
            
        
          
           

            
              // Text("Welcome"),
              // IconButton(icon:Icon( Icons.logout),color: Colors.black,
              // onPressed: (){
              //   signout();
              //   checkifuserloggedin();
              // },),

            ],
          ),
        ),
    );
  }
}