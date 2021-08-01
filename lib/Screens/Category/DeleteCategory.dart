import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/CategoryHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Category.dart';
import 'package:ozzyschedule/widgets/custom_modal_delete_button.dart';

class DeleteCategory extends StatefulWidget {
  Category category;
  DeleteCategory(this.category);

  @override
  _DeleteCategoryState createState() => _DeleteCategoryState(category);
}

class _DeleteCategoryState extends State<DeleteCategory> {
  Category category;
  _DeleteCategoryState(this.category);

  TextEditingController categoryId;
  TextEditingController categoryName;

  @override
  void initState() {
    super.initState();

    categoryId = new TextEditingController(text: '${category.categoryId}');
    categoryName = new TextEditingController(text: '${category.categoryName}');
    
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Delete This Category",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          
          Text(
            "Are you sure you want to delete this category ?",
            
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            child: CustomModalDeleteButton(
              onClose: () {
                Navigator.of(context).pop();
              },
              onDelete: () {
                deleteTask();
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, '/CategoryList');
              },
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

   void deleteTask() async {
     int id = int.parse("${categoryId.text}");
    CategoryHelper categoryHelper = new CategoryHelper();
    await categoryHelper.deleteCategory(id);
    
  }
}
