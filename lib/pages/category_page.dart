import 'package:ecommerceapp/models/main_category_model.dart';
import 'package:ecommerceapp/screens/sub_category_screen.dart';
import 'package:ecommerceapp/services/category_service.dart';
import 'package:ecommerceapp/widgets/loader.dart';
import 'package:ecommerceapp/widgets/navigation_drawer_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategoryPage extends StatefulWidget {

  var mainCtx;
  var username;

  CategoryPage(this.mainCtx , this.username);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<CategoryPage> {

  List<MainCategories> mainCategoryList = [];
  var bannerList = [];
  bool isLoading = true;

  @override
  void initState() => {
    (() async {

      await getBannerList();

    })()

  };

  getMainCategories() async
  {
    mainCategoryList = await CategoryService.getCategoryList();
  }

  getBannerList() async
  {
    bannerList = await CategoryService.getBannerList();

    await getMainCategories();

    isLoading = false;
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: DrawerElements.getDrawer("category_page", context, widget.mainCtx , widget.username),
      ),
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          elevation: 2,
          backgroundColor: Colors.white,
          title: Text('  Categories' , style: TextStyle(color: Colors.black),),
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
        child: (!isLoading) ? ListView(
          children: [
            (bannerList != null) ? Container(
              margin: EdgeInsets.all(10),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height/4,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                itemCount: bannerList.length,
                itemBuilder: (BuildContext context, int itemIndex) =>
                    Container(
                      height: MediaQuery.of(context).size.height/5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Image.network(bannerList[itemIndex]["banner_image"] , fit: BoxFit.fill,),
                    ),
              ),
            ) : Container(),
             Container(
                margin: EdgeInsets.only(left: 5 , right: 5),
                child: new GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.5),
                  controller:  ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: mainCategoryList.map((MainCategories category) {
                    return categoryCard(category);
                  }).toList(),
                )
            )
          ],
        )  : Center(
      child: Container(
      child: Loader.getListLoader(context),
    ),
    ),
      ),
    );
  }

  Widget categoryCard(MainCategories category)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubCategoryScreen(category , widget.mainCtx , widget.username)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
          SizedBox(height: 10,),
            new Container(
              height: 100,
              margin: EdgeInsets.only(top : 10),
              child: new Center(
                  child: Image.network((category.icon).toString())
              ),
            ),
            SizedBox(height: 20,),
            FittedBox(child: Text(category.name , style: TextStyle(fontSize: 20 , fontFamily: "Lato" , fontStyle: FontStyle.values[0] , fontWeight: FontWeight.bold),)),
            SizedBox(height: 20,),
            Text('SHOP NOW'),
            Container(
              alignment: Alignment.center,
              width: 100,
              child: Divider(
                color: Colors.black,
                thickness: 3,
              ),
            )
          ],
        ),
      ),
    );
  }


}
