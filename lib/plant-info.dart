// ignore_for_file: file_names
import 'package:flutter/material.dart';

class PlantBio extends StatelessWidget {
  const PlantBio(
      {super.key,
      required this.name,
      required this.humidity,
      required this.temp,
      required this.image});

  final String name;
  final double temp;
  final double humidity;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/$image', cacheHeight: 150, cacheWidth: 200,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Plant Name: $name'),
                    Text('Temperature: $temp'),
                    Text('Humidity: $humidity')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
