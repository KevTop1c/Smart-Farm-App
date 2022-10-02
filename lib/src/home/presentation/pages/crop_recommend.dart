import 'package:flutter/material.dart';
import 'package:farm_app/plant-info.dart';

class PlantInfo extends StatefulWidget {
  const PlantInfo({super.key});

  @override
  State<PlantInfo> createState() => _PlantInfoState();
}

class _PlantInfoState extends State<PlantInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              return Future<void>.value();
            },
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Image.asset(
                'assets/images/crop-recommend-logo2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            centerTitle: true,
            title: const Text(
              'Crop Recommendations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: const <Widget>[
                  PlantBio(
                      name: 'Apple',
                      humidity: 94.4,
                      temp: 23.84,
                      image: 'apple.jpg'),
                  PlantBio(
                      name: 'Banana',
                      humidity: 78.80,
                      temp: 27.19,
                      image: 'banana.jpg'),
                  PlantBio(
                      name: 'Chickpea',
                      humidity: 7.48,
                      temp: 17.02,
                      image: 'chickpeas.jpg'),
                  PlantBio(
                      name: 'Coconut',
                      humidity: 95.59,
                      temp: 25.00,
                      image: 'coconut.jpg'),
                  PlantBio(
                      name: 'Grapes',
                      humidity: 82.90,
                      temp: 19.20,
                      image: 'grapes.jpg'),
                  PlantBio(
                      name: 'Kidney Beans',
                      humidity: 5.56,
                      temp: 24.94,
                      image: 'kidneybeans.jpg'),
                  PlantBio(
                      name: 'Lentil',
                      humidity: 62.70,
                      temp: 18.54,
                      image: 'lentil.jpg'),
                  PlantBio(
                      name: 'Maize',
                      humidity: 72.80,
                      temp: 18.92,
                      image: 'maize.jpg'),
                  PlantBio(
                      name: 'Mango',
                      humidity: 50.91,
                      temp: 31.86,
                      image: 'mango.jpg'),
                  PlantBio(
                      name: 'Moth Beans',
                      humidity: 84.61,
                      temp: 28.63,
                      image: 'mothbeans.jpg'),
                  PlantBio(
                      name: 'Rice',
                      humidity: 84.61,
                      temp: 28.63,
                      image: 'rice.jpg'),
                  PlantBio(
                      name: 'Pomegranate',
                      humidity: 84.61,
                      temp: 28.63,
                      image: 'pomegranate.jpg'),
                  PlantBio(
                      name: 'Watermelon',
                      humidity: 84.61,
                      temp: 28.63,
                      image: 'watermelon.jpg'),
                  PlantBio(
                      name: 'Pigeon Peas',
                      humidity: 84.61,
                      temp: 28.63,
                      image: 'pigeonpeas.jpg'),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
























































// import 'package:flutter/material.dart';

// class PlantInfo extends StatefulWidget {
//   const PlantInfo({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _PlantInfoState createState() => _PlantInfoState();
// }

// class _PlantInfoState extends State<PlantInfo> {
//   late int temp;
//   late int pH;
//   late int moist;
//   late int humid;
//   bool isCompare = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(
//             parent: AlwaysScrollableScrollPhysics()),
//         slivers: <Widget>[
//           SliverAppBar(
//             stretch: true,
//             onStretchTrigger: () {
//               // Function callback for stretch
//               return Future<void>.value();
//             },
//             expandedHeight: 300.0,
//             flexibleSpace: FlexibleSpaceBar(
//               stretchModes: const <StretchMode>[
//                 StretchMode.zoomBackground,
//                 StretchMode.blurBackground,
//                 StretchMode.fadeTitle,
//               ],
//               centerTitle: true,
//               title: const Text('Crop Recommendations'),
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: <Widget>[
//                   Image.asset(
//                     'assets/plant6.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                   const DecoratedBox(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment(0.0, 0.5),
//                         end: Alignment.center,
//                         colors: <Color>[
//                           Color(0x60000000), //Colors.black45,
//                           Color(0x00000000),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 Column(
//                   children: const <Widget>[
//                      ListTile(
//                       leading: Icon(Icons.wb_sunny),
//                       title: Text('Tomato'),
//                       subtitle: Text(
//                           'sunny, h: 80, t: 10-30, m: 4000-6000mm3/ha, pH: 6.0-6.5, CO2: 400ppm'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.wb_sunny_outlined),
//                       title: Text('Lettuce'),
//                       subtitle: Text(
//                           'rainy, h: 70, t: 10-20, m: 370-600mm, pH: 5.5-6.5, CO2: 400ppm'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.wb_sunny_sharp),
//                       title: Text('Maize'),
//                       subtitle: Text(
//                           'dry, h: 70, t: 10-32, m: 4000-6000m3/ha, pH: 6.0-6.5, CO2: 400ppm'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.wb_sunny_outlined),
//                       title: Text('Eggplant'),
//                       subtitle: Text(
//                           'wet, h: 80, t: 10-30, m: 350-550mm, pH: 6.0-7.5, CO2: 400ppm'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.wb_sunny_outlined),
//                       title: Text('Banana'),
//                       subtitle: Text(
//                           'wet, h: 90, t: 23-30, m: <10000m3/ha, pH: 5.5-6.5, CO2: 400ppm'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.wb_sunny_outlined),
//                       title: Text('Onion'),
//                       subtitle: Text(
//                           'wet, h: 90, t: 15-25, m: 350-550, pH: 6-7, CO2: 400ppm'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.wb_sunny_outlined),
//                       title: Text('Cucumber'),
//                       subtitle: Text(
//                           'wet, h: 90, t: 19-28, m: 25-50mm, pH: 6.0-6.8, CO2: 400ppm'),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.wb_sunny_outlined),
//                       title: Text('Pepper'),
//                       subtitle: Text(
//                           'wet, h: 90, t: 13-40, m: 4000-6000m3/ha, pH: 6.5-7.5, CO2: 400ppm'),
//                     ),

//                     // ListTiles++
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }