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
  bool _roundEnded = false;

  Widget _playerDisplay(int player, int score, bool current) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
            color: player == 1 ? Colors.blue[300] : Colors.red[300],
            width: 1,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Player $player",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: player == 1 ? Colors.blue[400] : Colors.red[400]),
                ),
                current
                    ? Text("Your Turn!")
                    : Text(
                        "Your Opponent's turn!",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
              ],
            ),
          ),
          Text("Wins: $score"),
        ],
      ),
    );
  }

  Widget _display() => Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Game $_count"),
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
                _roundEnded = false;
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
                _currentPlayerOne = _count.isOdd;
                _roundEnded = false;
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
                if (_currentPlayerOne &&
                    _gameState[index] == 0 &&
                    !_roundEnded) {
                  _gameState[index] = 1;
                } else if (!_currentPlayerOne &&
                    _gameState[index] == 0 &&
                    !_roundEnded) {
                  _gameState[index] = 2;
                }
                // Check win/ draw conditions
                // Win Conditions
                if (_currentPlayerOne &&
                    checkWin(1, _gameState) &&
                    !_roundEnded) {
                  _score[0] += 1;
                  _roundEnded = true;
                } else if (!_currentPlayerOne &&
                    checkWin(2, _gameState) &&
                    !_roundEnded) {
                  _score[1] += 1;
                  _roundEnded = true;
                }

                // Draw Condition: All Spots played and no win caught
                if (!_gameState.contains(0) && !_roundEnded) {
                  _score[2] += 1;
                  _roundEnded = true;
                }

                // Turn over to other player once everything falls through
                if (!_roundEnded) _currentPlayerOne = !_currentPlayerOne;
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

/// Checks if a player has won.
bool checkWin(int player, List gameState) {
  List<List> winConditions = [
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

  // No win if none caught
  return false;
}
