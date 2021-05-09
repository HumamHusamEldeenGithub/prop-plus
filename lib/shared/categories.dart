import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  bool selected = false;
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: widget.selected ? Color(0xFFFF5713) : Color(0xFFFF723C),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: Icon(
                Icons.hotel,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  widget.selected = !widget.selected;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Cat name",
            style: TextStyle(
                fontWeight:
                    widget.selected ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
