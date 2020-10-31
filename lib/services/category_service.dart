import 'package:ecommerceapp/models/home_model.dart';
import 'package:ecommerceapp/models/main_category_model.dart';
import 'package:ecommerceapp/models/sub_categories_model.dart';
import 'package:ecommerceapp/utils/ApiConstants.dart';
import 'package:ecommerceapp/utils/requestHandler.dart';

class CategoryService
{

  static const String TOKEN = "9306488494";

  static getCategoryList() async
  {
    var response = await RequestHandler.GET(ApiConstants.CATEGORIES);
    if(response["status"]=="1" && response["data"]!=null)
    {
      List<MainCategories> mainCategoryList = MainCategories.fromJSONList(response["data"]);
      return mainCategoryList;
    }
    else
      return null;

  }

  static getNewHome() async
  {
    var response = await RequestHandler.GET(ApiConstants.NEW_HOME , {
      "token" : TOKEN
    });
    if(response["status"]=="1" && response["cat"]!=null)
    {
      List<HomeCategories> mainList = HomeCategories.fromJSONList(response["cat"]);
      return mainList;
    }
    else
      return null;

  }

  static getSubCategoryList(category) async
  {
    var response = await RequestHandler.GET(ApiConstants.SUB_CATEGORIES , {
      "cat_name" : category
    });

    if(response["status"]=="1" && response["data"]!=null)
    {
      List<SubCategoriesModel> subCategoryList = SubCategoriesModel.fromJSONList(response["data"]);
      return subCategoryList;
    }
    else
      return null;

  }

  static getBannerList() async
  {
    var response = await RequestHandler.GET(ApiConstants.BANNERS , {
      "token" : TOKEN
    });

    print("banner res--${response}");

    if(response["status"] == "1")
    return response["data"];
    else
      return null;

  }

}