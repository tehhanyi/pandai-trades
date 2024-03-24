import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:varsity_app/views/widgets/pie_chart.dart';
import 'package:intl/intl.dart';

class UserAssetsScreen extends StatefulWidget {
  UserAssetsScreen({Key? key}) : super(key: key);

  @override
  State<UserAssetsScreen> createState() => _UserAssetsScreenState();
}

class _UserAssetsScreenState extends State<UserAssetsScreen> {

  num formatPrice(String price) => num.parse(price.replaceAll(new RegExp(r'[^0-9.]'),''));
  Widget Asset(String assetName, int holdings, String price, List<num> changes){
    List<String> dates = [
      DateFormat('dd-MM').format(DateTime(2024, 3, 20)),
      DateFormat('dd-MM').format(DateTime(2024, 3, 21)),
      DateFormat('dd-MM').format(DateTime(2024, 3, 22)),
      DateFormat('dd-MM').format(DateTime.now())];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
      child:  Row(
          children: [
            Container(
                width: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(assetName, style: TextStyle(),maxLines: 1),
                    Text('${price}',style: TextStyle(color:Colors.blueGrey),)// style: TextStyle(color: Colors.grey)
                  ],
                )),
            Container(child: Text(holdings.toString())),
            Container(
              width: 37.w,
              height: 5.h,
              child:
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: SfSparkLineChart.custom(
                      //Enable the trackball
                      trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.longPress),
                      //Enable marker
                      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.last),
                      //Enable data label
                      labelDisplayMode: SparkChartLabelDisplayMode.last,
                      xValueMapper: (int index) => dates[index],
                      yValueMapper: (int index) => changes[index],
                      dataCount: dates.length,
                      color: (formatPrice(price) > changes[changes.length-2]) ?  Colors.greenAccent : Colors.redAccent,
                    ),
                  )
                  // Text('\$${}',style: TextStyle(color: stock.info!.change.contains('-') ? Colors.red : Colors.green)),// style: TextStyle(color: Colors.grey)
                // ],
              // )
            )
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
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 5.w),
              child: Row(
                  children: [
                    Container(width: 45.w, child: Text('Assets',style: TextStyle(color:Colors.grey))),
                    Container(width: 23.w, child: Text('Holdings',style: TextStyle(color:Colors.grey))),
                    Text('5D', style: TextStyle(color:Colors.grey))
                  ]
              ),
            ),
            Asset('Apple Inc.', 3 , '\$172.28 USD', [172.28, 176.04, 171.03, 172.28]),
            Asset('BlackRock Inc', 1 , '\$824.83 USD', [804.68, 834.79, 834.47,824.83]),
            Asset('Nestle (Malaysia) Berhad', 1 , '117.90 MYR',[119.30, 117.90, 118.00, 117.90]),
          ],
        ),
    );
  }
}