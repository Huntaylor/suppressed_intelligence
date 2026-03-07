import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: NineTileBoxWidget.asset(
          path: 'windows_95_chatgpt.png',
          tileSize: 27,
          destTileSize: 8,
          height: 512,
          width: 720,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 1, 0, 1),
                  child: Text(
                    'Suppressed Intelligence',
                    style: TextStyle(
                      color: Colors.white,
                      height: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.center,
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: .center,
                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Agne',
                      ),
                      child: AnimatedTextKit(
                        displayFullTextOnTap: true,
                        repeatForever: false,
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'What can I help with?',
                            curve: Curves.easeOut,
                            cursor: '',
                            speed: Duration(milliseconds: 75),
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text('Send Prompt'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => exit(0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text('Quit'),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: GestureDetector(
                  onTap: () => exit(0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                      width: 15,
                      height: 14,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
