
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varsity_app/views/widgets/see_more.dart';
import 'package:varsity_app/views/widgets/swipe_cards_item.dart';
import '../bloc/cards_bloc/card_bloc.dart';
import '../models/stocks.dart';

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
        key: _scaffoldKey,
        appBar: null,//AppBar(title: Text(widget.title!),),
        body: Container(
            child:
                  SlidingUpPanel(
                    maxHeight: 80.h ,
                    minHeight: 10.h,
                    parallaxEnabled: true,
                    parallaxOffset: .5,
                    body: SwipeCardItem(),
                        // engine: _matchEngine, swipeItems: _swipeItems),
                    panelBuilder: (sc) => SeeMore(sc: sc),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    onPanelSlide: (double pos) =>
                      BlocProvider.of<CardsBloc>(context).add(GetMoreInfo())
                      // await updatePanel(_matchEngine?.currentItem);
                      // _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _fabHeight;
                  ),

            // DraggableHome(
            //   // leading: Text("i am leading"),
            //   title: const Text("TEst"),
            //   headerWidget:,
            //   // Container(
            //   //   color: Colors.blue,
            //   //   child: Center(
            //   //     child: Text(
            //   //       "Title",
            //   //       style: Theme.of(context)
            //   //           .textTheme
            //   //           .displayMedium!
            //   //           .copyWith(color: Colors.white70),
            //   //     ),
            //   //   ),
            //   // ),
            //   headerBottomBar:
            //   Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Icon(Icons.settings, color: Colors.white,),
            //     ],
            //   ),
            //   body: [
            //
            //   ],
            //   fullyStretchable: false,
            //   // Align(
            //         //   alignment: Alignment.bottomCenter,
            //         //   child: Row(
            //         //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         //     children: [
            //         //       ElevatedButton(
            //         //           onPressed: () {_matchEngine!.currentItem?.nope();},
            //         //           child: Text("Nope")),
            //         //       ElevatedButton(
            //         //           onPressed: () {_matchEngine!.currentItem?.superLike();},
            //         //           child: Text("Superlike")),
            //         //       ElevatedButton(
            //         //           onPressed: () {
            //         //             _matchEngine!.currentItem?.like();
            //         //           },
            //         //           child: Text("Like"))
            //         //     ],
            //         //   ),
            //         // )
            //   // expandedBody: const CameraPreview(),
            //   backgroundColor: Theme.of(context).primaryColorDark,
            //   appBarColor: Colors.greenAccent,
            // )
        ));
  }
}