import 'dart:io';

import 'package:ecommerceapp/utils/ApiConstants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyScreen extends StatefulWidget {

  var mainCtx;
  PolicyScreen(this.mainCtx);

  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {

  @override
  void initState() => {
    (() async {

      if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    })()

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          elevation: 2,
          backgroundColor: Colors.white,
          title: Text('  Policy' , style: TextStyle(color: Colors.black),),
          actions : <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: Colors.white,
//              child: Image.network("")),
                child: Image.asset("images/profile_default.png" , fit: BoxFit.fill,),
              ),)
          ]
      ),
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: ApiConstants.PRIVACY_POLICY,
        ),
      ),
    );
  }
}
