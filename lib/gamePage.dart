import "package:flutter/material.dart";
import 'package:awesome_dialog/awesome_dialog.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePage();
}

class _GamePage extends State<GamePage> {
  final TextStyle textStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
  List<String> displayElement = ["", "", "", "", "", "", "", "", ""];
  var currentPlayer = "X";
  var xwins = 0;
  var owins = 0;
  var filledBoxes = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Player X',
                      style: textStyle,
                    ),
                    const SizedBox(height: 5),
                    Text("Wins:\t$xwins", style: textStyle)
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text('Player O', style: textStyle),
                    const SizedBox(height: 5),
                    Text("Wins:\t$owins", style: textStyle),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("Current Player:\t$currentPlayer",style:textStyle),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 370,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            displayElement[index],
                            style: const TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
                height: 36,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      _clearBoard();
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.teal),
                    ),
                    child: const Text("Clear Board")))
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (currentPlayer == "X" && displayElement[index] == "") {
        displayElement[index] = "X";
        currentPlayer = "O";
        filledBoxes++;
      } else if (currentPlayer == "O" && displayElement[index] == "") {
        displayElement[index] = "O";
        currentPlayer = "X";
        filledBoxes++;
      }

      _checkWinner();
    });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = "";
      }
      currentPlayer="X";
      filledBoxes=0;
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        title: "Success",
        desc: "$winner is Winner!!!",
        animType: AnimType.scale,
        btnCancelOnPress: () {
          _clearBoard();
          // Navigator.of(context).pop();
        },
        btnOkOnPress: () {
          _clearBoard();
          setState(() {
            currentPlayer="X";
          });
          // Navigator.of(context).pop();
        }).show();
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) {
    //       // return AlertDialog(
    //       //   title: Text("\" " + winner + " \" is Winner!!!"),
    //       //   actions: [
    //       //     ElevatedButton(
    //       //       child: Text("Play Again"),
    //       //       onPressed: () {
    //       //         _clearBoard();
    //       //         Navigator.of(context).pop();
    //       //       },
    //       //     )
    //       //   ],
    //       // );

    //     });

    if (winner == 'O') {
      owins++;
    } else if (winner == 'X') {
      xwins++;
    }
  }

  void _showDrawDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      title: "TIE",
      desc: "It's a Tie",
      animType: AnimType.scale,
      btnCancelOnPress: () {
        _clearBoard();
        // Navigator.of(context).pop();
      },
      btnOkOnPress: () {
        _clearBoard();
        // Navigator.of(context).pop();
      },
    ).show();
  }
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Draw"),
  //           actions: [
  //             ElevatedButton(
  //               child: Text("Play Again"),
  //               onPressed: () {
  //                 _clearBoard();
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }
}
