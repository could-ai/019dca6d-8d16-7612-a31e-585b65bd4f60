import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/certificate_data.dart';

class CertificateWidget extends StatelessWidget {
  final CertificateData data;

  const CertificateWidget({Key? key, required this.data}) : super(key: key);

  TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, {Color? color}) {
    try {
      return GoogleFonts.getFont(
        data.fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? data.textColor,
      );
    } catch (e) {
      return TextStyle(
        fontFamily: data.fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? data.textColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data.templateStyle == 1) {
      return _buildElegantTemplate();
    } else if (data.templateStyle == 2) {
      return _buildModernTemplate();
    }
    return _buildSimpleTemplate();
  }

  Widget _buildSimpleTemplate() {
    return Container(
      width: 800,
      height: 600,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        border: Border.all(color: data.borderColor, width: 12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: data.borderColor.withOpacity(0.5), width: 4.0),
        ),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.title,
              style: _getTextStyle(48.0, FontWeight.bold, color: data.borderColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48.0),
            Text(
              'This is proudly presented to',
              style: _getTextStyle(24.0, FontWeight.normal),
            ),
            const SizedBox(height: 24.0),
            Text(
              data.recipientName,
              style: _getTextStyle(56.0, FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            Container(
              width: 500,
              height: 2,
              color: data.textColor.withOpacity(0.5),
            ),
            const SizedBox(height: 24.0),
            Text(
              data.description,
              style: _getTextStyle(24.0, FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSignatureLine(data.date, 'Date'),
                _buildSignatureLine(data.signature, 'Signature'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildElegantTemplate() {
    return Container(
      width: 800,
      height: 600,
      decoration: BoxDecoration(
        color: data.backgroundColor,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: ElegantBorderPainter(borderColor: data.borderColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 64, color: data.borderColor),
                const SizedBox(height: 16),
                Text(
                  data.title,
                  style: _getTextStyle(42.0, FontWeight.w900, color: data.borderColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                Text(
                  'Awarded to',
                  style: _getTextStyle(22.0, FontWeight.w300),
                ),
                const SizedBox(height: 16.0),
                Text(
                  data.recipientName,
                  style: _getTextStyle(64.0, FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                Text(
                  data.description,
                  style: _getTextStyle(20.0, FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSignatureLine(data.date, 'Date', elegant: true),
                    _buildSignatureLine(data.signature, 'Signature', elegant: true),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTemplate() {
    return Container(
      width: 800,
      height: 600,
      decoration: BoxDecoration(
        color: data.backgroundColor,
      ),
      child: Stack(
        children: [
          Positioned(
            left: -100,
            top: -100,
            child: CircleAvatar(
              radius: 200,
              backgroundColor: data.borderColor.withOpacity(0.2),
            ),
          ),
          Positioned(
            right: -150,
            bottom: -150,
            child: CircleAvatar(
              radius: 250,
              backgroundColor: data.borderColor.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: double.infinity,
                  color: data.borderColor,
                ),
                const SizedBox(width: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.title.toUpperCase(),
                        style: _getTextStyle(48.0, FontWeight.w900, color: data.borderColor),
                      ),
                      const SizedBox(height: 48.0),
                      Text(
                        'PRESENTED TO',
                        style: _getTextStyle(20.0, FontWeight.w600, color: data.textColor.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        data.recipientName,
                        style: _getTextStyle(56.0, FontWeight.bold),
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        data.description,
                        style: _getTextStyle(22.0, FontWeight.normal),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSignatureLine(data.date, 'Date', leftAlign: true),
                          _buildSignatureLine(data.signature, 'Signature', leftAlign: true),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureLine(String text, String label, {bool elegant = false, bool leftAlign = false}) {
    return Column(
      crossAxisAlignment: leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: _getTextStyle(elegant ? 28.0 : 24.0, elegant ? FontWeight.w300 : FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 200,
          height: 1,
          color: data.textColor,
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: _getTextStyle(16.0, FontWeight.normal),
        ),
      ],
    );
  }
}

class ElegantBorderPainter extends CustomPainter {
  final Color borderColor;

  ElegantBorderPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final margin = 24.0;
    final rect = Rect.fromLTWH(margin, margin, size.width - margin * 2, size.height - margin * 2);
    
    canvas.drawRect(rect, paint);
    
    // Draw corner accents
    final double cornerSize = 40.0;
    final thickPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0;

    // Top-left
    canvas.drawLine(Offset(margin, margin), Offset(margin + cornerSize, margin), thickPaint);
    canvas.drawLine(Offset(margin, margin), Offset(margin, margin + cornerSize), thickPaint);
    
    // Top-right
    canvas.drawLine(Offset(size.width - margin, margin), Offset(size.width - margin - cornerSize, margin), thickPaint);
    canvas.drawLine(Offset(size.width - margin, margin), Offset(size.width - margin, margin + cornerSize), thickPaint);
    
    // Bottom-left
    canvas.drawLine(Offset(margin, size.height - margin), Offset(margin + cornerSize, size.height - margin), thickPaint);
    canvas.drawLine(Offset(margin, size.height - margin), Offset(margin, size.height - margin - cornerSize), thickPaint);
    
    // Bottom-right
    canvas.drawLine(Offset(size.width - margin, size.height - margin), Offset(size.width - margin - cornerSize, size.height - margin), thickPaint);
    canvas.drawLine(Offset(size.width - margin, size.height - margin), Offset(size.width - margin, size.height - margin - cornerSize), thickPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
