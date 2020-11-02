import 'package:ecommerceapp/services/auth_service.dart';
import 'package:ecommerceapp/widgets/routes.dart';
import 'package:flutter/material.dart';

class DrawerElements {


  static getDrawer(pageName , BuildContext context,  mainCtx , name , email)  {

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child : Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: Image.asset('images/profile_default.png', scale: 3,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      )
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(child: Text('${name}' , style: TextStyle(fontSize: 20 , color: Colors.white),)),
                        Container(
                            width: 170,
                            child: Text('${email}' , style: TextStyle(fontSize: 14 , color: Colors.white)))
                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 112, 76, 1),
          ),
        ),
        ...Routes.getUserRoutes(context, pageName , mainCtx),                 //assigned collection of navigation elements
        ListTile(
          title: Text("Logout"),
          leading: Icon(Icons.refresh),
          onTap: (){
            AuthService.logout(mainCtx);
          },
        ),
      ],
    );
  }


}