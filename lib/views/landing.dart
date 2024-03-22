
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:varsity_app/views/widgets/see_more.dart';
import 'package:varsity_app/views/widgets/swipe_cards_item.dart';
import '../models/stocks.dart';

class LandingScreen extends StatefulWidget {
  final List<Stocks> stocks;
  LandingScreen({Key? key, required this.stocks}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<SwipeItem> _swipeItems = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  MatchEngine? _matchEngine;
  List<Stocks> stonks = [];
  bool isCelebrating = false;
  final controller = ConfettiController();
  double _panelHeightOpen = 90.h;
  double _panelHeightClosed = 10.h;
  double _fabHeight = 15.h;

  @override
  void initState() {
    stonks = widget.stocks;
    for (var stock in stonks) {
      _swipeItems.add(SwipeItem(
          content: stock,
          likeAction: () {
            snackBar("Added ${stock.name} to Watchlist");
            controller.play();
            Future.delayed(Duration(seconds: 1)).then((value) => controller.stop());
          },
          nopeAction: () =>  snackBar("Not Interested in ${stock.name}"),
          superlikeAction: () => snackBar("Buying ${stock.name}"),
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }
          ));
    }

    controller.addListener(() {
      setState(() => isCelebrating = controller.state == ConfettiControllerState.playing);
    });

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }
  snackBar(String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 500),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: null,//AppBar(title: Text(widget.title!),),
        body: Container(
            child:
            Stack(
                children: [
                  SlidingUpPanel(
                    maxHeight: 80.h ,
                    minHeight: 10.h,
                    parallaxEnabled: true,
                    parallaxOffset: .5,
                    body: SwipeCardItem(engine: _matchEngine, swipeItems: _swipeItems),
                    panelBuilder: (sc) => SeeMore(sc: sc, swipeItem: _swipeItems[0]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    onPanelSlide: (double pos) => setState(() {
                      _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                          _fabHeight;
                    }),
                  ),
                  Align(alignment: Alignment.topCenter,
                      child:ConfettiWidget(
                        confettiController: controller,
                        shouldLoop: false,
                        blastDirectionality: BlastDirectionality.explosive,
                      )
                  )
                ])
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