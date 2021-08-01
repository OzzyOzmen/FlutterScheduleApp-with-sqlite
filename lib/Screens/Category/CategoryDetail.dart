import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ozzyschedule/Datebase/CategoryHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Category.dart';
import 'package:ozzyschedule/widgets/custom_modal_action_button.dart';

class CategoryDetail extends StatefulWidget {
  Category category;
  CategoryDetail(this.category);
  @override
  _CategoryDetailState createState() => _CategoryDetailState(category);
}

class _CategoryDetailState extends State<CategoryDetail> {

  Category category;

  _CategoryDetailState(this.category);

  String _categoryName;

  TextEditingController categoryId;
  TextEditingController categoryName;

  @override
  void initState() {
    super.initState();

    categoryId = new TextEditingController(text: '${category.categoryId}');
    categoryName = new TextEditingController(text: '${category.categoryName}');
   
    if (categoryName != null) {
      _categoryName = category.categoryName;
    }
    else{
      _categoryName=_categoryName;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Category Detail",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Category Name',
              labelText: 'Category Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            controller: categoryName,
            keyboardType: TextInputType.text,
            onChanged: (d) {
              setState(() {
                _categoryName = d;
              });
            },
          ),
          
          SizedBox(
            height: 24,
          ),
          CustomModalActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              updateCategory();
              Navigator.of(context).pop();
              Navigator.popAndPushNamed(context, '/CategoryList');
            },
          )
        ],
      ),
    );
  }

  void updateCategory() async {
    try {
      
      int _categoryId = int.parse("${categoryId.text}");

      CategoryHelper categoryHelper = new CategoryHelper();
      Category category = Category.byId(_categoryId, _categoryName);
      await categoryHelper.updateCategory(category);
    } catch (e) {
      e.toString();
    }
  }

  void complateTask() {
    print("Complated...");
  }
}
