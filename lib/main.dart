import 'package:flutter/material.dart';
import 'package:ticteatoe/theme.dart';
import 'package:ticteatoe/game_logic.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String currentPlayerSymbol = Player.x;
  bool gameOver = false;
  int turn = 0;
  String result = "";

  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    // print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Its ${currentPlayerSymbol}'s Turn",
            style: GoogleFonts.dongle(
                textStyle: TextStyle(fontSize: 60, color: Colors.white)),
          ),
          Text(result,
              style: GoogleFonts.dongle(
                  textStyle: TextStyle(
                      color: currentPlayerSymbol == Player.x
                          ? MainColor.yColor
                          : MainColor.xColor,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold))),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
                crossAxisCount: Game.boardLength ~/ 3,
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardLength, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == Player.empty) {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                game.board![index] = currentPlayerSymbol;
                                turn++;
                                gameOver = game.winnerCheck(
                                    currentPlayerSymbol, index, scoreBoard, 3);
                                if (gameOver) {
                                  result = "$currentPlayerSymbol is winner";
                                } else if (!gameOver && turn == 9) {
                                  result = "It's a draw";
                                  gameOver = true;
                                }

                                if (currentPlayerSymbol == Player.x)
                                  currentPlayerSymbol = Player.o;
                                else
                                  currentPlayerSymbol = Player.x;
                              });
                            }
                          },
                    child: Ink(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: GoogleFonts.dongle(
                              textStyle: TextStyle(
                                  color: game.board![index] == Player.x
                                      ? MainColor.xColor
                                      : MainColor.yColor,
                                  fontSize: 64.0)),
                        ),
                      ),
                    ),
                  );
                })),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: () {
              HapticFeedback.mediumImpact();

              setState(() {
                game.board = Game.initGameBoard();
                currentPlayerSymbol = Player.x;
                gameOver = false;
                turn = 0;
                result = "";
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: Icon(Icons.replay),
            label: Text("Replay the game", style: GoogleFonts.dongle(textStyle: TextStyle(fontSize: 30))),
          )
        ],
      ),
    );
  }
}
