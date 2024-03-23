import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:varsity_app/bloc/cards_bloc/card_bloc.dart';

class SwipeCardItem extends StatefulWidget {
  SwipeCardItem({Key? key}) : super(key: key);

  @override
  _SwipeCardItemState createState() => _SwipeCardItemState();
}

class _SwipeCardItemState extends State<SwipeCardItem> {
  final controller = ConfettiController();
  bool isCelebrating = false;
  late MatchEngine _matchEngine;

  void snackBar(String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 500),
    ));
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
      margin: EdgeInsets.only(bottom: 30.h),
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      child: BlocBuilder<CardsBloc, CardsState>(builder: (context, state){
        if (state.items.isNotEmpty) {
          List<SwipeItem> _swipeItems = [];
          for (var stock in state.items) {
            _swipeItems.add(SwipeItem(
                content: stock,
                likeAction: () {
                  snackBar("Added ${stock.name} to Watchlist");
                  controller.play();
                  Future.delayed(Duration(seconds: 1)).then((value) => controller.stop());
                },
                nopeAction: () => snackBar("Not Interested in ${stock.name}"),
                superlikeAction: () => snackBar("Buying ${stock.name}"),
                onSlideUpdate: (SlideRegion? region) async {
                  print("Region $region");
                }
            ));
          }
          _matchEngine = MatchEngine(swipeItems: _swipeItems);
          BlocProvider.of<CardsBloc>(context).add(UpdateEngine(_matchEngine));
          return Stack(
              children: [
                SwipeCards(
                  matchEngine: _matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: _swipeItems[index].content.color,
                        ),
                        padding: EdgeInsets.all(1.w),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_swipeItems[index].content.symbol,
                                style: TextStyle(fontSize: 48.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent)),
                            Text(_swipeItems[index].content.name,
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.grey),
                                textAlign: TextAlign.center),
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
                  itemChanged: (SwipeItem item, int index) =>
                      print("item: ${item.content.symbol}, index: $index"),
                  leftSwipeAllowed: true,
                  rightSwipeAllowed: true,
                  upSwipeAllowed: false,
                  fillSpace: true,
                  likeTag: flag('Add to Watchlist'),
                  nopeTag: flag('Not Interested'),
                  superLikeTag: flag('Buy paper stocks'),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {_matchEngine.currentItem?.nope();},
                          child: Icon(Icons.cancel)),
                      // ElevatedButton(
                      //     onPressed: () {_matchEngine.currentItem?.superLike();},
                      //     child:Icon(Icons.add)),// Text("Superlike")),
                      ElevatedButton(
                          onPressed: () {
                            _matchEngine.currentItem?.like();
                          },
                          child: Icon(Icons.add_chart))
                    ],
                  ),
                ),
                Align(alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: controller,
                      shouldLoop: false,
                      blastDirectionality: BlastDirectionality.explosive,
                    )
                ),

              ]);
        } else
          // if (state.status.isLoading){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              )
            ],
          );
        // } else {// if (state.status.isError){
        //   return Center(child: Text('There seems to be an error getting cards, please try again later'));
        // }
    }));

  }

}
