import 'package:flutter/material.dart';
import 'package:storage_chart/src/storage_model_base.dart';
import 'package:storage_chart/src/storage_painter.dart';

class StorageChatLayout extends StatelessWidget {
  final num totalStorage;
  final double? width;
  final double? height;
  final List<DataModel> storageData;

  const StorageChatLayout(
      {Key? key,
      required this.totalStorage,
      required this.storageData,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: width??size.width / 3.2,
        height:height?? size.height / 1.8,
        child: storageData
                    .map((e) => e.amount)
                    .toList()
                    .fold(0, (p, e) => p + e.toInt()) >
                totalStorage
            ? const Text(
                "Miss match total storage and storage amount",
                style: TextStyle(color: Colors.black),
              )
            : CustomPaint(
                painter: CylinderPainter(
                    totalStorage: totalStorage,
                    storageData: storageData,
                    cylinderHeight: height ?? size.height / 1.8,
                    cylinderWidth: width ?? size.width / 3.2,
                    screenSize: size),
                child: Container(),
              ),
      ),
    );
  }
}
