import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aksc/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  String email,name,rollNo,section,password,department,contact,pastExp;
  bool createAcc;

  Home(this.email,this.createAcc,[this.name,this.rollNo,this.section,this.password,this.department,this.contact,this.pastExp]) : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  QuerySnapshot data;
  bool flag;
  //Map d;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 1))
        .then((_) => _buildSnackBar()
    );
    /*  getData().then((docs){
      if(docs.documents.isNotEmpty)
        {
          myFlag=true;
          d=docs.documents[0].data;
        }
      else{
        print("Documents empty");
      }
    });*/
    if (widget.createAcc == false)
    {
      getData().then((results) {
        setState(() {
          if (results.documents.isNotEmpty) {
            data = results;
            print("data=results");
          }
          else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("System Error!"),
                    content: Text(
                        "There might be a system error. Please create your account again with a different email address?"),
                    actions: <Widget>[
                      Row(
                        children: <Widget>[
                          FlatButton(
                              child: Text("Okay"),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login()));
                              }
                          ),
                        ],
                      )
                    ],
                  );
                });
          }
        });
      });
  }
  }

  _buildSnackBar(){
    _scaffoldkey.currentState.showSnackBar(
        new SnackBar(
          content: new Text("Registration Completed!"),
          backgroundColor: Colors.green,
        )
    );
  }
  getData() async {
    print("Got email ${widget.email}");
    return await Firestore.instance
        .collection("testBatch")
        .where("Email", isEqualTo: widget.email)
        .getDocuments();
  }
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation!"),
            content: Text("Do you want to Signout?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Login()));
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onBackPressed ,
      child: Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
              ),
              onPressed: _onBackPressed
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /*  Container(
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
                      Icons.cloud_done,
                      size:80,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child:Padding(
                        padding: const EdgeInsets.only(top:32,right:32),
                        child: Text("Welcome 19B!",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  )
                ],
              ),
            ),*/
              SizedBox(height: 5),
              Wrap(
                spacing: 10,
                children: <Widget>[
                  Text(
                    "  Congragulations! You're now a part of ",
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                ],
              ),
              Wrap(
                children: <Widget>[
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
                    "Acm ",
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              widget.createAcc==false?
              data!=null
                  ? Center(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 800,
                            color: Colors.transparent,
                          ),
                          Positioned(
                            top: 80,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 600,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.blue.shade900,
                                        Colors.blue
                                      ]),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(60),),
                                ),
                                child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(height: 95),
                                          Center(
                                            child: Text(
                                              "${data.documents[0]['Name']}"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                            child: Text(
                                              "${data.documents[0]['Email']}",
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Department: ${data.documents[0]['Department']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Roll No: ${data.documents[0]['RollNo']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Password: ${data.documents[0]['Password']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Section: ${data.documents[0]['Section']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Contact: ${data.documents[0]['Contact']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "PastExperience: ${data.documents[0]['PastExperience']}",
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ])),
                          ),
                          Positioned(
                            top: 2,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue.shade900,
                              maxRadius: 80,
                              child: Icon(
                                Icons.cloud_done,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(child:Text("Loading...")):
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      color: Colors.transparent,
                    ),
                    Positioned(
                      top: 80,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 600,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.shade900,
                                  Colors.blue
                                ]),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),),
                          ),
                          child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 95),
                                    Center(
                                      child: Text(
                                        "${widget.name}"
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Center(
                                      child: Text(
                                        "${widget.email}",
                                        style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Department: ${widget.department}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Roll No: ${widget.rollNo}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Password: ${widget.password}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Section: ${widget.section}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Contact: ${widget.contact}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "PastExperience: ${widget.pastExp}",
                                        style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ])),
                    ),
                    Positioned(
                      top: 2,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.shade900,
                        maxRadius: 80,
                        child: Icon(
                          Icons.cloud_done,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        /* Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              "Congragulations, you're registered with UITCSACM",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20,),
            Text("Name: Muhammad Wamiq Siddiqui",style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Text("Roll No: 16B-044-Se",style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Text("Section: B",style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Text("Department: Software Engineering",style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Text("Contact No : 03322684192",style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Text("Email Address: wamiqsiddiqui30@gmail.com",style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Text("Any past experience: Aptec Computer Science Diploma",style: TextStyle(fontSize: 18),),
          ],
        ),*/
      ),
    );
    /* return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Competetions",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
                bottom: TabBar( tabs: [
                  Tab(
                    child: Text("Competetions"),
                  ),
                  Tab(
                    child: Text("My Competetions"),
                  ),
                ]),
              ),
              body: TabBarView(children: [
                new Card(
                    child: Column(
                      children: <Widget>[
                        Text("Home")
                      ],
                    )),
                new Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "My Competetions"
                      )
                    ],
                  ),
                )
              ]),
              drawer: Drawer(
                  elevation: 10,
                  child: ListView(children: <Widget>[
                    DrawerHeader(
                      child: Image.asset("assets/acmlogo.png"),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          color: Colors.white,
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.folder,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "Announcements",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.assignment,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "Ambassadors",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.chat,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "How to Play",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.video_library,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "Sponsors",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.payment,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "EasyPaisa Payment",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "QR Code",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.feedback,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "Feedback",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.school,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      title: Material(
                          shadowColor: Colors.black12,
                          borderOnForeground: true,
                          shape: UnderlineInputBorder(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Icon(
                                  Icons.keyboard_backspace,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //SizedBox(width: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ]
                  )
              ),
            )
        )
    );*/
  }
}
