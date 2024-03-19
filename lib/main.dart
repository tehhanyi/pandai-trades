import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:varsity_app/views/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PandaiTrades',
        theme: ThemeData(
          fontFamily: 'ProximaNova',
          brightness: Brightness.dark,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primaryColor: Color(0xFF1E1E2C),
          useMaterial3: true,
        ),
        home: SplashScreen()
        // RootScreen(tab: 1),
      );
    });
  }
}


