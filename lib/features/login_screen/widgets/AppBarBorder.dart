import 'package:flutter/material.dart';

class AppBarBorder extends ShapeBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Offset controllPoint1 = Offset(0, rect.size.height - 100);
    Offset endPoint1 = Offset(100, rect.size.height - 100);
    Offset controllPoint2 = Offset(rect.size.width, rect.size.height - 100);
    Offset endPoint2 = Offset(rect.size.width, rect.size.height - 200);
    
    return Path()
      ..lineTo(0, rect.size.height)
      ..quadraticBezierTo(
          controllPoint1.dx, controllPoint1.dy, endPoint1.dx, endPoint1.dy)
      ..lineTo(rect.size.width - 100, rect.size.height - 100)
      ..quadraticBezierTo(
          controllPoint2.dx, controllPoint2.dy, endPoint2.dx, endPoint2.dy)
      ..lineTo(rect.size.width, 0);
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: 0);

 
  @override
  ShapeBorder scale(double t) => this;
  
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }
  
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }
}