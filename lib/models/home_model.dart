import 'package:ecommerceapp/models/product_model.dart';

class HomeCategories{
  List<SubCat> subcat;

  HomeCategories(obj)
  {
    this.subcat = SubCat.fromJSONList(obj["subcat"]);
  }


  static fromJSONList(list)
  {
    List<HomeCategories> newList = [];

    list.forEach((element) {
      newList.add(new HomeCategories(element));
    });
    return newList;
  }

}

class SubCat{
  List<ProductModel> productList;
  String name;


  SubCat(obj)
  {
    this.name = obj["subcat_name"];
    this.productList = ProductModel.fromJSONList(obj["product"]);
  }


  static fromJSONList(list)
  {
    List<SubCat> newList = [];

    list.forEach((element) {
      newList.add(new SubCat(element));
    });
    return newList;
  }

}