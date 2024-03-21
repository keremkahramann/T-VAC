import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:t_vac/firebase_options.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
    //  PersistentTabController controller;

    // controller = PersistentTabController(initialIndex: 0);

    // return PersistentTabView(
    //   context,
    //   screens: [],
    //   controller: controller,
    //   confineInSafeArea: true,
    //   backgroundColor: Colors.white, // Default is Colors.white.
    //   handleAndroidBackButtonPress: true, // Default is true.
    //   resizeToAvoidBottomInset:
    //       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //   stateManagement: true, // Default is true.
    //   hideNavigationBarWhenKeyboardShows:
    //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //   decoration: NavBarDecoration(
    //     borderRadius: BorderRadius.circular(10.0),
    //     colorBehindNavBar: Colors.white,
    //   ),
    //   popAllScreensOnTapOfSelectedTab: true,
    //   popActionScreens: PopActionScreensType.all,
    //   itemAnimationProperties: ItemAnimationProperties(
    //     // Navigation Bar's items animation properties.
    //     duration: Duration(milliseconds: 200),
    //     curve: Curves.ease,
    //   ),
    //   screenTransitionAnimation: ScreenTransitionAnimation(
    //     // Screen transition animation on change of selected tab.
    //     animateTabTransition: true,
    //     curve: Curves.ease,
    //     duration: Duration(milliseconds: 200),
    //   ),
    //   navBarStyle:
    //       NavBarStyle.style1, // Choose the nav bar style with this property.
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    QuickAlert.show(context: context, type: QuickAlertType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
