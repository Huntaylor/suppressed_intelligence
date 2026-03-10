import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:application/application.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/routes/route.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  late AnimatedTextController animatedTextController;

  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    animatedTextController = AnimatedTextController();
    super.initState();
  }

  @override
  void dispose() {
    animatedTextController.dispose();
    _controller.dispose();
    super.dispose();
  }

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
                        controller: animatedTextController,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'What will you call me?',
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
                    SizedBox(
                      width: 320,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _controller,
                          maxLength: 16,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Enter text',
                            border: OutlineInputBorder(),
                            counterText: null,
                            counterStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        final isValid =
                            _formKey.currentState?.validate() ?? false;

                        if (!isValid) return;

                        gameConfigOg.events.addName(_controller.text);

                        GameCoordinator.instance.navigate(GameRoute());
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Image.asset(
                          'assets/images/menu_prompt_button.png',
                        ),
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
