import 'package:flutter/material.dart';
import 'package:ozzyschedule/AppBody.dart';
import 'package:ozzyschedule/Datebase/CategoryHelper.dart';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Category.dart';
import 'package:ozzyschedule/Screens/Category/CategoryDetail.dart';
import 'package:ozzyschedule/Screens/Category/DeleteCategory.dart';
import 'package:ozzyschedule/Screens/Category/add_category_page.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  DbHelper dbHelper = new DbHelper();
  CategoryHelper categoryHepler = new CategoryHelper();
  List<Category> categories;
  int counter = 0;

  String active = "Active";
  String passive = "Passive";

  var firstvalue;
  String lastvalue;

  @override
  Widget build(BuildContext context) {
    if (categories != null) {
      categories.sort((a, b) => a.categoryName.compareTo(b.categoryName));
    }

    if (categories == null) {
      categories = new List<Category>();
      listTask();
    }

    return AppBody(
        body: Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: categoryListItems(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: AddCategoryPage(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))));
              });
        },
        child: Icon(Icons.add),
      ),
    ));
  }

  ListView categoryListItems() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Color.fromRGBO(236, 240, 241, 1.0),
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text(this.categories[position].categoryName[0]),
              ),
              title: Text(this.categories[position].categoryName),
              onTap: () {
                openCategoryDetail(this.categories[position]);
              },
              onLongPress: () {
                deleteCategory(this.categories[position]);
              },
            ));
      },
      itemCount: counter,
    );
  }

  void listTask() {
    try {
      var db = dbHelper.initializeDb();
      db.then((result) {
        var category = categoryHepler.categoryGet();
        category.then((data) {
          List<Category> categoryData = new List<Category>();
          counter = data.length;
          for (var i = 0; i < counter; i++) {
            categoryData.add(Category.fromObject(data[i]));
          }

          setState(() {
            categories = categoryData;
            counter = counter;
            print("Count of Listed category : $counter");
          });
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void openCategoryDetail(Category category) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: CategoryDetail(category),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))));
        });
  }

  void deleteCategory(Category category) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: DeleteCategory(category),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))));
        });
  }
}
