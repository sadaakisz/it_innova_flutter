import 'package:flutter/material.dart';

class HeartRateIndicator extends StatelessWidget {
  final int bpm;
  const HeartRateIndicator({Key? key, required this.bpm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextStyle numberStyle =
        TextStyle(color: Colors.redAccent.shade200, fontSize: width * 0.25);
    TextStyle infoStyle =
        TextStyle(color: Colors.white, fontSize: width * 0.05);
    return Container(
      width: width,
      child: Container(
        width: width * 0.7,
        height: width * 0.7,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  bpm.toString(),
                  style: numberStyle,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                        width: width * 0.22,
                        child: Image.asset('assets/bpm.png')),
                    Container(
                        transform: Matrix4.translationValues(0, -15, 0),
                        child: Text(
                          'BPM',
                          style: infoStyle,
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(height: width * 0.03),
            Text(
              'Ritmo Cardiaco',
              style: infoStyle,
            ),
          ],
        ),
      ),
    );
  }
}
