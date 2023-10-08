class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardLength = 9;
  static final blocSize = 100.0;

  List<String>? board;
  static List<String> initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);

  bool winnerCheck(
      String player, int index, List<int> scoreBoard, int gridSize) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == Player.x ? 1 : -1;

    //player will win when he has same symbol row wise, column wise or  diagonal wise
    //score board has 0-8 indexes

    //first three(0-1-2) is used to define perticular row has how many same symbol
    scoreBoard[row] += score;
    //another three(3-4-5) defin perticular column has how many same sybmol
    scoreBoard[gridSize + col] += score;

    //and form last three first two (6-7) define diagonals same symbol
    if (row == col) scoreBoard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreBoard[2 * gridSize + 1] += score;

    //if any row or column of diagonal contain 3 same symbol, player win the game
    if (scoreBoard.contains(3) || scoreBoard.contains(-3)) {
      return true;
      // int winnerIndex = scoreBoard.contains(3)
      //     ? scoreBoard.indexOf(3)
      //     : scoreBoard.indexOf(-3);
      // winnerBlock(winnerIndex);
    }

    return false;
  }

  // void winnerBlock(int index) {
  //   List<int> winerBlocList = [];

  //   if (index >= 0 && index <= 2)
  //     for (int i = 0; i <= 2; i++) {
  //       winerBlocList.add(index * 3 + i);
  //     }
  //   else if (index > 2 && index <= 5)
  //     for (int i = index - 3; i <= index - 3 + 6; i = i + 3) {
  //       winerBlocList.add(i);
  //     }
  //   else
  //     if(index==6)
  //       winerBlocList.addAll([0,4,8]);
  //     else
  //       winerBlocList.addAll([2,4,6]);

  //   print(winerBlocList);
  // }
}
