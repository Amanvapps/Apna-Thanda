import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loader {

  static getLoader() {
    return   SafeArea(
      child:  Container(
        alignment: Alignment.center,
        child: SpinKitFadingCube(
          color: Color.fromRGBO(0, 112, 76, 1),
          size: 70.0,
          // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
        ),
      ),
    );
  }

  static getListLoader(context) {
    return   SafeArea(
      child:  Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1,
            bottom: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        child: SpinKitPouringHourglass(
          color: Color.fromRGBO(0, 112, 76, 1),
          size: 40.0,
        ),
      ),
    );
  }
}