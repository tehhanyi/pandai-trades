import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserAssetsScreen extends StatefulWidget {
  UserAssetsScreen({Key? key}) : super(key: key);

  @override
  State<UserAssetsScreen> createState() => _UserAssetsScreenState();
}

class _UserAssetsScreenState extends State<UserAssetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Row(children: [
            // Image.asset('assets/images/panda_bino.png', height: 12.h, fit: BoxFit.fitHeight),
            // SizedBox(width: 10,),
            Text('My Holdings', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24.sp)),
          ]),
          automaticallyImplyLeading: false,
        ),
        //
        body: Column(
          children: [
          ],
        )
    );
  }
}