
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../models/stocks.dart';

class LandingScreen extends StatefulWidget {
  final List<Stocks> stocks;
  LandingScreen({Key? key, required this.stocks}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<Stocks> stonks = [];
  bool isCelebrating = false;
  final controller = ConfettiController();
  // List<String> _names = [
  //   "Red",
  //   "Blue",
  //   "Green",
  //   "Yellow",
  //   "Orange",
  //   "Grey",
  //   "Purple",
  //   "Pink"
  // ];
  // List<Color> _colors = [
  //   Colors.red,
  //   Colors.blue,
  //   Colors.green,
  //   Colors.yellow,
  //   Colors.orange,
  //   Colors.grey,
  //   Colors.purple,
  //   Colors.pink
  // ];

  @override
  void initState() {
    stonks = widget.stocks;
    for (var stock in stonks) {
      _swipeItems.add(SwipeItem(
          content: stock,//Stocks(text: _names[i], color: _colors[i]),
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


  Widget flag(String text){
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Colors.green)
      // ),
      child: Text(text),
    );
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
            child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: SwipeCards(
                      matchEngine: _matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(1.w),
                          alignment: Alignment.center,
                          color: _swipeItems[index].content.color,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_swipeItems[index].content.symbol, style: TextStyle(fontSize: 48.sp,fontWeight: FontWeight.bold)),
                              Text(_swipeItems[index].content.name,style: TextStyle(fontSize: 16.sp, color: Colors.grey),textAlign: TextAlign.center),
                            ],
                          )
                        );
                      },
                      onStackFinished: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Stack Finished"),
                          duration: Duration(milliseconds: 500),
                        ));
                      },
                      itemChanged: (SwipeItem item, int index) =>  print("item: ${item.content.symbol}, index: $index"),
                      leftSwipeAllowed: true,
                      rightSwipeAllowed: true,
                      upSwipeAllowed: false,
                      fillSpace: true,
                      likeTag: flag('Add to Watchlist'),
                      nopeTag: flag('Not Interested'),
                      superLikeTag:flag('Buy paper stocks'),
                    ),
                  ),
                  Align(alignment: Alignment.topCenter,
                    child:ConfettiWidget(
                      confettiController: controller,
                      shouldLoop: false,
                      blastDirectionality: BlastDirectionality.explosive,
                    )
                  )

                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       ElevatedButton(
                  //           onPressed: () {_matchEngine!.currentItem?.nope();},
                  //           child: Text("Nope")),
                  //       ElevatedButton(
                  //           onPressed: () {_matchEngine!.currentItem?.superLike();},
                  //           child: Text("Superlike")),
                  //       ElevatedButton(
                  //           onPressed: () {
                  //             _matchEngine!.currentItem?.like();
                  //           },
                  //           child: Text("Like"))
                  //     ],
                  //   ),
                  // )
    ])));
  }
}