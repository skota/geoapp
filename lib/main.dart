import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Get Geo location"),
                onPressed: () async {
                  Position position = await Geolocator().getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);

                  print(
                      "Here are the geo coordinates: Latitude: ${position.longitude} and Longitude: ${position.longitude}");
                },
              ),
              SizedBox(height: 40),
              TextField(
                controller: address,
                decoration:
                    InputDecoration(helperText: 'Enter address to geocode'),
              ),
              SizedBox(height: 40),
              RaisedButton(
                child: Text("Geocode address"),
                onPressed: () async {
                  String addrStr = address.text;
                  List<Placemark> placemark =
                      await Geolocator().placemarkFromAddress(addrStr);
                  print(
                      "Here are the geo coordinates from address : Latitude: ${placemark.elementAt(0).position.latitude} and Longitude: ${placemark.elementAt(0).position.longitude}");
                },
              ),
            ],
          ),
        ));
  }
}
