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
