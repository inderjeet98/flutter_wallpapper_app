import 'package:flutter/material.dart';

import '../../../widgets/floating_bottombar.dart';

class FullViewImg extends StatelessWidget {
  String imgUrl;
  FullViewImg({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover)),
      ),
      floatingActionButton: FloatingCustomBottomBar(url: imgUrl),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
