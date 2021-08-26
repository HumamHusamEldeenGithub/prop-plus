import 'package:flutter/material.dart';
import 'package:prop_plus/constant/CategoryTheme.dart';
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
      padding: const EdgeInsets.only(
          left: CategoryTheme.iconPadding, right: CategoryTheme.iconPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: CategoryTheme.iconWidth,
            decoration: BoxDecoration(
              color: widget.model.isSelected
                  ? MainTheme.mainColor
                  : MainTheme.secondaryColor,
              borderRadius: CategoryTheme.borderRadius,
            ),
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
            style: CategoryTheme.textStyle,
          ),
        ],
      ),
    );
  }
}
