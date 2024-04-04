// import 'package:flutter/foundation.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 10, left: 20),
            alignment: Alignment.topCenter,
            height: deviceHeight / 2.9,
            width: deviceWidth / 1.1,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color.fromARGB(255, 127, 198, 47),
            ),
            child: CustomPaint(
              painter: CurveCustomPainter(),
              child: const Text(
                'Analysis',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            )));
  }
}

//Analysis yazısının altına bir çizgi çekilmesi için kullanılacak
class CurveCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    canvas.drawLine(const Offset(-10, 40), const Offset(110, 40), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

//   Widget analysis = const Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [Text('a')],
//   );
// }
