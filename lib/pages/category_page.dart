import 'package:ecommerceapp/models/home_model.dart';
import 'package:ecommerceapp/models/main_category_model.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/buy_screen.dart';
import 'package:ecommerceapp/screens/product_screen.dart';
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
  var email;

  CategoryPage(this.mainCtx , this.username , this.email);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<CategoryPage> {


  List<HomeCategories> mainList ;


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
    mainList = await CategoryService.getNewHome();
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

    return Scaffold(
      drawer: Drawer(
        child: DrawerElements.getDrawer("category_page", context, widget.mainCtx , widget.username , widget.email),
      ),
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          elevation: 2,
          backgroundColor: Colors.lightBlue,
          title: Center(child: Text('Categories' , style: TextStyle(color: Colors.white),)),
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
      child:  (!isLoading) ? ListView(
        children: [
          buildBannerLayout(),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
                shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            itemCount: mainList.length,
            itemBuilder: (BuildContext context , int index)
            {
              return buildCategoryView(mainList[index]);
            }
            ),
          ),
        ],
      )
             : Center(
      child: Container(
      child: Loader.getListLoader(context),
    ),
    ),
    ),



    );
  }


  Widget buildCategoryView(HomeCategories categoryObject)
  {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: categoryObject.subcat.length,
        itemBuilder: (BuildContext ctx , int index)
        {
          return Container(
            margin: EdgeInsets.only(top: 20 , left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${categoryObject.subcat[index].name}'  , style: TextStyle(fontSize: 20 , fontFamily: "Lato" , fontStyle: FontStyle.values[0] , fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(categoryObject.subcat[index].productList , widget.mainCtx  , widget.username , widget.email)
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Text("See more >" , style: TextStyle(color: Colors.deepOrangeAccent , fontWeight: FontWeight.w500 , fontSize: 14),),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                buildSubCatView(categoryObject.subcat[index].productList),
              ],
            ),
          );
        }
    );
  }

  Widget buildSubCatView(List<ProductModel> productsObject) {
    return Container(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: productsObject.length,
          itemBuilder: (BuildContext ctx , int index)
          {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BuyScreen(widget.mainCtx , productsObject[index] , 1 , widget.username , widget.email)
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Card(
                      elevation: 2,
                      child: Container(
                        margin: EdgeInsets.only(right:20),
                        width: 150,
                        height: 120,
                        child: Image.network(productsObject[index].prod_image,),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 40,
                    width: 140,
                    child: Text('${productsObject[index].prod_name}' , overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 15 , color: Colors.black , fontWeight: FontWeight.w400),)),
              ],
            );

          }
      ),
    );
  }

  buildBannerLayout()
  {
    return (bannerList != null) ? Container(
      height: 200,
      margin: EdgeInsets.only(left: 10 , right: 10 , top: 30),
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
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Image.network(bannerList[itemIndex]["banner_image"],fit: BoxFit.fill,
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                    ),
                  );
                },
              ),

            ),
      ),
    ) : Container();
  }


}
