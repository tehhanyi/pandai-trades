
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varsity_app/views/widgets/see_more.dart';
import 'package:varsity_app/views/widgets/swipe_cards_item.dart';
import '../bloc/cards_bloc/card_bloc.dart';

class LandingScreen extends StatefulWidget {
  // final List<Stocks> stocks;
  LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        children: [
          SizedBox(height: 5.5.h,),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext builderContext) {
                      return Center(
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                                width: 88.w,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: EdgeInsets.all(14.sp),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('About PandaiTrades', style: TextStyle(fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 10.sp),
                                        Text('whatever about pandaitrade is blah blah blah it is super cute and everyone should use it', style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                                        Text('Swipe Right to add security\nSwipe Left to pass a security', style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                                        SizedBox(height: 10.sp),
                                        CircleAvatar(backgroundImage: AssetImage("assets/images/logo.png"), radius: 7.w),

                                      ]),
                                ))
                          ]));
                    });
              },
              icon:  Icon(Icons.question_mark)),
              // child:,
          // IconButton(
          //     onPressed: (){
          //       ;
          //       }, icon: Icon(Icons.question_mark)),
          Spacer()
        ],
      ),
        key: _scaffoldKey,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title:Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundImage: AssetImage("assets/images/logo.png"), radius: 5.w),
                  SizedBox(width: 2.w),
                  Text('PandaiTrades', style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold))
                ])),//AppBar(title: Text(widget.title!),),
        body: Container(
            child:
                  SlidingUpPanel(
                    maxHeight: 90.h ,
                    minHeight: 10.h,
                    parallaxEnabled: true,
                    parallaxOffset: .5,
                    body: SwipeCardItem(),
                    panelBuilder: (sc) => SeeMore(sc: sc),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    onPanelOpened: () => BlocProvider.of<CardsBloc>(context).add(GetMoreInfo())
                      // await updatePanel(_matchEngine?.currentItem);
                      // _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _fabHeight;
                  ),
        ));
  }
}