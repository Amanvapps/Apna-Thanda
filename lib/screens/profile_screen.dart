import 'dart:convert';
import 'dart:io';

import 'package:ecommerceapp/models/user_model.dart';
import 'package:ecommerceapp/services/user_service.dart';
import 'package:ecommerceapp/utils/ApiConstants.dart';
import 'package:ecommerceapp/utils/requestHandler.dart';
import 'package:ecommerceapp/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {

  var mainCtx;
  ProfileScreen(this.mainCtx);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  User userProfile;
  final picker = ImagePicker();
  bool isLoading = true;

  @override
  void initState() => {
    (() async {
      await getProfile();


    })()

  };

  getProfile() async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');

    userProfile = await UserService.getProfile(userId);


    print(userProfile.profile_image);
    isLoading = false;
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          elevation: 2,
//          backgroundColor: Colors.white,
          title: Center(child: Text('Profile' , style: TextStyle(color: Colors.white),)),
          actions : <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: Colors.white,
//              child: Image.network("")),
                child: Image.asset("images/profile_default.png" , fit: BoxFit.fill,),
              ),
            )
          ]
      ),
      body: SafeArea(
        child: (!isLoading) ? Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50.0 , horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Profile' , style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 20.0,),
                  _profileRow(),
                  SizedBox(height: 30.0),
                  Text('Account' , style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.0,),
                  _profileAccountCard(),
                  SizedBox(height: 30.0),
                  Text('Other' , style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.0,),
                  _otherCard(),
                ],
              ),
            ),
          ),
        ) : Center(
          child: Loader.getLoader(),
        ),
      ),
    );
  }


  Widget _profileRow()
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(60.0),
                  boxShadow:[
                    BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(0,4.0),
                        color: Colors.black38
                    ),
                  ],
              ),
              child : Image.asset('images/profile_default.png',  fit: BoxFit.cover),
            ),
//            Align(
//                alignment: Alignment.bottomRight,
//                child: Container(
//                  margin: EdgeInsets.only(top: 10),
//                  width: 100,
//                  height: 100,
//                  alignment: Alignment.bottomRight,
//                    child: GestureDetector(
//                      onTap: (){
//                        updateProfile();
//                      },
//                      child: Container(
//                          padding: const EdgeInsets.all(5),
//                          decoration: BoxDecoration(
//                            color: Colors.white,
//                            shape: BoxShape.circle
//                          ),
//                          child: Icon(Icons.edit)),
//                    )))
          ],
        ),
        SizedBox(width: 20.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${userProfile.user_name}' , style: TextStyle(fontSize: 16.0 , ),),
            SizedBox(height: 10.0,),
            Text('${userProfile.mobile}' , style: TextStyle(color: Colors.grey),),
            SizedBox(height: 20.0,),
//            smallButton()
          ],
        ),
      ],
    );
  }


  Widget _profileAccountCard()
  {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical : 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.email, color: Color.fromRGBO(7, 116, 78 ,  1),),
                  SizedBox(width: 15.0,),
                  Text('${userProfile.email_id}' , style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Divider(height: 10.0,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical : 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Color.fromRGBO(7, 116, 78 ,  1),),
                  SizedBox(width: 15.0,),
                  Text('${userProfile.address}' , style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Divider(height: 10.0,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical : 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_city, color: Color.fromRGBO(7, 116, 78 ,  1),),
                  SizedBox(width: 15.0,),
                  Text('${userProfile.city}' , style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Divider(height: 10.0,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical : 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.payment, color: Color.fromRGBO(7, 116, 78 ,  1),),
                  SizedBox(width: 15.0,),
                  Text('${userProfile.pincode}' , style: TextStyle(fontSize: 16.0),),
                ],
              ),
            ),
            Divider(height: 10.0,color: Colors.grey,),
          ],
        ),
      ),
    );
  }

  Widget _otherCard()
  {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 5.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone, color: Color.fromRGBO(7, 116, 78 ,  1),),
                    SizedBox(width: 15.0,),
                    Text('${userProfile.mobile}' , style: TextStyle(fontSize: 16.0),),
                  ],
                ),
              ),
              Divider(height: 10.0,color: Colors.grey,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 5.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person, color: Color.fromRGBO(7, 116, 78 ,  1),),
                    SizedBox(width: 15.0,),
                    Text('${userProfile.user_name}' , style: TextStyle(fontSize: 16.0),),
                  ],
                ),
              ),
              Divider(height: 10.0,color: Colors.grey,),
            ],
          ),
        ),
      ),
    );
  }

  Widget smallButton()
  {
    return Container(
      height: 25.0,
      width: 60.0,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.blue
          ),
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: Center(
        child: Text('Edit' , style: TextStyle(
            color: Colors.blue , fontSize: 16.0
        ),
        ),
      ),
    );
  }

   updateProfile()
   {
     _showChoiceDialog(context);
   }

  _openGallery(BuildContext context)  async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery , imageQuality: 80 , maxHeight: 500 , maxWidth: 500);


    if(pickedFile != null)
    {
      File file = new File(pickedFile.path);
      List<int> imageBytes = await file.readAsBytes();
      String imageB64 = base64Encode(imageBytes);


      void printWrapped(String text) {
        final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
        pattern.allMatches(text).forEach((match) => print("----" + match.group(0) + "----"));
      }


      debugPrint("ioioio"  + imageB64);

      var ress = await RequestHandler.GET("updateProfile.php" , {
        "token" : "9306488494",
        "user_id" : "5",
        "data" : imageB64,
        "ops"  : "1"
      });


      print("done-----------------${ress}--");



    }
    else
      print("no-------------");




//    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async
  {
    final pickedFile = await picker.getImage(source: ImageSource.camera , imageQuality: 80 , maxHeight: 500 , maxWidth: 500);
    this.setState(() {
      if(pickedFile != null)
      {


        List<int> imageBytes = File(pickedFile.path).readAsBytesSync();
        String imageB64 = base64Encode(imageBytes);


        Navigator.of(context).pop(imageB64);

      }

    });
//    Navigator.of(context).pop();
  }


  Future<void> _showChoiceDialog(BuildContext context)
  {
    return showDialog(context : context , builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text('Choose'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Gallery" , style: TextStyle(fontSize: 20),)),
                onTap: () async {
                  var res = await _openGallery(context);


                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Camera" ,  style: TextStyle(fontSize: 20),),),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }


}
