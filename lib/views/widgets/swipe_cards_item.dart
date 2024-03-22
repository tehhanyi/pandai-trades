import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeCardItem extends StatefulWidget {
  final MatchEngine? engine;
  final List<SwipeItem> swipeItems;

  SwipeCardItem({Key? key, required this.engine, required this.swipeItems}) : super(key: key);

  @override
  _SwipeCardItemState createState() => _SwipeCardItemState();
}

class _SwipeCardItemState extends State<SwipeCardItem> {

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
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      child: SwipeCards(
        matchEngine: widget.engine!,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color:  widget.swipeItems[index].content.color,
              ),
              padding: EdgeInsets.all(1.w),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.swipeItems[index].content.symbol, style: TextStyle(fontSize: 48.sp,fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                  Text(widget.swipeItems[index].content.name,style: TextStyle(fontSize: 16.sp, color: Colors.grey),textAlign: TextAlign.center),
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
    );
  }

}
