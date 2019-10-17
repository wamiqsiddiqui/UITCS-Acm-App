import 'package:aksc/loader.dart';
import 'package:flutter/material.dart';
import 'package:aksc/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aksc/accountcreate.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;
  bool flag=false,loginClicked=true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  _facebookUrl() async {
    const url = "https://www.facebook.com/uitcs.acm/?epa=SEARCH_BOX";
    var results = await Connectivity().checkConnectivity();
    if (results == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Connectivity Issue!"),
              content: Text("No Internet"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Try Again!"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
    else {
      if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw "Couldnot launch";
    }
  }
  }
  _instaUrl() async{
    const url="https://instagram.com/uitcs.acm?igshid=zhiflpb7sali";
    var results = await Connectivity().checkConnectivity();
    if (results == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Connectivity Issue!"),
              content: Text("No Internet"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Try Again!"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
    else {
      if (await canLaunch(url)) {
        await launch(url);
      }
      else {
        throw "Couldnot launch";
      }
    }
  }
  _webUrl() async {
    const url = "http://uitcs.acm.org/";
    var results = await Connectivity().checkConnectivity();
    if (results == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Connectivity Issue!"),
              content: Text("No Internet"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Try Again!"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
    else {
      if (await canLaunch(url)) {
        await launch(url);
      }
      else {
        throw "Couldnot launch";
      }
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init state");
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children:<Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue
                    ]
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:40),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        FontAwesomeIcons.solidUserCircle,
                        size:60,
                        color: Colors.white,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:Padding(
                        padding: const EdgeInsets.only(top:32,right:32),
                        child: Text("Welcome 19B!",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
                      )
                    )
                  ],
                ),
              ),
              SizedBox(height:10),
              Wrap(
                children: <Widget>[
                  Text("  Login to your ",style:TextStyle(color: Colors.black87,fontSize: 18),),
                  Image.asset("assets/acmlogonew.png",width: 20,height:20,),
                  Text(" UITCS",style:TextStyle(color: Colors.black87,fontSize: 18),),
                  Text(" Acm ",style:TextStyle(color: Colors.black87,fontSize: 18),),
                  Text("Account ",style:TextStyle(color: Colors.black87,fontSize: 18),),
                ],
              ),
              SizedBox(height:10),
              Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:13,left:5),
                    child: TextFormField(
                      validator: (input) {
                        if (input.contains("@")) {
                          return null;
                        } else {
                          return "Invalid Email format";
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            size: 30,
                          ),
                          labelText: "Email",
                          hintText: "abc@gmail.com",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:13,left:5),
                    child: TextFormField(
                      validator: (input) {
                        if (input.length < 6) {
                          return "Your password must have atleast 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (input) => _password = input,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            size: 30,
                          ),
                          labelText: "Password",
                          hintText: "6 characters atleast",
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: MediaQuery.of(context).size.height/18,
                      width: MediaQuery.of(context).size.width/5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors:[
                            Colors.blue.shade800,
                            Colors.blue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: FlatButton(
                        onPressed:(){
                          signIn();
                        },
                        child: Text(
                          "Login".toUpperCase(),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  SizedBox(height: 10),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  accountcreate()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(
                           "Don't have an account?",
                           style: TextStyle(color: Colors.black87, fontSize: 17),
                         ),
                         Text(
                           " Register",
                           style: TextStyle(color: Colors.blue.shade700, fontSize: 17),
                         ),
                       ],
                    ),
                  ),
                   Visibility(
                     visible: flag,
                     child: Column(
                       children: <Widget>[
                         Loader(),
                       ],
                     ),
                   ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Contact us at: ",style: TextStyle(color: Colors.black87),),
                        SizedBox(width:6),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
                            ),
                            onPressed: _facebookUrl,
                          ),
                        ),
                        SizedBox(width:6),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 20,
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                              ),
                              onPressed: _instaUrl,
                            ),
                        ),
                        SizedBox(width:6),
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.language,
                              color: Colors.white,
                            ),
                            onPressed: _webUrl,
                          ),
                        ),
                      ],
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
  Future<FirebaseUser> signIn() async {
    FirebaseUser user;
    AuthResult result;
    final formState = _formkey.currentState;
    var results=await Connectivity().checkConnectivity();
      if (formState.validate()) {
        formState.save();
        if(results==ConnectivityResult.none){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Connectivity Issue!"),
                  content: Text("No Internet"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Try Again!"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
              );
        }
        else{
          setState(() {
            flag=true;
          });
          try {
            result = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password);
            user = result.user;
            setState(() {
              flag=false;
            });
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Home(_email,false)));
            print(user);
             return user;
          } catch (e) {
            setState(() {
              flag=false;
            });
            print("This is error: ${e.message}");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error!"),
                    //An internal error has occurred. [ 7: ]
                    content: e.message == "The email address is badly formatted."
                        ? Text("Remove extra space(s) after your email")
                        :e.message=="An internal error has occurred. [ 7: ]"? Text("No Internet"): Text("Invalid email or password"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Try Again!"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }
                );
            print(e.message);
             return null;
          }
        }
      } else {
        return null;
      }
    }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation!"),
            content: Text("Do you want to exit?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        SystemNavigator.pop();
                      }
                      ),
                  FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context,false);
                      }
                  ),
                ],
              )
            ],
          );
        });
  }
}
