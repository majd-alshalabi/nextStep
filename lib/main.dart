import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:next_step/Screen/accountScreens/register.dart';
import 'package:next_step/Screen/accountScreens/signIn.dart';
import 'package:next_step/Screen/accountScreens/welcomeScreen.dart';
import 'package:next_step/Screen/detailsScreen.dart';
import 'package:next_step/Screen/homePage.dart';
import 'package:next_step/Screen/searchScreen.dart';
import 'package:provider/provider.dart';
import 'helper/sharedPre.dart';
import 'helper/providerHelper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider<MyHelper>(
      create: (context) => MyHelper(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return Application();
        });
  }
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  bool done = false;
  bool hasLogedIn = false;
  Future<void> checkScreen() async {
    bool hasLogedIn2 = await SharedPreHelper.getHaveLogedIn();
    if (hasLogedIn2) {
      context.read<MyHelper>().userKey = await SharedPreHelper.getUserKey();

      setState(() {
        hasLogedIn = hasLogedIn2;
      });
    }
    setState(() {
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();
    checkScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        DetailsScreen.id: (BuildContext context) => DetailsScreen(),
        SearchScreen.id: (BuildContext context) => SearchScreen(),
        HomePage.id: (BuildContext context) => HomePage(),
        Register.id: (BuildContext context) => Register(),
        SignIn.id: (BuildContext context) => SignIn(),
        WelcomeScreen.id: (BuildContext context) => WelcomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: done == true
          ? hasLogedIn == true
              ? HomePage()
              : WelcomeScreen()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
