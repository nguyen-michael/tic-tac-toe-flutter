import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        body: Board(),
      ),
    );
  }
}

/* 
  Spot Widget, clickable and changes look depending on game state from the app
*/

class Spot extends StatelessWidget {
  Spot({this.player, this.index});

  final int player;
  final int index;

  Color _setColor(int player) {
    if (player == 0) {
      return Colors.grey[100];
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: 100,
      ),
      child: Container(
        width: 100,
        height: 100,
        color: _setColor(player),
        margin: const EdgeInsets.all(5),
      ),
    );
  }
}

/* 
  Board widget that holds the game state and factors out the positioning of the 
  spots
 */

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List _gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  bool _currentPlayerOne = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => InkWell(
          child: Spot(
            player: _gameState[index],
            index: index,
          ),
          onTap: () {
            setState(() {
              if (_currentPlayerOne && _gameState[index] == 0) {
                _gameState[index] = 1;
                _currentPlayerOne = false;
              } else if (!_currentPlayerOne && _gameState[index] == 0) {
                _gameState[index] = 2;
                _currentPlayerOne = true;
              }
            });
          },
        ),
        itemCount: 9,
      ),
    );
  }
}
