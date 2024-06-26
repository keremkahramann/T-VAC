// ignore_for_file: avoid_print, camel_case_types, unused_element, prefer_final_fields, prefer_const_constructors, unused_field, unused_import

// ignore: unnecessary_import
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/quickalert.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class blue extends StatelessWidget {
  const blue({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 118, 192, 33)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bluetooth Bağlantısı'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<BluetoothDevice> _devicesList = [];

  @override
  void initState() {
    super.initState();
  }

  void _getDevices() async {
    List<BluetoothDevice> devices = [];
    try {
      // ignore: unrelated_type_equality_checks
      if (FlutterBluetoothSerial.instance.isAvailable == 1) {
        print("calisiyor");
      }

      FlutterBluetoothSerial.instance.startDiscovery().listen((device) {
        print('devices : $devices');
        setState(() {
          _devicesList.add(device.device);
        });
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Bluetooth Error'), duration: Duration(seconds: 3)));
    }

    setState(() {
      _devicesList = devices;
    });
  }

  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    QuickAlert.show(context: context, type: QuickAlertType.success);
  }

  void _connectToDevice2(BluetoothDevice device) async {
    try {
      print('Cihaz adı: ${device.name}');
      // Bluetooth cihazına bağlanma isteği gönderilir
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(device.address);
      print(connection);
      print('Bağlantı başarı: $connection');

      // Listen for data from the Bluetooth module
      connection.input!.listen((List<int> data) {
        String receivedData = String.fromCharCodes(data);
        print('Data received: $receivedData');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DevicePage(device: device, connection: connection),
          ),
        );
        // Parse the received data
      });
    } catch (error) {
      print('Bağlantı hatası: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_devicesList[index].name ?? "Bilinmeyen cihaz"),
            subtitle: Text(_devicesList[index].address),
            onTap: () {
              // Burada seçilen cihaza bağlanma işlemlerini gerçekleştirebilirsiniz.
              // Örneğin, Navigator ile yeni bir sayfa açabilir veya cihaza bağlanabilirsiniz.
              print('Selected device: ${_devicesList[index].name}');
              _connectToDevice2(_devicesList[index]);
            },
          );
        },
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineSmall,
      //       ),
      //     ],
      //   ),
      // ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: _getDevices,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DevicePage extends StatelessWidget {
  final BluetoothDevice device;
  final BluetoothConnection connection;

  const DevicePage({super.key, required this.device, required this.connection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name ?? "bum"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connected to ${device.name}'),
            StreamBuilder<List<int>?>(
              stream: connection.input,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<int> data = snapshot.data!;
                  Uint8List uint8Data = Uint8List.fromList(data);
                  return Text(
                      'Data received: ${uint8Data.map((byte) => byte.toRadixString(16).padLeft(2, '0'))}.join('
                      ')');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
