import 'package:flutter/material.dart';

class ProgressDialog  extends StatelessWidget {

  final String messaage;
  ProgressDialog({required this.messaage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Dialog(
        backgroundColor: Colors.yellow,
        child: Container(
          margin: EdgeInsets.all(15.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white
          ),
          child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Colors.black
                ),
              ),
              SizedBox(width: 25.0,),
              Text(
                messaage,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
