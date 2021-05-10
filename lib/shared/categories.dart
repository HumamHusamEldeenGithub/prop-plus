import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/category_module.dart';



class CategoryRadioButton extends StatefulWidget {
  final CategoryModel model;

  const CategoryRadioButton({Key key, this.model}) : super(key: key);
  @override
  _CategoryRadioButtonState createState() => _CategoryRadioButtonState();
}

class _CategoryRadioButtonState extends State<CategoryRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: widget.model.isSelected
                    ? MainTheme.mainColor
                    : MainTheme.secondaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: Icon(
                widget.model.icon,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.model.title,
            style: TextStyle(
                fontWeight: widget.model.isSelected
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
