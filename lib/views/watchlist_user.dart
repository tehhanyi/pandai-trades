import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:varsity_app/bloc/watchlist_bloc/watchlist_bloc.dart';

class WatchlistUserScreen extends StatefulWidget {
  WatchlistUserScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistUserScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistUserScreen> {

  Widget build(BuildContext context) {
    return BlocBuilder<WatchListBloc, WatchListState>(builder: (context, state){
      return Center(
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text('You have not added any securities to your watchlist yet, start swiping now!', softWrap: true, textAlign: TextAlign.center,))
      );
      // if ()
    });
  }
}