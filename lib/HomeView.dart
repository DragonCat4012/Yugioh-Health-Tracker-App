import 'package:flutter/material.dart';
import 'GameView.dart';
import 'Styling.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
      ),
      body: Center(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(title: "UwU")),
                        );
                      },
                      child: Text("Load Game"),
                      style: Styling().defaultButtonStyle(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(title: "UwU")),
                        );
                      },
                      child: Text("New Game"),
                      style: Styling().defaultButtonStyle(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(title: "UwU")),
                        );
                      },
                      child: Text("All Games"),
                      style: Styling().defaultButtonStyle(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(title: "UwU")),
                        );
                      },
                      child: Text("Logs"),
                      style: Styling().defaultButtonStyle(),
                    ),
                  ),
                ],
              ))), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}