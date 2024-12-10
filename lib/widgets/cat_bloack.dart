import 'package:flutter/material.dart';

import '../views/screens/category/category.dart';

// ignore: must_be_immutable
class CatBlock extends StatelessWidget {
  String imgSrc, catName;
  CatBlock({super.key, required this.imgSrc, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(catImgUrl: imgSrc, catName: catName))),
        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(height: 50, width: 100, fit: BoxFit.cover, imgSrc)),
            Container(height: 50, width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black26)),
            Positioned(left: 30, top: 15, child: Text(catName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)))
          ],
        ),
      ),
    );
  }
}
