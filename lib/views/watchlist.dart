import 'package:flutter/cupertino.dart';

class WatchlistScreen extends StatefulWidget {
  WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  List<Widget> _renderCard(){
    return [Container(),Container()];
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _renderCard().length,
          itemBuilder: (BuildContext context, int index) => _renderCard()[index]);
    // ListView.builder(
    //   padding: const EdgeInsets.only(top: 0),
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: 1,
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) => Card(
    //     color: Colors.white70,
    //     child: ListTile(
    //       leading: CircleAvatar(
    //         child: Text("$index"),
    //       ),
    //       title: const Text("Title"),
    //       subtitle: const Text("Subtitle"),
    //     ),
    //   ),
    // )
  }
}