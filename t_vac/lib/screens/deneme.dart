import 'package:flutter/material.dart';

// ignore: camel_case_types
class deneme extends StatelessWidget {
  const deneme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plant Monitor'),
        ),
        body: const Center(
          child: PlantMonitorWidget(),
        ),
      ),
    );
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
    PlantInfo('Bob', 'Ficus', 40, 25, 20),
    PlantInfo('Alice', 'Palm', 60, 28, 50),
    PlantInfo(
      'Eray',
      'Erarslan',
      12,
      32,
      43,
    ),
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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
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
      ),
    );
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
