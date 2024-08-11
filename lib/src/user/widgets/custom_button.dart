import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: Container(
          width: 150, // Adjust width as needed
          height: 50, // Adjust height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: _isHovered
                ? LinearGradient(
                    colors: [
                      Color(0xFF550000),
                      Color(0xFF550000),
                    ],
                    stops: [0.0, 1.0],
                  )
                : LinearGradient(
                    colors: [
                      Color(0xFF550000),
                      Color(0xFF550000),
                    ],
                    stops: [0.0, 1.0],
                  ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  transform: Matrix4.translationValues(
                    0,
                    _isHovered
                        ? (_isPressed ? 1 : 4)
                        : (_isPressed ? 1 : 2),
                    0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 27),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _isHovered
                        ? Colors.redAccent
                        : Colors.red,
                  ),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
