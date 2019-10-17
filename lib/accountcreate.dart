import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aksc/login.dart';
import 'package:aksc/home.dart';
import 'package:aksc/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class accountcreate extends StatefulWidget {
  @override
  _accountcreateState createState() => _accountcreateState();
}

class _accountcreateState extends State<accountcreate> {
  final TextEditingController nameCon = new TextEditingController();
  final TextEditingController rollCon = new TextEditingController();
  final TextEditingController sectionCon = new TextEditingController();
  final TextEditingController emailCon = new TextEditingController();
  final TextEditingController passCon = new TextEditingController();
  final TextEditingController repassCon = new TextEditingController();
  final TextEditingController depCon = new TextEditingController();
  final TextEditingController contactCon = new TextEditingController();
  final TextEditingController pastCon = new TextEditingController();

  String _name,
      _rollNo,
      _section,
      _email,
      _password,
      _retypepass,
      _department,
      _contact,
      _pastExperience;
  final GlobalKey<FormState> formkeys = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool flag = false;
  bool createAcc=true;

  @override
  Widget build(BuildContext context) {
    /* nameCon.text="";
    rollCon.text="";
    sectionCon.text="";
    emailCon.text="";
    passCon.text="";
    repassCon.text="";
    depCon.text="";
    contactCon.text="";
    pastCon.text="";*/

    // TODO: implement build
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade900, Colors.blue]),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(80)),
                ),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, right: 32),
                      child: Text(
                        "Welcome 19B!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ))),
            SizedBox(height: 10),
            Wrap(
              children: <Widget>[
                Text(
                  "  Register to be a part of ",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
                Image.asset(
                  "assets/acmlogonew.png",
                  width: 20,
                  height: 20,
                ),
                Text(
                  " UITCS",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
                Text(
                  " Acm ",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Form(
                key: formkeys,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    TextFormField(
                      controller: nameCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Name *",
                      ),
                      onSaved: (input) => _name = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Kindly fill this field";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: rollCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.perm_identity,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Roll No *",
                        hintText: "19B-000-Se",
                      ),
                      onSaved: (input) => _rollNo = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Kindly fill this field";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: sectionCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.flag,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Section *",
                        hintText: "A/B/C/D",
                      ),
                      onSaved: (input) => _section = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Kindly fill this field";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: emailCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Email *",
                        hintText: "abc@gmail.com",
                      ),
                      onSaved: (input) => _email = input,
                      validator: (input) {
                        if (input.contains("@")) {
                          return null;
                        } else {
                          return "Incorrect email format";
                        }
                      },
                    ),
                    TextFormField(
                      controller: passCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Password *",
                          hintText: "6 characters atleast"
                      ),
                      obscureText: true,
                      onSaved: (input) => _password = input,
                      validator: (input) {
                        if (input.length < 6) {
                          return "Your password must contain atleast 6 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: repassCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.security,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Re-type Password *",
                      ),
                      obscureText: true,
                      onSaved: (input) => _retypepass = input,
                      validator: (input) {
                        // keyFunc();
                        if (_password == _retypepass) {
                          return null;
                        } else {
                          return "Password didnot match";
                        }
                      },
                    ),
                    TextFormField(
                      controller: depCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_balance,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Department *",
                        hintText: "SE/CS/EE",
                      ),
                      onSaved: (input) => _department = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Kindly fill this field";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: contactCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Contact *",
                        hintText: "03123456789",
                      ),
                      onSaved: (input) => _contact = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Kindly fill this field";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: pastCon,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.brush,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Any past experience (If any)",
                        hintText: "Not more than 5 words..",
                      ),
                      onSaved: (input) => _pastExperience = input,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height / 18,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.blue.shade800,
                              Colors.blue,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: FlatButton(
                        onPressed: create,
                        child: Text(
                          "Register".toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already have an account?",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17),
                          ),
                          Text(
                            " Login",
                            style: TextStyle(
                                color: Colors.blue.shade700, fontSize: 17),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> create() async {
    DocumentReference documentReference =
        Firestore.instance.collection("testBatch").document();
    FirebaseUser user;
    AuthResult result;
    var formState = formkeys.currentState;
    var results = await Connectivity().checkConnectivity();
    if (formState.validate()) {
      formState.save();
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
            });
      } else {
        setState(() {
          flag = true;
          print("flag=true set state");
        });
        try {
          Map<String, String> participants = <String, String>{
            "Name": _name,
            "RollNo": _rollNo,
            "Section": _section,
            "Email": _email,
            "Password": _password,
            "Department": _department,
            "Contact": _contact,
            "PastExperience": _pastExperience
          };
          documentReference.setData(participants).whenComplete(() {
            print("Document added");
          }).catchError((e) => print(" Error ye hai${e.message}"));
          result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _email, password: _password);
          user = result.user;
          setState(() {
            flag = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Home(_email,true,_name,_rollNo,_section,_password,_department,_contact,_pastExperience)));
          return user;
        } catch (e) {
          setState(() {
            flag = false;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error!"),
                  content: e.message ==
                          "The email address is already in use by another account."
                      ? Text(
                          "Sorry! This email address has already been registered.")
                      : e.message == "An internal error has occurred. [ 7: ]"
                          ? Text("No Internet")
                          : Text(
                              "The email address is badly formatted"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Try Again!"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return null;
        }
      }
    } else {
      print("Didnot validate");
      return null;
    }
  }
}
