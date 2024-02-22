import 'dart:ui' as ui;
import 'package:flutter/material.dart';

//АДАПТАЦИЯ

MediaQueryData mediaQueryData = MediaQueryData.fromWindow(ui.window);

const num DESIGN_WIDTH = 393;
const num DESIGN_HEIGHT = 852;
const num DESIGN_STATUS_BAR = 0;

// установка отступов верх и низ и высоты экрана
extension ResponsiveExtension on num {
  //получение ширины
  get _width {
    return mediaQueryData.size.width;
  }

  //получение высоты
  get _height {
    num statusBar = mediaQueryData.viewPadding.top;
    num bottomBar = mediaQueryData.viewPadding.bottom;
    num screenHeight = mediaQueryData.size.height - statusBar - bottomBar;
    return screenHeight;
  }

  //для padding/margin со сторон и ширины экрана
  double get h => ((this * _width) / DESIGN_WIDTH);

  //для padding/margin сверху и снизу и высота экрана
  double get v => (this * _height) / (DESIGN_HEIGHT - DESIGN_STATUS_BAR);

  //мин кол-ва пикселей в высоту и в ширину для картинок
  double get adaptSize {
    var height = v;
    var width = h;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  //для размера текста в зависимоти от размеров экрана
  double get fSize => adaptSize;
}

extension FormatExtension on double {
  //возврат готового значения
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }
}
