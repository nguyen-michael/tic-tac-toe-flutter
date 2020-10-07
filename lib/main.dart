// import 'dart:html';
import 'dart:math';
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
        body: Game(),
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

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List _gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List _score = [0, 0, 0]; //p1, p2, draws
  int _count = 1;
  bool _currentPlayerOne = true;

  Widget _playerDisplay(int player, int score, bool current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Player $player"),
              Text(current ? "Your Turn!" : "Your Opponent's turn")
            ],
          ),
        ),
        Text("Wins: $score"),
      ],
    );
  }

  Widget _display() => Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Text("Game $_count."),
            Text("P1 Score: ${_score[0]}"),
            Text("P2 Score: ${_score[1]}"),
            Text("Draws: ${_score[2]}"),
          ],
        ),
      );

  Widget _controls() => ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.all(4),
        children: [
          // Reset Button
          FlatButton(
            onPressed: null,
            onLongPress: () {
              setState(() {
                _gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                _score = [0, 0, 0];
                _count = 1;
                _currentPlayerOne = true;
              });
            },
            child: Text("Hold for New Session"),
          ),
          // Next Round Button
          FlatButton(
            onPressed: () {
              setState(() {
                _gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                _count += 1;
              });
            },
            child: Text("Next Round!"),
          )
        ],
      );

  Widget _board() => Expanded(
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
                /* Check win/ draw conditions in here and set the states */
              });
            },
          ),
          itemCount: 9,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _display(),
        Transform.rotate(
          angle: pi,
          child: _playerDisplay(2, _score[1], !_currentPlayerOne),
        ),
        _controls(),
        _board(),
        _playerDisplay(1, _score[0], _currentPlayerOne),
      ],
    );
  }
}

/* Utility function that checks if a player has won */
/* Invoked right after a player plays */
bool checkWin(int player, List<int> gameState) {
  List<List<int>> winConditions = [
    [0, 4, 8],
    [2, 4, 6],
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ];

  for (List winCondition in winConditions) {
    if (gameState[winCondition[0]] == player &&
        gameState[winCondition[1]] == player &&
        gameState[winCondition[2]] == player) {
      return true;
    }
  }

  /* No win if none caught */
  return false;
}
