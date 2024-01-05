import 'package:flutter/material.dart';
import 'package:storage_chart/src/storage_model_base.dart';

class CylinderPainter extends CustomPainter {
  final num totalStorage;
  final List<DataModel> storageData;
  final Size screenSize;
  final Color? cylinderBgColor;
  final Color? topOvalColor;
  final double cylinderWidth;
  final double cylinderHeight;

  CylinderPainter({
    required this.totalStorage,
    required this.storageData,
    required this.screenSize,
    required this.cylinderWidth,
    required this.cylinderHeight,
    this.cylinderBgColor,
    this.topOvalColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final screenHeight = screenSize.height;
    print("SCREEN HEIGHT  ${screenSize.height}");
    print("MAIN CYLINDER HEIGHT 100 % $cylinderHeight");

    /// STATIC HEIGHT
    // final cylinderHeight = screenSize.height / 1.8;
    const ovalValue = 35;

    ///  =====================  MAIN CYLINDER  ===================== ///

    var mainCylinderPath = Path();
    var mainCylinderPaint = Paint();

    mainCylinderPaint.color = cylinderBgColor ?? const Color(0xffF2F2F2);
    mainCylinderPaint.style = PaintingStyle.fill;
    mainCylinderPath.moveTo(0, cylinderHeight);
    mainCylinderPath.quadraticBezierTo(size.width / 2,
        (cylinderHeight) + ovalValue, size.width, cylinderHeight);
    mainCylinderPath.lineTo(size.width, 0);
    mainCylinderPath.lineTo(0, 0);

    ///  =====================  MAIN CYLINDER END ===================== ///

    /// ===================== UPPER CLIP OVAL ===================== ///

    var upperClipOvalPath = Path();
    var upperClipOvalPaint = Paint();
    upperClipOvalPaint.color = topOvalColor ?? const Color(0xffE9E9E9);
    upperClipOvalPaint.style = PaintingStyle.fill;
    Offset center = Offset(size.width / 2, screenHeight / 400);
    Rect rectTwo =
        Rect.fromCenter(center: center, width: cylinderWidth, height: 35);
    upperClipOvalPath.addOval(rectTwo);
    canvas.drawPath(mainCylinderPath, mainCylinderPaint);
    canvas.drawPath(upperClipOvalPath, upperClipOvalPaint);

    /// ===================== UPPER CLIP OVAL END ===================== ///

    /// ===================== ALL STORAGE FILL ===================== ///

    for (int index = 0; index < storageData.length; index++) {
      final segmentHeight = getOvalHeight(index);
      final segmentPreviousHeight =
          index == 0 ? 0 : getPreviousOvalHeight(index);
      final finalCylinderHeight = cylinderHeight - segmentPreviousHeight;

      var path = Path();
      var paint = Paint();
      paint.color = storageData[index].color;
      paint.style = PaintingStyle.fill;

      path.moveTo(0, finalCylinderHeight);
      path.quadraticBezierTo(size.width / 2, finalCylinderHeight + ovalValue,
          size.width, finalCylinderHeight);

      if (index == storageData.length - 1) {
        path.lineTo(size.width, finalCylinderHeight - segmentHeight - 5);
        path.lineTo(0, finalCylinderHeight - segmentHeight - 5);
      } else {
        path.lineTo(size.width, finalCylinderHeight - segmentHeight);
        path.quadraticBezierTo(
            size.width / 2,
            (finalCylinderHeight - segmentHeight) + ovalValue,
            0,
            finalCylinderHeight - segmentHeight);
      }
      canvas.drawPath(path, paint);
    }

    /// ===================== ALL STORAGE FILL END ===================== ///

    /// ===================== UNDER STORAGE CLIP OVAL ===================== ///

    var underClipOvalPath = Path();
    var underClipOvalPaint = Paint();
    underClipOvalPaint.color = storageData.last.color;
    underClipOvalPaint.style = PaintingStyle.fill;
    Offset centerUnder = Offset(size.width / 2,
        cylinderHeight - getPreviousOvalHeight(storageData.length) - 4.5);
    Rect rectTwoUnder =
        Rect.fromCenter(center: centerUnder, width: cylinderWidth, height: 35);
    underClipOvalPath.addOval(rectTwoUnder);
    canvas.drawPath(underClipOvalPath, underClipOvalPaint);

    /// ===================== UNDER STORAGE CLIP OVAL END ===================== ///

    /// ===================== UNDER STORAGE CLIP OVAL 2  ===================== ///

    var underClipOvalPath2 = Path();
    var underClipOvalPaint2 = Paint();
    underClipOvalPaint2.color = Colors.black.withOpacity(0.05);
    underClipOvalPaint2.style = PaintingStyle.fill;
    Offset centerUnder2 = Offset(size.width / 2,
        cylinderHeight - getPreviousOvalHeight(storageData.length) - 4.5);
    Rect rectTwoUnder2 =
        Rect.fromCenter(center: centerUnder2, width: cylinderWidth, height: 35);
    underClipOvalPath2.addOval(rectTwoUnder2);
    canvas.drawPath(underClipOvalPath2, underClipOvalPaint2);

    /// ===================== UNDER STORAGE CLIP OVAL END ===================== ///
  }

  double getPreviousOvalHeight(int index) {
    double segmentHeight = 0;
    for (int i = 0; i < index; i++) {
      var segmentPercentage = (storageData[i].amount * 100) / totalStorage;

      segmentHeight += (segmentPercentage / 100) * cylinderHeight;
    }
    return segmentHeight;
  }

  double getOvalHeight(int index) {
    var segmentPercentage = (storageData[index].amount * 100) / totalStorage;
    print("segment percentage :- $segmentPercentage % height :- ${(segmentPercentage / 100) * cylinderHeight}");
    return (segmentPercentage / 100) * cylinderHeight;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
