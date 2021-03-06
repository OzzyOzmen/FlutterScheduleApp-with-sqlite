import 'package:flutter/material.dart';
import 'package:ozzyschedule/widgets/custom_button.dart';

class CustomModalDeleteButton extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onDelete;

  CustomModalDeleteButton({@required this.onClose, @required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButton(
          onPressed: onClose,
          buttonText: "Close",
        ),
        CustomButton(
          onPressed: onDelete,
          buttonText: "Delete",
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}