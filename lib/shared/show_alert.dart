import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ShowAlert extends StatefulWidget{
  final String _warning ;
  ShowAlert(Key key , this._warning);

  @override
  _ShowAlertState createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  @override
  Widget build(BuildContext context) {
    bool visible = true;
    if(widget._warning !=null){
      return Visibility(
        child: Container(
          color: Colors.amberAccent,
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.error_outline),
              ),
              Expanded(
                child: AutoSizeText(
                  widget._warning,
                  maxLines: 3,
                ),

              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  setState(() {
                    visible = false;
                  });
                },
              )

            ],
          ),
        ),
        visible: visible,
      );
    }
    else
      return SizedBox(height: 0,);
  }
}