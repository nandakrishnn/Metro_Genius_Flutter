import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  double value = 0; // Track the drawer animation state

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: value),
        duration: const Duration(milliseconds: 500),
        builder: (_, double val, __) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setEntry(0, 3, 200 * val)
              ..rotateY((pi / 6) * val),
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          value = 0;
                        });
                      },
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(8),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(8),
                        color: const Color.fromRGBO(35, 74, 203, 1),
                        child: Column(
                          children: [
                            DrawerHeader(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: Image.network(''),
                                  ),
                                  AppConstants.kheight10,
                                  const Text('📍Current Location.'),
                                  const Text('MARADU KOCHI ,KERALA'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    leading: const Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                    ),
                                    title: const Text(
                                      'Add Location',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    leading: const Icon(
                                      Icons.notification_add,
                                      color: Colors.white,
                                    ),
                                    title: const Text(
                                      'Notifications',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    leading: const Icon(
                                      Icons.point_of_sale,
                                      color: Colors.white,
                                    ),
                                    title: const Text(
                                      'Your Points',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
