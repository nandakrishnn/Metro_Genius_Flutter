import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import '../../../../../utils/colors.dart';

class SearchingWidget extends StatefulWidget {
  @override
  _SearchingWidgetState createState() => _SearchingWidgetState();
}

class _SearchingWidgetState extends State<SearchingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String _displayText = '';
  final String _searchText = 'Searching for worker';
  int _charIndex = 0;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -3, end: 3).animate(_controller);

    // Start the typing simulation
    _simulateTyping();
  }

  void _simulateTyping() async {
    while (!_isDisposed) {  // Check if the widget is not disposed
      if (_charIndex < _searchText.length) {
        await Future.delayed(Duration(milliseconds: 150));
        if (!_isDisposed && mounted) {
          setState(() {
            _displayText += _searchText[_charIndex];
            _charIndex++;
          });
        }
      } else {
        await Future.delayed(Duration(seconds: 1));  // Pause after completing the text
        if (!_isDisposed && mounted) {
          setState(() {
            _displayText = '';
            _charIndex = 0;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppConstants.kheight5,
        AppConstants.kwidth20,
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.search,
                  color: AppColors.greyColor,
                ),
              ),
            );
          },
        ),
        AppConstants.kwidth10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_displayText),
            Text(
              'Service Provider',
              style: TextStyle(color: AppColors.greyColor),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }

  @override
  void dispose() {
    _isDisposed = true;  // Set the flag to true when disposing
    _controller.dispose();
    super.dispose();
  }
}
