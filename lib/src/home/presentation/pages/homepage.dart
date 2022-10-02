import 'package:farm_app/src/home/presentation/pages/crop_recommend.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:wave_loading_indicator/wave_progress.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:farm_app/plants.dart';
// import 'package:flutter/src/widgets/container.dart';

import 'package:farm_app/dht.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;

  List<Plants> plants = [
    Plants(label: 'Apple', temp: 23.8494014, humidity: 94.34814995),
    Plants(label: 'Banana', temp: 27.1994597, humidity: 78.8086068),
    Plants(label: 'Blackgram', temp: 34.63880966, humidity: 72.4316115),
    Plants(label: 'Chickpea', temp: 17.02498456, humidity: 7.485996067),
    Plants(label: 'Coconut', temp: 25.00872392, humidity: 95.59224018),
    Plants(label: 'Grapes', temp: 19.2077707, humidity: 82.9042841),
    Plants(label: 'Jute', temp: 26.21312799, humidity: 81.70476368),
    Plants(label: 'Kidney Beans', temp: 24.91506728, humidity: 5.56503533),
    Plants(label: 'Lentil', temp: 18.54141834, humidity: 62.70637578),
    Plants(label: 'Maize', temp: 18.92851916, humidity: 72.80086137),
    Plants(label: 'Mango', temp: 31.86641378, humidity: 52.19331595),
    Plants(label: 'Moth Beans', temp: 27.09400578, humidity: 43.65305437),
    Plants(label: 'Mung Bean', temp: 28.6362812, humidity: 84.61431076),
    Plants(label: 'Muskmelon', temp: 29.08417927, humidity: 90.73891887),
    Plants(label: 'Orange', temp: 33.23453301, humidity: 91.06053924),
    Plants(label: 'Pawpaw', temp: 37.13165026, humidity: 94.60761797),
    Plants(label: 'Pigeon Peas', temp: 19.24462755, humidity: 50.54495302),
    Plants(label: 'Pomegranate', temp: 18.07132963, humidity: 93.14554876),
    Plants(label: 'Rice', temp: 20.87974371, humidity: 82.00274423),
    Plants(label: 'Watermelon', temp: 26.17668721, humidity: 86.7295205),
  ];

  final DatabaseReference _dhtRef =
      FirebaseDatabase.instance.ref().child('DHT');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mainScaffold();
  }

  Widget mainScaffold() {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Smart Farm'),
          bottom: TabBar(
            controller: _tabController,
            onTap: (int index) => {
              setState(() {
                tabIndex = index;
              }),
            },
            tabs: const [
              Tab(
                icon: Icon(CommunityMaterialIcons.thermometer),
              ),
              Tab(
                icon: Icon(CommunityMaterialIcons.water),
              ),
              Tab(
                icon: Icon(CommunityMaterialIcons.lightbulb),
              ),
              Tab(
                icon: Icon(CommunityMaterialIcons.water_percent),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: StreamBuilder<DatabaseEvent>(
                      stream: _dhtRef.onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data.snapshot.value != null) {
                          var dht = DHT
                              .fromJson(snapshot.data.snapshot.value['Json']);
                          return IndexedStack(
                            index: tabIndex,
                            children: [
                              temperatureLayout(dht),
                              humidityLayout(dht),
                              lightLayout(dht),
                              soilMoistureLayout(dht)
                            ],
                          );
                        } else {
                          return const Center(
                              child: Text("No data yet",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)));
                        }
                      }),
                ),
              ],
            ),
          ],
        ));
  }

  // TEMPERATURE WIDGET
  Widget temperatureLayout(DHT dht) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: const Text(
              'Temperature',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 400,
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: FAProgressBar(
                          backgroundColor: Colors.lightBlueAccent,
                          progressColor: Colors.green,
                          direction: Axis.vertical,
                          verticalDirection: VerticalDirection.up,
                          size: 120,
                          currentValue: dht.temp.roundToDouble(),
                          changeColorValue: 100,
                          changeProgressColor: Colors.red,
                          maxValue: 100,
                          displayText: "°C",
                          animatedDuration: const Duration(milliseconds: 5000)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              "${dht.temp.toStringAsFixed(2)} °C",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlantInfo()))),
                  child: const Text('Recommmend Crop'),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlantInfo()))),
                  child: const Text('Crop Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// -----------------------------------------------------------------------------
// HUMIDITY WIDGET
  Widget humidityLayout(DHT dht) {
    return Center(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: const Text(
            "Humidity",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        SizedBox(
          height: 400,
          child: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                      child: WaveProgress(
                    borderColor: Colors.lime,
                    progress: dht.humidity,
                    borderSize: 2.0,
                    size: 270,
                    foregroundWaveColor: Colors.greenAccent,
                    innerPadding: 8,
                  )),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Text(
            "${dht.humidity.toStringAsFixed(2)} %",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlantInfo()))),
                child: const Text('Recommmend Crop'),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlantInfo()))),
                child: const Text('Crop Details'),
              ),
            ],
          ),
        ),
      ],
    ));
  }
// ----------------------------------------------------------------------------
// LIGHT WIDGET
  Widget lightLayout(DHT dht) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: const Text(
              'Light',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 400,
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                        child: CircularPercentIndicator(
                      radius: 120,
                      progressColor: Colors.amber[300],
                      percent: (dht.light) / 100,
                      animation: true,
                      // center: Text('$dht.light'),
                      // animateFromLastPercent: true,
                      // restartAnimation: true,
                      animationDuration: 1000,
                      lineWidth: 25,
                      circularStrokeCap: CircularStrokeCap.round,
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              "${dht.light.toStringAsFixed(2)} %",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlantInfo()))),
                  child: const Text('Recommmend Crop'),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlantInfo()))),
                  child: const Text('Crop Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
// -----------------------------------------------------------------------------
// SOIL MOISTURE WIDGET
  Widget soilMoistureLayout(DHT dht) {
    return Center(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: const Text(
            "Soil Moisture",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        SizedBox(
          height: 400,
          child: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                      child: WaveProgress(
                    borderColor: Colors.lime,
                    progress: dht.moisture,
                    borderSize: 2.0,
                    size: 270,
                    foregroundWaveColor: Colors.brown,
                    backgroundWaveColor: Colors.brown[300],
                    innerPadding: 8,
                  )),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Text(
            "${dht.moisture.toStringAsFixed(2)} %",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlantInfo()))),
                child: const Text('Recommmend Crop'),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlantInfo()))),
                child: const Text('Crop Details'),
              ),
            ],
          ),
        ),
      ],
    ));
  }
} 











// import 'package:farm_app/src/home/presentation/widgets/custom_painter.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:farm_app/plants.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {

//   // List of plants in dataset for crop recommendation
//   List<Plants> plants = [
//     Plants(label: 'Apple', temp: 23.8494014, humidity: 94.34814995),
//     Plants(label: 'Banana', temp: 27.1994597, humidity: 78.8086068),
//     Plants(label: 'Blackgram', temp: 34.63880966, humidity: 72.4316115),
//     Plants(label: 'Chickpea', temp: 17.02498456, humidity: 7.485996067),
//     Plants(label: 'Coconut', temp: 25.00872392, humidity: 95.59224018),
//     Plants(label: 'Grapes', temp: 19.2077707, humidity: 82.9042841),
//     Plants(label: 'Jute', temp: 26.21312799, humidity: 81.70476368),
//     Plants(label: 'Kidney Beans', temp: 24.91506728, humidity: 5.56503533),
//     Plants(label: 'Lentil', temp: 18.54141834, humidity: 62.70637578),
//     Plants(label: 'Maize', temp: 18.92851916, humidity: 72.80086137),
//     Plants(label: 'Mango', temp: 31.86641378, humidity: 52.19331595),
//     Plants(label: 'Moth Beans', temp: 27.09400578, humidity: 43.65305437),
//     Plants(label: 'Mung Bean', temp: 28.6362812, humidity: 84.61431076),
//     Plants(label: 'Muskmelon', temp: 29.08417927, humidity: 90.73891887),
//     Plants(label: 'Orange', temp: 33.23453301, humidity: 91.06053924),
//     Plants(label: 'Pawpaw', temp: 37.13165026, humidity: 94.60761797),
//     Plants(label: 'Pigeon Peas', temp: 19.24462755, humidity: 50.54495302),
//     Plants(label: 'Pomegranate', temp: 18.07132963, humidity: 93.14554876),
//     Plants(label: 'Rice', temp: 20.87974371, humidity: 82.00274423),
//     Plants(label: 'Watermelon', temp: 26.17668721, humidity: 86.7295205),
//   ];

//   DatabaseReference lightRef = FirebaseDatabase.instance.ref('Light');
//   DatabaseReference soilRef = FirebaseDatabase.instance.ref('moisture');
//   DatabaseReference tempRef = FirebaseDatabase.instance.ref('temp');
//   DatabaseReference humidityRef = FirebaseDatabase.instance.ref('humidity');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white.withOpacity(0.9),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Welcome Smart Farmer',
//           style: TextStyle(color: Colors.black),
//         ),
//         toolbarHeight: 50,
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Center(
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: StreamBuilder<DatabaseEvent>(
//                       stream: tempRef.onValue,
//                       builder: (context, snapshot) {
//                         Color arcColor;
//                         if (snapshot.hasData) {
//                           if (double.parse(
//                                   snapshot.data!.snapshot.value.toString()) >
//                               30) {
//                             arcColor = Colors.red;
//                           } else if (double.parse(snapshot.data!.snapshot.value
//                                       .toString()) >
//                                   26 &&
//                               double.parse(snapshot.data!.snapshot.value
//                                       .toString()) <
//                                   30) {
//                             arcColor = Colors.blue;
//                           } else if (double.parse(
//                                   snapshot.data!.snapshot.value.toString()) <
//                               20) {
//                             arcColor = Colors.red;
//                           } else {
//                             arcColor = Colors.green;
//                           }
//                           return CustomPaint(
//                             foregroundPainter: CircleProgress(
//                                 double.parse(
//                                     snapshot.data!.snapshot.value.toString()),
//                                 true,
//                                 100,
//                                 arcColor),
//                             child: SizedBox(
//                               width: 190,
//                               height: 190,
//                               child: Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     const Text('Temperature'),
//                                     Text(
//                                       // '${tempAnimation.value.toInt()}',
//                                       snapshot.data!.snapshot.value.toString(),
//                                       style: const TextStyle(
//                                           fontSize: 50,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Text(
//                                       '°C',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       }),
//                 ),
//                 Expanded(
//                   child: StreamBuilder<DatabaseEvent>(
//                       stream: humidityRef.onValue,
//                       builder: (context, snapshot) {
//                         Color arcColor;
//                         if (snapshot.hasData) {
//                           if (double.parse(
//                                   snapshot.data!.snapshot.value.toString()) >
//                               80) {
//                             arcColor = Colors.red;
//                           } else if (double.parse(snapshot.data!.snapshot.value
//                                       .toString()) >
//                                   60 &&
//                               double.parse(snapshot.data!.snapshot.value
//                                       .toString()) <
//                                   80) {
//                             arcColor = Colors.blue;
//                           } else if (double.parse(
//                                   snapshot.data!.snapshot.value.toString()) <
//                               40) {
//                             arcColor = Colors.red;
//                           } else {
//                             arcColor = Colors.green;
//                           }
//                           return CustomPaint(
//                             foregroundPainter: CircleProgress(
//                                 double.parse(
//                                     snapshot.data!.snapshot.value.toString()),
//                                 false,
//                                 100,
//                                 arcColor),
//                             child: SizedBox(
//                               width: 190,
//                               height: 190,
//                               child: Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     const Text('Humidity'),
//                                     Text(
//                                       // '${tempAnimation.value.toInt()}',
//                                       snapshot.data!.snapshot.value.toString(),
//                                       style: const TextStyle(
//                                           fontSize: 50,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Text(
//                                       '%',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       }),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: StreamBuilder<DatabaseEvent>(
//                       stream: soilRef.onValue,
//                       builder: (context, snapshot) {
//                         Color arcColor;
//                         if (snapshot.hasData) {
//                           if (100 -
//                                   double.parse(snapshot.data!.snapshot.value
//                                       .toString()
//                                       .split(',')[1]) <
//                               40) {
//                             arcColor = Colors.red;
//                           } else if (double.parse(snapshot.data!.snapshot.value
//                                   .toString()
//                                   .split(',')[1]) <
//                               50) {
//                             arcColor = Colors.blue;
//                           } else {
//                             arcColor = Colors.green;
//                           }
//                           return CustomPaint(
//                             foregroundPainter: CircleProgress(
//                                 100 -
//                                     double.parse(snapshot.data!.snapshot.value
//                                         .toString()
//                                         .split(',')[1]),
//                                 true,
//                                 100,
//                                 arcColor),
//                             child: SizedBox(
//                               width: 190,
//                               height: 190,
//                               child: Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     const Text('Soil Moisture'),
//                                     Text(
//                                       // '${tempAnimation.value.toInt()}',
//                                       (100 -
//                                               double.parse(snapshot
//                                                   .data!.snapshot.value
//                                                   .toString()
//                                                   .split(',')[1]
//                                                   .substring(0, 3)))
//                                           .toString(),
//                                       style: const TextStyle(
//                                           fontSize: 50,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Text(
//                                       '%',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       }),
//                 ),
//                 Expanded(
//                   child: StreamBuilder<DatabaseEvent>(
//                       stream: lightRef.onValue,
//                       builder: (context, snapshot) {
//                         Color arcColor;
//                         if (snapshot.hasData) {
//                           if (double.parse(snapshot.data!.snapshot.value
//                                   .toString()
//                                   .substring(0, 3)) >
//                               50) {
//                             arcColor = Colors.red;
//                           } else if (double.parse(snapshot.data!.snapshot.value
//                                   .toString()
//                                   .substring(0, 3)) >
//                               30) {
//                             arcColor = Colors.blue;
//                           } else if (double.parse(snapshot.data!.snapshot.value
//                                   .toString()
//                                   .substring(0, 3)) <
//                               3) {
//                             arcColor = Colors.red;
//                           } else {
//                             arcColor = Colors.green;
//                           }
//                           return CustomPaint(
//                               foregroundPainter: CircleProgress(
//                                   double.parse(snapshot.data!.snapshot.value
//                                       .toString()
//                                       .substring(0, 3)),
//                                   true,
//                                   100,
//                                   arcColor),
//                               child: SizedBox(
//                                   width: 190,
//                                   height: 190,
//                                   child: Center(
//                                       child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: <Widget>[
//                                         const Text('Light'),
//                                         Text(
//                                           // '${tempAnimation.value.toInt()}',
//                                           snapshot.data!.snapshot.value
//                                               .toString()
//                                               .substring(0, 3),
//                                           style: const TextStyle(
//                                               fontSize: 50,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         const Text(
//                                           '%',
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold),
//                                         )
//                                       ]))));
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       }),
//                 ),
//               ],
//             ),
//           ]),
//         ),
//       )),
//     );
//   }
// }
