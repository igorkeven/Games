import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<Jogo>(
      create: (_) => Jogo(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    const Color corJogo = Color.fromARGB(255, 8, 67, 116);
    return MaterialApp(
      title: 'Ludo Keven',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: corJogo),
        scaffoldBackgroundColor: corJogo,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ludo club Keven'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const Color corJogador1 = Colors.blue;
    const Color corJogador2 = Colors.red;
    const Color corJogador3 = Colors.green;
    const Color corJogador4 = Colors.yellow;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 64, 178, 231),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10), // bordas arredondadas
          ),
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // ícone branco
            onPressed: () {
              // adicione a ação do botão aqui
            },
          ),
        ),
        title: Center(
            child: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        )),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 64, 178, 231),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                // adicione a ação do botão aqui
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Consumer<Jogo>(
        builder: (context, jogo, _) {
          return Column(children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: corJogador1,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Colors.grey[200], // cor de fundo do avatar
                          child: Icon(
                            Icons.person, // ícone padrão de usuário
                            color: Colors.grey[800], // cor do ícone
                            size: 50, // tamanho do ícone
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // area do dado

                    jogo.jogadorAtual == 1
                        ? GestureDetector(
                            onTap: () {
                              for (int i = 1; i <= 6; i++) {
                                Future.delayed(Duration(milliseconds: i * 200),
                                    () {
                                  setState(() {
                                    jogo.ultimoResultado = i;
                                  });
                                });
                              }
                              Future.delayed(Duration(milliseconds: 1200), () {
                                jogo.jogarDado();
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: corJogador1,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: jogo.ultimoResultado == 0
                                    ? const Text(
                                        'Toque para jogar o dado',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    : Text(
                                        '${jogo.ultimoResultado}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    jogo.jogadorAtual == 2
                        ? GestureDetector(
                            onTap: () {
                              for (int i = 1; i <= 6; i++) {
                                Future.delayed(Duration(milliseconds: i * 200),
                                    () {
                                  setState(() {
                                    jogo.ultimoResultado = i;
                                  });
                                });
                              }
                              Future.delayed(Duration(milliseconds: 1200), () {
                                jogo.jogarDado();
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: corJogador2,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: jogo.ultimoResultado == 0
                                    ? const Text(
                                        'Toque para jogar o dado',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    : Text(
                                        '${jogo.ultimoResultado}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: corJogador2,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Colors.grey[200], // cor de fundo do avatar
                          child: Icon(
                            Icons.person, // ícone padrão de usuário
                            color: Colors.grey[800], // cor do ícone
                            size: 50, // tamanho do ícone
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // inicio do tabuleiro
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: corJogador1,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              left: 25,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador1,
                                              size: 30,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador1,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador1,
                                              size: 30,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador1,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // area dos caminhos entre o azul e o vermelho
                        Column(
                          children: List.generate(6, (rowIndex) {
                            return Row(
                              children: List.generate(3, (colIndex) {
                                // Exemplo: especificando cores para um quadrado específico
                                if (colIndex == 1 &&
                                        rowIndex >= 1 &&
                                        rowIndex <= 5 ||
                                    (colIndex == 2 && rowIndex == 1)) {
                                  return buildContainerVertical(
                                      color: Colors
                                          .red); // Especificando a cor azul
                                } else if (colIndex == 0 && rowIndex == 2) {
                                  return buildContainerVertical(
                                      color: Colors
                                          .blue); // Especificando a cor amarela
                                } else {
                                  return buildContainerVertical(); // Quadrados normais serão brancos
                                }
                              }).toList(),
                            );
                          }).toList(),
                        ),

                        Stack(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: corJogador2,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              left: 25,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador2,
                                              size: 30,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador2,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador2,
                                              size: 30,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador2,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
// area dos quadrados horizontais entre o azul e o verde
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: List.generate(3, (rowIndex) {
                            return Row(
                              children: List.generate(6, (colIndex) {
                                // Exemplo: especificando cores para um quadrado específico
                                if (rowIndex == 1 &&
                                        colIndex >= 1 &&
                                        colIndex <= 5 ||
                                    (rowIndex == 0 && colIndex == 1)) {
                                  return buildContainerHorizontal(
                                      color: Colors
                                          .blue); // Especificando a cor azul
                                } else if (colIndex == 2 && rowIndex == 2) {
                                  return buildContainerHorizontal(
                                      color: Colors
                                          .green); // Especificando a cor amarela
                                } else {
                                  return buildContainerHorizontal(); // Quadrados normais serão brancos
                                }
                              }).toList(),
                            );
                          }).toList(),
                        ),

                        // container do centro do tabuleiro

                        Container(
                          width: 95,
                          height: 95,
                          child: CustomPaint(
                            painter: TrianglePainter(),
                          ),
                        ),

// area dos quadrados horizontais entre o vermelho e o amarelo

                        Column(
                          children: List.generate(3, (rowIndex) {
                            return Row(
                              children: List.generate(6, (colIndex) {
                                // Exemplo: especificando cores para um quadrado específico
                                if (rowIndex == 1 &&
                                        colIndex >= 0 &&
                                        colIndex <= 4 ||
                                    (rowIndex == 2 && colIndex == 4)) {
                                  return buildContainerHorizontal(
                                      color: Colors
                                          .yellow); // Especificando a cor azul
                                } else if (colIndex == 3 && rowIndex == 0) {
                                  return buildContainerHorizontal(
                                      color: Colors
                                          .red); // Especificando a cor amarela
                                } else {
                                  return buildContainerHorizontal(); // Quadrados normais serão brancos
                                }
                              }).toList(),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: corJogador3,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              left: 25,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador3,
                                              size: 30,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador3,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador3,
                                              size: 30,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador3,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // area dos quadrados entre o verde e o amarelo
                        Column(
                          children: List.generate(6, (rowIndex) {
                            return Row(
                              children: List.generate(3, (colIndex) {
                                // Exemplo: especificando cores para um quadrado específico
                                if (jogo.ultimoResultado != 6 ||
                                    jogo.ultimoResultado != 5) {
                                  if (colIndex == 0 && rowIndex == jogo.linha) {
                                    return buildContainerVertical(
                                        icon: peao(), peao: true);
                                  }
                                }

                                if (colIndex == 1 &&
                                        rowIndex >= 0 &&
                                        rowIndex <= 4 ||
                                    (colIndex == 0 && rowIndex == 4)) {
                                  return buildContainerVertical(
                                      color: Colors
                                          .green); // Especificando a cor azul
                                } else if (colIndex == 2 && rowIndex == 3) {
                                  return buildContainerVertical(
                                      color: Colors
                                          .yellow); // Especificando a cor amarela
                                } else {
                                  return buildContainerVertical(); // Quadrados normais serão brancos
                                }
                              }).toList(),
                            );
                          }).toList(),
                        ),

                        Stack(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: corJogador4,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              left: 25,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            //child:
                                            // Icon(
                                            //   Icons.person,
                                            //   color: corJogador4,
                                            //   size: 30,
                                            // ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador4,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador4,
                                              size: 30,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color.fromARGB(
                                                255, 177, 170, 170),
                                            child: Icon(
                                              Icons.person,
                                              color: corJogador4,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Colors.grey[200], // cor de fundo do avatar
                          child: Icon(
                            Icons.person, // ícone padrão de usuário
                            color: Colors.grey[800], // cor do ícone
                            size: 50, // tamanho do ícone
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    jogo.jogadorAtual == 4
                        ? GestureDetector(
                            onTap: () {
                              for (int i = 1; i <= 6; i++) {
                                Future.delayed(Duration(milliseconds: i * 200),
                                    () {
                                  setState(() {
                                    jogo.ultimoResultado = i;
                                  });
                                });
                              }
                              Future.delayed(Duration(milliseconds: 1200), () {
                                jogo.jogarDado();
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: corJogador3,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: jogo.ultimoResultado == 0
                                    ? const Text(
                                        'Toque para jogar o dado',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    : Text(
                                        '${jogo.ultimoResultado}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    jogo.jogadorAtual == 3
                        ? GestureDetector(
                            onTap: () {
                              for (int i = 1; i <= 6; i++) {
                                Future.delayed(Duration(milliseconds: i * 200),
                                    () {
                                  setState(() {
                                    jogo.ultimoResultado = i;
                                  });
                                });
                              }
                              Future.delayed(Duration(milliseconds: 1200), () {
                                jogo.jogarDado();
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: corJogador4,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: jogo.ultimoResultado == 0
                                    ? const Text(
                                        'Toque para jogar o dado',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    : Text(
                                        '${jogo.ultimoResultado}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Colors.grey[200], // cor de fundo do avatar
                          child: Icon(
                            Icons.person, // ícone padrão de usuário
                            color: Colors.grey[800], // cor do ícone
                            size: 50, // tamanho do ícone
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]);
        },
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..style = PaintingStyle.fill;

    // Triângulo 1
    paint.color = Colors.blue;
    var path = Path();
    path.moveTo(0, 0); // top left
    path.lineTo(size.width / 2, size.height / 2); // center
    path.lineTo(0, size.height); // bottom left
    path.close();
    canvas.drawPath(path, paint);

    // Triângulo 2
    paint.color = Colors.yellow;
    path = Path();
    path.moveTo(size.width, 0); // top right
    path.lineTo(size.width / 2, size.height / 2); // center
    path.lineTo(size.width, size.height); // bottom right
    path.close();
    canvas.drawPath(path, paint);

    // Triângulo 3
    paint.color = Colors.red;
    path = Path();
    path.moveTo(0, 0); // top left
    path.lineTo(size.width, 0); // top right
    path.lineTo(size.width / 2, size.height / 2); // center
    path.close();
    canvas.drawPath(path, paint);

    // Triângulo 4
    paint.color = Colors.green;
    path = Path();
    path.moveTo(0, size.height); // bottom left
    path.lineTo(size.width, size.height); // bottom right
    path.lineTo(size.width / 2, size.height / 2); // center
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Jogo with ChangeNotifier {
  int jogadorAtual = 1;
  int ultimoResultado = 0;
  Random rng = Random();
  int coluna = 0;
  int linha = 5;

  static Jogo instance = Jogo();

  void jogarDado() async {
    ultimoResultado = rng.nextInt(5) + 1;

    print('Jogador $jogadorAtual jogou o dado e obteve $ultimoResultado.');

// Apenas executa a animação se a linha for diferente do destino
    int destinoLinha = linha - ultimoResultado  ;

    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (linha != destinoLinha) {
        linha--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });

    if (ultimoResultado != 6) {
      notifyListeners(); // Notificar imediatamente para mostrar o resultado

      await Future.delayed(const Duration(seconds: 3));
      jogadorAtual = jogadorAtual % 4 + 1;
      print('Agora é a vez do jogador $jogadorAtual.');
      ultimoResultado = 0;
      notifyListeners();
    } else {
      notifyListeners(); // Notificar imediatamente para mostrar o resultado do 6
      print('O jogador $jogadorAtual obteve um 6. Joga novamente.');
    }
  }
}

Widget buildContainerVertical({
  Color? color,
  Widget? icon, // Adicionando um parâmetro opcional para o ícone
  bool? peao,
}) {
  // Se for a posição específica, adiciona o ícone
  if (peao == true) {
    return Container(
      width: 28,
      height: 25,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border.all(),
      ),
      child: icon ??
          SizedBox(), // Renderiza o ícone ou um SizedBox() se não houver
    );
  } else {
    return Container(
      width: 28,
      height: 25,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border.all(),
      ),
    );
  }
}

Widget buildContainerHorizontal({Color? color}) {
  return Container(
    height: 30,
    width: 24,
    decoration:
        BoxDecoration(color: color ?? Colors.white, border: Border.all()),
  );
}

Widget peao({Color? cor}) {
  return Icon(
    Icons.person,
    color: cor,
    size: 30,
  );
}
