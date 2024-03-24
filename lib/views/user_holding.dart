import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:varsity_app/views/widgets/pie_chart.dart';

class UserAssetsScreen extends StatefulWidget {
  UserAssetsScreen({Key? key}) : super(key: key);

  @override
  State<UserAssetsScreen> createState() => _UserAssetsScreenState();
}

class _UserAssetsScreenState extends State<UserAssetsScreen> {

  Widget Asset(String assetName, int holdings, num price, Map<DateTime,num> changes){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 5.w),
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      child:  Row(
          children: [
            Container(child: Text(holdings.toString())),
            Container(
                width: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(assetName, style: TextStyle(),maxLines: 1),
                    Text('\$${price}',style: TextStyle(color:Colors.blueGrey),)// style: TextStyle(color: Colors.grey)
                  ],
                )),
            Container(
              width: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text('\$${}',style: TextStyle(color: stock.info!.change.contains('-') ? Colors.red : Colors.green)),// style: TextStyle(color: Colors.grey)
                ],
              ))
          ]
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Row(children: [
            Text('My Holdings', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24.sp)),
            Spacer(),
            Image.asset('assets/images/panda_stonk.png', height: 12.h, fit: BoxFit.fitHeight),
          ]),
          automaticallyImplyLeading: false,
        ),
        //
        body: Column(
          children: [
            Center(child: Donut()),
            ListView(
              children: [
                Asset('Apple Inc.', 3 , 172.28, {DateTime(2024, 3, 21) : 176.04, DateTime(2024, 3, 22) : 171.03})
              ],
            )

          ],
        ));
  }
}