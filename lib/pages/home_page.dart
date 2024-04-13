import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  int count = 1;
  bool haveWinner = false;
  String message = "";

  void changeTurn() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    count++;
    setState(() {});
  }

  void insertSimbol(int position) {
    if (board[position].isEmpty && !haveWinner) {
      board[position] = currentPlayer;
      if (count > 4) {
        haveWinner = verifyWinner(position);
        if (haveWinner) {
          message = "O Jogador $currentPlayer foi o vencedor!";
        }
      }
      changeTurn();
    }
  }

  bool verifyWinner(int position) {
    //diagonal
    //0, 4, 8  / 2,4,6
    //horizontal
    //0,1,2 / 3,4,5 / 6,7,8
    //vertical
    //0,3,6 / 1,5,7 / 2,5,8
    //
    bool iswinner = false;
    List<List<int>> possibilities = [
      [0, 4, 8],
      [2, 4, 6],
      [0, 1, 2],
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
    ];
    var filteredList =
        possibilities.where((list) => list.contains(position)).toList();

    print(position.toString());
    print(filteredList.toString());
    print(board.toString());


    for (int x = 0; x < filteredList.length; x++) {
      print(x.toString());
      print('${board[filteredList[x][0]]} == ${board[filteredList[x][1]]}');
      print('${board[filteredList[x][0]]} == ${board[filteredList[x][2]]}');

      iswinner = board[filteredList[x][0]] == board[filteredList[x][1]] &&
          board[filteredList[x][0]] == board[filteredList[x][2]];
      if (iswinner) {
        return iswinner;
      }
    }
    return false;
  }

  void reset() {
    currentPlayer = 'X';
    board = List.filled(9, '');
    message = '';
    haveWinner = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: board.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  insertSimbol(index);
                },
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    color: haveWinner ? Colors.green : Colors.black12,
                    child: Center(
                        child: Text(
                      board[index],
                      style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: haveWinner ? Colors.white : Colors.black),
                    )),
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: haveWinner,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                padding: const EdgeInsets.all(16),
                child: Text(
                  message,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style:ElevatedButton.styleFrom(
              primary: Colors.purple,
              onPrimary: Colors.white
            ),
              onPressed: () {
                reset();
              },
              child: const Text("Resetar"))
        ],
      ),
    );
  }
}
