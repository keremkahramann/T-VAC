import 'package:flutter/material.dart';
import 'package:t_vac/screens/bluetooth.dart';
import 'package:t_vac/screens/deneme.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  void _onItemTapped(int index) {
    setState(() {});
    _navigateToScreen(index);
  }

  void _navigateToScreen(int index) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const deneme()));
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20),
            alignment: Alignment.topCenter,
            height: deviceHeight / 1.4,
            width: deviceWidth / 1.1,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color.fromARGB(255, 127, 198, 47),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Analizler',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.white,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // database collection length
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 == 0
                            ? Colors.green
                            : const Color.fromARGB(255, 127, 198, 47),
                        child: ListTile(
                            title: Text(
                              'Analiz ${index + 1}', //parantez içinde tarih yazmalı
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () => _onItemTapped(index)
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //       content:
                            //           Text('Tıklanan Analiz: ${index + 1}')),
                            //   );

                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
