// ignore_for_file: avoid_web_libraries_in_flutter, unused_import, unnecessary_import


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class analysis_detail extends StatelessWidget {
  const analysis_detail({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text('Analiz Detayları'),
            ),
            extendBodyBehindAppBar: true,
            body: Expanded(
              child: Container(
                  width: deviceWidth, // üst yeşil alanın genişliği
                  height: deviceHeight, // üst yeşil alanın uzunluğu
                  alignment: AlignmentDirectional.topCenter,
                  margin: const EdgeInsets.only(bottom: 250),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/images/analysisphoto2.jpg'))),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(child: PlantMonitorWidget()),
                          ])
                    ],
                  )),
            )));
  }
}

class PlantMonitorWidget extends StatefulWidget {
  const PlantMonitorWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlantMonitorWidgetState createState() => _PlantMonitorWidgetState();
}

class _PlantMonitorWidgetState extends State<PlantMonitorWidget> {
  final List<PlantInfo> _plantInfos = [
    PlantInfo('Chester', 'Monstera', 30, 30, 10),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _plantInfos.map((PlantInfo plantInfo) {
          return PlantInfoWidget(plantInfo);
        }).toList(),
      ),
    );
  }
}

class PlantInfoWidget extends StatelessWidget {
  final PlantInfo _plantInfo;

  const PlantInfoWidget(this._plantInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(35.0),
        decoration: BoxDecoration(
          // color: const Color.fromRGBO(255, 224, 181, 1),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _plantInfo.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              _plantInfo.type,
              style: const TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Humidity: ${_plantInfo.humidity}%',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Temperature: ${_plantInfo.temperature}°C',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Light: ${_plantInfo.light}%',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              '! Move your plant to a sunny place !',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ));
  }
}

class PlantInfo {
  final String name;
  final String type;
  final int humidity;
  final int temperature;
  final int light;

  PlantInfo(this.name, this.type, this.humidity, this.temperature, this.light);
}
