import 'package:ecommerceapp/screens/privacy_policy_screen.dart';
import 'package:ecommerceapp/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class Routes {

  static List<dynamic> getUserRoutes(var context, var pageName, var mainCtx) {
    var settingsTab = ListTile(
      title: Text("Profile"),
      leading: Icon(Icons.person),
      onTap: () {

          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(mainCtx)),
          );
      },
    );

    var policyTab = ListTile(
      title: Text("Policy"),
      leading: Icon(Icons.policy),
      onTap: () {

        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PolicyScreen(mainCtx)),
        );
      },
    );


    return [
      settingsTab,
      policyTab
    ];
  }
}

