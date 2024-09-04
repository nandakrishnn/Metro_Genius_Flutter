import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/get_booked_works/get_booked_works_user_bloc.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import '../../../../../utils/colors.dart';

class SearchingWidget extends StatefulWidget {
  String orderId;
    SearchingWidget({
    super.key,
    required this.orderId, // Marking the orderId as required
  });

  @override
  // ignore: library_private_types_in_public_api
  _SearchingWidgetState createState() => _SearchingWidgetState();

}

class _SearchingWidgetState extends State<SearchingWidget>
    with SingleTickerProviderStateMixin {
    

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  String _displayText = '';
  final String _searchText = 'Searching for worker';
  int _charIndex = 0;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the typing simulation
    _simulateTyping();
  }

  void _simulateTyping() async {
    while (!_isDisposed) {
      // Check if the widget is not disposed
      if (_charIndex < _searchText.length) {
        await Future.delayed(Duration(milliseconds: 150));
        if (!_isDisposed && mounted) {
          setState(() {
            _displayText += _searchText[_charIndex];
            _charIndex++;
          });
        }
      } else {
        await Future.delayed(
            Duration(seconds: 1)); // Pause after completing the text
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
  
    return BlocConsumer<GetBookedWorksUserBloc, GetBookedWorksUserState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        return Row(
          children: [
            AppConstants.kheight5,
            AppConstants.kwidth20,
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _scaleAnimation.value),
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
            Material(
              color: _isPressed ? Colors.red : AppColors.mainBlueColor,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: () {
                   FirebaseFirestore.instance.collectionGroup("UserOrders").where('Id',isEqualTo: widget.orderId).get().then((QuerySnapshot){
                    for(var document in QuerySnapshot.docs){
                      document.reference.update({
                       
                        'RequestStatus':RequestStatus.ordercancelled.toString()
                      });
                    }
                    print('data changed');;
                  });

                },
                borderRadius: BorderRadius.circular(12.0),
                splashColor: Colors.red.withOpacity(0.4),
                highlightColor: Colors.red.withOpacity(0.2),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                width:
                    10), // Add spacing between the cancel button and other elements if needed
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _isDisposed = true; // Set the flag to true when disposing
    _controller.dispose();
    super.dispose();
  }
}
