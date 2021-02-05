import 'package:etos_tes/Network/ApiClient.dart';
import 'package:etos_tes/View/ViewUserScreen.dart';
import 'package:etos_tes/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nice_button/nice_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();

}

class _LoginScreen extends State<LoginScreen> {
  ApiClient apiClient = new ApiClient();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var firstColor = Color(0xff5b86e5),
      secondColor = Color(0xff36d1dc);

  authenticate(String email, String pass) async {
    print(apiClient.getBaseUrl()+"User/login");
    http.post(apiClient.getBaseUrl()+"User/login", headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "password": pass
    }).then((response) {
      //check response status, if response status OK
//    print("Response Status : $res");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["status"] == true) {

          Fluttertoast.showToast(
              msg: "Berhasil Login",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              ViewUserScreen()), (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(
              msg: data['info'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print(data['info']);
        }
//      if(data.length>0){
//        //Convert your JSON to Model here
//      }
//      else{
//        //Get Your ERROR message's here
//        var errorMessage = data["info"];
//      }
      }
    }
    );
  }

  @override
  void setState(fn) {
    // TODO: implement setState
//    if(pref.getIsLogin()=="false"){
//      print("Berhasil");
//    }else{
//      print("Gagal");
//    }

    super.setState(fn);
  }

  void BackPressed(BuildContext context2){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        MyApp()), (Route<dynamic> route) => false);
//    onBackPressed(context2, MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          BackPressed(context);
        },
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Stack(children: <Widget>[
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: new Container(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: SingleChildScrollView(
                        child: Column(
                            children: <Widget>[
                              // Image.asset(
                              //   configandro.getImageAndro+'logo.png',
                              //   height: 120,
                              //   width: 150,
                              // ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0,30,0,10),
                                child: new Text('Login Page', style: new TextStyle(
                                    fontSize: 30.0, fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                                ),
                              ),

                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(0,5,0,5),
                              //   padding: const EdgeInsets.only(bottom: 10),
                              //   child: new Text('Anggota', style: new TextStyle(
                              //       fontSize: 35.0, fontWeight: FontWeight.bold,
                              //       color: Colors.white
                              //   ),
                              //   ),
                              // ),

                              Container(

                                  margin: const EdgeInsets.fromLTRB(0,15,0,0),
                                  width: double.infinity,
                                  child:  TextField(
                                    controller: emailController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(color: Colors.white),
                                        hintText: "Email",
                                        fillColor: Colors.orangeAccent),
                                  )
                              ),

                              Container(
                                  margin: const EdgeInsets.fromLTRB(0,15,0,20),
                                  width: double.infinity,
                                  child:  TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(color: Colors.white),
                                        hintText: "Password",

                                        fillColor: Colors.orangeAccent),
                                  )
                              ),

                              NiceButton(
                                radius: 40,
                                padding: const EdgeInsets.all(15),
                                text: "Login",
                                icon: Icons.perm_contact_cal,
                                gradientColors: [secondColor, firstColor],
                                onPressed: () {

                                  if(emailController.text.isEmpty){
                                    Fluttertoast.showToast(
                                        msg: "Mohon isi email terlebih dahulu ",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        //              timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }else if(passwordController.text.isEmpty){
                                    Fluttertoast.showToast(
                                        msg: "Mohon isi password terlebih dahulu ",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        //              timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }else{
                                    authenticate(emailController.text, passwordController.text);

                                  }

                                },
                              ),

                            ]
                        )
                    )
                )
            )
          ],
          ),
        )
    );
//    return
  }
}

