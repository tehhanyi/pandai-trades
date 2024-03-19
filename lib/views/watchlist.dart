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
  }

}