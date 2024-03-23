import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/cards_bloc/card_bloc.dart';
import '../../models/stocks.dart';

class SeeMore extends StatefulWidget {
  // final SwipeItem? swipeItem;
  final ScrollController sc;

  SeeMore({Key? key, required this.sc}) : super(key: key);

  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {

  Widget info(String title, String desc){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 1.h),
            Text(desc, softWrap: true),
          ],
        ));
  }

  Widget stockDetails(Stocks stocks){
    List<Widget> widgets = [];
    widgets.add(Text("${stocks.symbol}", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.black)));
    widgets.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Company Logo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(stocks.details!.imagePath, width: 14.w, fit: BoxFit.cover)
              ],
            ),
          ],
        )));
    widgets.add(info("Industry", stocks.details!.industry));
    widgets.add(info("Currency", stocks.details!.currency));
    widgets.add(info("Website", stocks.details!.website));
    widgets.add(info("Market Capitalisation", "\$${stocks.details!.marketCapitalisation.toStringAsFixed(2)}"));
    widgets.add(info("Share Outstanding", "\$${stocks.details!.shareOutstanding.toStringAsFixed(2)}"));


    return ListView(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: widget.sc,
          children: [
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              alignment: Alignment.center,
              child: Text("Read more of asset", style: TextStyle(fontSize: 20.sp, color: Colors.black)),
            ),
            BlocBuilder<CardsBloc, CardsState>(builder: (context, state){
              if (state.status.isSuccess && state.currentStock != null)
                return stockDetails(state.currentStock!);
              else return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.sp),
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                    Text('Retrieving data...please wait!')
                  ]);
              }),
          ],
        ));
  }

}
