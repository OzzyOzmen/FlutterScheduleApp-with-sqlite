import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/CategoryHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Category.dart';
import 'package:ozzyschedule/widgets/custom_modal_action_button.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {

String _categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Add new category",
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
            keyboardType: TextInputType.text,
            onChanged: (String value) {
              setState(() {
                _categoryName = value;
              });
            },
          ),
          SizedBox(height: 12),
         
          CustomModalActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              addCategory();
              Navigator.of(context).pop();
              Navigator.popAndPushNamed(context, '/CategoryList');
             
              
            },
          )
        ],
      ),
    );
  }

  void addCategory() async {
    CategoryHelper categoryHelper = CategoryHelper();
     Category category = new Category(_categoryName);
    try {
      if (_categoryName!= null ) {
        await categoryHelper.addCategory(category);
      } else {
        fieldError();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> fieldError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ups !! Incomplete required fields ',
              style: TextStyle(color: Colors.red)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    ' Please make sure all required fields are filled out correctly'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
