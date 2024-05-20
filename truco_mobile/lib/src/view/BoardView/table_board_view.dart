import 'package:flutter/material.dart';

class BoardView extends StatelessWidget {
  const BoardView({super.key});

  Widget buildRowOfContainers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => buildContainer()),
    );
  }

  Widget buildColumnRowOfContainers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildColumnOfContainers(),
        const Spacer(flex: 5),
        buildColumnOfContainers(),
      ],
    );
  }

  Widget buildColumnOfContainers() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => buildContainer()),
    );
  }

  Widget buildContainer() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(50, 168, 82, 1.0),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRowOfContainers(),
                buildColumnRowOfContainers(),
                buildRowOfContainers(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}