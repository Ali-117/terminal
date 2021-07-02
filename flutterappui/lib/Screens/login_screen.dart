import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_taking_app/main.dart';
//import 'package:notes_taking_app/screens/note_list_screen.dart';
import 'package:notes_taking_app/screens/sign_up_screen.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _studentLogin=GlobalKey<FormState>();
  TextEditingController emailControler;
  TextEditingController passwordControler;
  String uid;
  //final auth=FirebaseAuth.instance;
  @override
  initState(){
    emailControler =new TextEditingController();
    passwordControler=new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color:Color(0xFF1D1E33)
          ),
          child: Form(
            key: _studentLogin,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 40,fontWeight:  FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Hello,user',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(

          child: Container(

          decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
        padding: EdgeInsets.all(20),
    child: Column(
    children: [
    Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
    BoxShadow(
    color: Color.fromRGBO(15, 35, 255, 3),
    blurRadius: 30,
    offset: Offset(5, 10),
    )
    ]),
    child: Column(
    children: [
    Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
    border: Border(
    bottom: BorderSide(color: Colors.grey[200]),
    ),
    ),
    child: TextFormField(
    controller: emailControler,
    validator: emailValidator,

    decoration: InputDecoration(
    hintText: "Enter your Email",
    hintStyle: TextStyle(color: Colors.grey),
    border: InputBorder.none),
    ),
    ),
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]),
          ),
        ),
        child: TextFormField(
          controller: passwordControler,
          validator: pwdValidator,
          obscureText: true,

          decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
        ),
      ),
    ],
    ),
    ),
      SizedBox(
        height: 10,
      ),

      GestureDetector(
        onTap: (){
          if(_studentLogin.currentState.validate()){
            FirebaseAuth.instance.signInWithEmailAndPassword(email: emailControler.text, password: passwordControler.text)
                .then((currentUser) => FirebaseFirestore.instance.collection("Notes_users")
                .doc(uid).get()
                .then((DocumentSnapshot result) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context)=>MyApp()),
            ),));
          }
          else{
            showDialog(context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("Please Enter data"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFF1D1E33),
          ),
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      GestureDetector(
        onTap: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => new SignUpScreen()));},
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFF1D1E33),
          ),
          child: Center(
            child: Text(
              "Sign-up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

    ],
    ),
        ),
          ),
          ),
                ],
            ),
          ),
        ),
    );
  }
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Email format is invalid';
  } else {
    return null;
  }
}

String pwdValidator(String value) {
  if (value.length < 8) {
    return 'Password must be longer than 8 characters';
  } else {
    return null;
  }
}

