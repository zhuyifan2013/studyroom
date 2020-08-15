import 'package:flutter/material.dart';

class SRButton extends StatefulWidget {
  final Widget child;

  final VoidCallback onPressed;

  const SRButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _SRButtonState createState() => _SRButtonState();
}

class _SRButtonState extends State<SRButton> {
  Widget get child => widget.child;

  /// Simple getter on widget's onPressed callback
  VoidCallback get onPressed => widget.onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
          colors: [const Color(0xff62DBC6), const Color(0xff309F8C)], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x8062DBC6),
            blurRadius: 20,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.2),
        onTap: onPressed,
        child: Center(
          child: child
        ),
      ),
    );
  }
}
