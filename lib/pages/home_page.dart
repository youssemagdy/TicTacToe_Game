import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool ohTurn = true;

  List<String> displayExOh = [
    '', '', '',
    '', '', '',
    '', '', '',
  ];

  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);

  int ohScore = 0;
  int exScore = 0;
  int filledBox = 0;

  // // ignore: non_constant_identifier_names
  // static var MyNewFont = GoogleFonts.pressStart2p(
  //   textStyle: const TextStyle(color: Colors.black, letterSpacing: 3),
  // );
  // // ignore: non_constant_identifier_names
  // static var MyNewFontWhite = GoogleFonts.pressStart2p(
  //   textStyle: const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15),
  // );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          const SizedBox(height: 15,),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player ( X )', style: myTextStyle,),
                        const SizedBox(height: 20,),
                        Text(exScore.toString(), style: myTextStyle,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player ( O )', style: myTextStyle,),
                        const SizedBox(height: 20,),
                        Text(ohScore.toString(), style: myTextStyle,),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey),),
                    child: Center(
                      child: Text(
                        displayExOh[index],
                        style: const TextStyle(color: Colors.white, fontSize: 40,),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(' TIC TAC TOE GAME', style: myTextStyle,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index){
    setState(() {
      if (ohTurn && displayExOh[index] == ''){
        displayExOh [index] = 'O';
        filledBox += 1;
      }
      else if (!ohTurn && displayExOh[index] == ''){
        displayExOh [index] = 'X';
        filledBox += 1;
      }
      ohTurn = !ohTurn;
      _checkWine();
    });
  }

  void _checkWine (){
    // check 1st row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    // check 2st row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }

    // check 3st row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    // check 1st column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    // check 2st column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }

    // check 3st column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }

    // check diagonal
    if (displayExOh[6] == displayExOh[4] &&
        displayExOh[6] == displayExOh[2] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    // check diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    else if (filledBox == 9){
      _showDrawDialog();
    }
  }

  void _showDrawDialog (){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text(
            'DRAW',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (){
                _clearBorder();
                Navigator.pop(context);
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _showWinDialog (String winner){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            'WINNER IS: $winner',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (){
                _clearBorder();
                Navigator.pop(context);
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
    if (winner == 'O'){
      ohScore += 1;
    }
    else if (winner == 'X'){
      exScore += 1;
    }
  }

  void _clearBorder(){
    setState(() {
      for (int i = 0; i < 9; i ++){
        displayExOh[i] = '';
      }
    });
    filledBox = 0;
  }
}
