import 'dart:convert';

import 'package:etos_tes/CustomWidget/CustomAppBar.dart';
import 'package:etos_tes/CustomWidget/CustomShape.dart';
import 'package:etos_tes/CustomWidget/ResponsiveWidget.dart';
import 'package:etos_tes/CustomWidget/textformfield.dart';
import 'package:etos_tes/Network/ApiClient.dart';
import 'package:etos_tes/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}


double height, width;

class _RegisterScreen extends State<RegisterScreen>  {
  ApiClient apiClient = new ApiClient();
  var firstColor = Color(0xff5b86e5),
      secondColor = Color(0xff36d1dc);
  TextEditingController namacontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController alamatcontroller = new TextEditingController();
//  TextEditingController emailcontroller = new TextEditingController();

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getProv();
  }

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88,child: CustomAppBar()),
//                clipShape(),
                form(context),
//                acceptTermsTextRow(),
                SizedBox(height: _height/35,),

//                ListProv(),
//                ListKota(),

                button(context),
                SizedBox(height: _height/35,),

//                infoTextRow(),
//                socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large? _height/8 : (_medium? _height/7 : _height/6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large? _height/12 : (_medium? _height/11 : _height/10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
              onTap: (){
                print('Adding photo');
              },

              child: Icon(Icons.add_a_photo, size: _large? 40: (_medium? 33: 31),color: Colors.orange[200],)),
        ),
//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      ],
    );
  }

  Widget form(BuildContext context2) {
    return Container(
      margin: EdgeInsets.only(
          left:_width/ 12.0,
          right: _width / 12.0,
          top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            namaTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height/ 60.0),
            // tglFormField(context2),
            // SizedBox(height: _height / 60.0),
            PasswordTextFormField(),
            SizedBox(height: _height / 60.0),
            alamatTextFormField(),
            SizedBox(height: _height / 60.0),
//            tglTextFormField(),
          ],
        ),
      ),
    );
  }



  Widget namaTextFormField() {
    return CustomTextField(
      textEditingController: namacontroller,
      enabled: false,
      keyboardType: TextInputType.text,
      icon: Icons.perm_contact_calendar,
      hint: "Nama Anda",
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      textEditingController: emailcontroller,
      enabled: false,
      keyboardType: TextInputType.text,
      icon: Icons.email,
      hint: "Email Anda",
    );
  }

  Widget PasswordTextFormField() {
    return CustomTextField(
      textEditingController: passwordcontroller,
      enabled: false,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      icon: Icons.keyboard_hide,
      hint: "Password Anda",
    );
  }

  Widget alamatTextFormField() {
    return CustomTextField(
      textEditingController: alamatcontroller,
      enabled: false,
      keyboardType: TextInputType.streetAddress,
      icon: Icons.home,
      hint: "Alamat Anda",
    );
  }



  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.orange[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: _large? 12: (_medium? 11: 10)),
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context2) {
    return Container(
      margin: EdgeInsets.only(top: 30, ),
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () async {
          if(namacontroller.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Mohon isi nama terlebih dahulu ",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
  //              timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(emailcontroller.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Mohon isi email terlebih dahulu ",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
  //              timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(passwordcontroller.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Mohon isi password terlebih dahulu ",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
  //              timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(alamatcontroller.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Mohon isi alamat terlebih dahulu ",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
  //              timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else{
            // showAlertDialog(context2);
            await DaftarMember(namacontroller.text, emailcontroller.text, passwordcontroller.text, alamatcontroller.text, context2);
            // Navigator.pop(context);

          }

        },
        textColor: Colors.white,
        padding: EdgeInsets.all(0.0),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width:_height*0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
              colors: <Color>[Colors.orange[200], Colors.pinkAccent],
            ),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Text('DAFTAR', style: TextStyle(fontSize: 18),),
        ),
      )
      ,
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
//              Navigator.of(context).pop();
              print("Routing to Sign up screen");
            },
            child: Text(
              "Daftar",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.orange[200], fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  DaftarMember(String nama, email, password, alamat, BuildContext context2) async {
    print("nama:"+nama+"||email:"+email+"||password:"+password+"||alamat:"+alamat);
    print(apiClient.getBaseUrl()+"User/add_user");
    http.post(apiClient.getBaseUrl()+"User/add_user", headers: {
      'Accept': 'application/json',
//      'authorization': apiConfig.getBasicAuth()
    }, body: {
      "nama": nama,
      "email": email,
      "password": password,
      "alamat": alamat,

    }).then((response) {
      // Navigator.pop(context2);
      // Navigator.pop(context);

      //check response status, if response status OK
   print("Response Status : "+response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["status"] == true) {
//          print(data['mobiletoken']);

          Fluttertoast.showToast(
              msg: data['info'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
//              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );

        } else {
          Fluttertoast.showToast(
              msg: data['info'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
//              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print(data['info']);

        }

      }
    }
    );
  }

  DaftarMember2(String id, nik, nama, tgl, kota, gaji) async {
    print("id:"+id+"||nik:"+nik+"||nama:"+nama+"||tgl:"+tgl+"||kota:"+kota+"||gaji:"+gaji);
    print(apiClient.getBaseUrl()+"Mahasiswa/add_karyawan");
    http.post(apiClient.getBaseUrl()+"Mahasiswa/add_karyawan", headers: {
      'Accept': 'application/json',
//      'authorization': apiConfig.getBasicAuth()
    }, body: {
      "id": id,
      "nik": nik,
      "nama": nama,
      "tgl_lahir": tgl,
      "kota": kota,
      "gaji": gaji,
    }).then((response) {
      //check response status, if response status OK
//    print("Response Status : $res");
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {

        if (data["status"] == true) {
//          print(data['mobiletoken']);

          Fluttertoast.showToast(
              msg: "Berhasil Menambahkan Karyawan",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
//              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );

        } else {
          Fluttertoast.showToast(
              msg: "Mohon Maaf Terjadi Kesalahan",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
//              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print(data['info']);
        }

      }
    }
    );
  }


}
