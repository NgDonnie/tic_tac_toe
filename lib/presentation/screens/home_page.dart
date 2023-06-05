import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Create a 3x3 board
  // Each cell will be represented by a string
  List<List<String>> _board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  // Keep track of the current player (a player can be 'X' or 'O')
  String _player = 'X';
  String _result = '';
  int oScore = 0;
  int xScore = 0;

  // Make a move
  // This function will be called when a player taps on a cell
  void _play(int row, int col) {
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = _player;
        _checkWin();
        if (_result == '') {
          _player = _player == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  // Check if there is a winner
  // This function will be called after every move
  void _checkWin() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2] &&
          _board[i][0] != '') {
        _result = '${_board[i][0]} wins!';
        _setWinCount(_result);
        return;
      }
      if (_board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i] &&
          _board[0][i] != '') {
        _result = '${_board[0][i]} wins!';
        _setWinCount(_result);
        return;
      }
    }
    if (_board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] &&
        _board[0][0] != '') {
      _result = '${_board[0][0]} wins!';
      _setWinCount(_result);
      return;
    }
    if (_board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0] &&
        _board[0][2] != '') {
      _result = '${_board[0][2]} wins!';
      _setWinCount(_result);
      return;
    }





    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          return;
        }
      }
    }
    _result = 'Draw!';

    
  }

  void _setWinCount(String value){

    if (value == 'X wins!') {
      //print('If X');
      xScore++;      
    } else if (value == 'O wins!'){
      oScore++;
      //print('If Y');            
    }

    return;


  }

  // Reset the game
  // This function will be called when the reset button is pressed
  void _reset() {
    setState(() {
      _board = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
      _player = 'X';
      _result = '';
    });
  }

  // Reset the game
  // This function will be called when the reset button is pressed
  void _resetScore() {
    
     setState(() {
          xScore = 0;
          oScore = 0;    
        });     
      /* if (_board.isEmpty) {
        setState(() {
          xScore = 0;
          oScore = 0;    
        });        
      } else if(_board.isNotEmpty) {
        showDialog(
          context:context,
          builder:(context) {
            return AlertDialog(
            title: const Text('ERROR - CANNOT CLEAR SCORE'),
            content: const Text('Please reset board first'),
            actions: <Widget>[
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () =>  Navigator.pop(context),
                      ),
                    ],
            );
          });
      }
   */
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Draw the board
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                'Player 1: ${xScore.toString()}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
              'Player 2: ${oScore.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
              ],
            ),
          ),
          
          Expanded(
            child: Container(
              //color: Colors.red,
              child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 25.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () => _play(row, col),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      color: _board[row][col] == 'X'
                          ? Colors.red
                          : _board[row][col] == 'O'
                              ? Colors.blue
                              : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col],
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
              ),
            ),
          ),

          // Display the current player
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              //color: Colors.blue,
              //height: 100.0,
              padding: const EdgeInsets.all(10.0),
              child: Text(
              'Player $_player turn',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ),

          // Display the result
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Container(
              //height: 30.0,
              padding: const EdgeInsets.all(10.0),
              child: Text(
              _result,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: _result == '' ? Colors.transparent : Colors.blue,
              ),
              ),
            ),
          ),

          // Reset button
          Container(
            
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
            onPressed: _reset,
            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
            onPressed: _resetScore,
            child: const Text(
              'Clear Score',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ),
        ],
      ),
      );
    }
  

 
}


