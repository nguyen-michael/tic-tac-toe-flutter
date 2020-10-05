import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticky Tacky',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ticky Tacky'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Spot(
                  player: 0,
                ),
                Spot(
                  player: 1,
                ),
                Spot(
                  player: 2,
                )
              ],
            ),
            Row(
              children: [
                Spot(
                  player: 2,
                ),
                Spot(
                  player: 1,
                ),
                Spot(
                  player: 0,
                )
              ],
            ),
            Row(
              children: [
                Spot(
                  player: 1,
                ),
                Spot(
                  player: 0,
                ),
                Spot(
                  player: 2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Spot extends StatelessWidget {
  Spot({this.player});

  final int player;

  Color _setColor(int player) {
    if (player == 0) {
      return Colors.yellow[100];
    } else if (player == 1) {
      return Colors.blue[100];
    } else if (player == 2) {
      return Colors.red[100];
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 10,
        height: 100,
        color: _setColor(player),
      ),
    );
  }
}
