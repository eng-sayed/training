import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/controller/store_controller.dart';
import 'package:providerexample/dio_helper/dio_helper.dart';
import 'package:providerexample/provider.dart';
import 'package:providerexample/screens/products_screen.dart';
import 'package:providerexample/screens/testScreen.dart';

import 'dio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MyDioClass().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => AppProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => storeController()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: ProductScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  String title = 'k';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    getNews();
    super.initState();
  }

  getNews() async {
    Provider.of<AppProvider>(context, listen: false).getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    print("iam rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<AppProvider>(builder: (context, value, child) {
              print("provider rebuild");
              return value.allNews == null
                  ? CircularProgressIndicator()
                  : Text(
                      value.allNews!.articles!.first.title!.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductScreen()),
          );
          // // Provider.of<AppProvider>(context, listen: false).increament();
          // Provider.of<AppProvider>(context, listen: false).getAllNews();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



// 200 success
//400 bad request 
//401 unauthrized
//500 server error