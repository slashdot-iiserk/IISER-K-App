import 'package:flutter/material.dart';
import 'dart:async';

typedef bool BooleanCallback();

class LoginProgressButton extends StatefulWidget {
  final Color successButtonColor;
  final Color buttonColor;
  final Color splashColor;
  @required
  final VoidCallback navigator;
  @required
  final BooleanCallback onPressed;

  const LoginProgressButton({
    Key? key,
    required this.successButtonColor,
    required this.buttonColor,
    required this.splashColor,
    required this.navigator,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginProgressButtonState();
}

class _LoginProgressButtonState extends State<LoginProgressButton>
    with TickerProviderStateMixin {
  int _state = 0;
  double _width = 240.0;
  late Animation _animation;
  late AnimationController _controller;
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      alignment: Alignment.center,
      height: 60.0,
      width: _width,
      child: ButtonTheme(
        height: 60.0,
        minWidth: _width,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: loginState(),
        ),
      ),
    );
  }

  Widget loginState() {
    if (_state == 2) {
      return Icon(
        Icons.check,
        color: Colors.white,
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 30.0,
        width: 30.0,
        child: CircularProgressIndicator(
          value: null,
          backgroundColor: Colors.white,
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text('Connect',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ));
    }
  }

  void animateButton() {
    double initialWidth = globalKey.currentContext!.size!.width;
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 60.0) * _animation.value);
          //this reduces the width by 48.0 for each frame, thus showing a smooth transition
        });
      });
    /**
     * // The cascade notation (..) used in the addListener is similar to
     * _animation = Tween(begin: 0.0, end: 1.0).animate(controller);
     * _animation.addListener(
     *  () {
     *    setState() {
     *    /......./
     *    }
     *  }
     * )
     */

    _controller.forward(); //the forward function starts the animation

    //starting with the default state
    setState(() => _state = 1);

    Timer(Duration(milliseconds: 3600), () => setState(() => _state = 2));

    Timer(Duration(milliseconds: 4200), () => widget.navigator());

    Timer(Duration(milliseconds: 4400), () => reset());
  }

  void reset() {
    _width = 240.0;
    _state = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressed() {
    if (widget.onPressed()) {
      setState(() {
        if (_state == 0) {
          animateButton();
        } else if (_state == 2) {
          reset();
        }
      });
    } else {}
  }
}
