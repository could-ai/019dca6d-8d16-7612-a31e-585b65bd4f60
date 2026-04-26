import 'package:flutter/material.dart';

class CertificateData {
  String title;
  String recipientName;
  String description;
  String date;
  String signature;
  Color backgroundColor;
  Color borderColor;
  Color textColor;
  String fontFamily;
  int templateStyle;

  CertificateData({
    this.title = 'CERTIFICATE OF ACHIEVEMENT',
    this.recipientName = 'John Doe',
    this.description = 'For outstanding performance and dedication.',
    this.date = 'October 24, 2023',
    this.signature = 'Jane Smith',
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blueGrey,
    this.textColor = Colors.black87,
    this.fontFamily = 'Roboto',
    this.templateStyle = 0,
  });
}
