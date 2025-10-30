import 'package:booking/routes/app_routes.dart';
import 'package:booking/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookings',
      // theme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      getPages: TAppRoutes.pages,
      // routes:{
      //   '/': (context) => const HomeScreen(),
      //   '/second-screen' : (context) => const SecondScreen()
      // },
      initialRoute: TRoutes.bookingScreen,
      unknownRoute: GetPage(name: '/page-not-found',
          page: ()=> const Scaffold(body: Center(child: Text('Page not found'),))),
    );
  }
}
