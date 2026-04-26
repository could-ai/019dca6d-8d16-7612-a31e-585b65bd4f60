import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:path_provider/path_provider.dart';

import '../models/certificate_data.dart';
import '../widgets/certificate_widget.dart';

class EditorScreen extends StatefulWidget {
  final int templateStyle;

  const EditorScreen({Key? key, required this.templateStyle}) : super(key: key);

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late CertificateData _data;
  final ScreenshotController _screenshotController = ScreenshotController();
  
  final List<String> _fonts = ['Roboto', 'Lora', 'Oswald', 'Dancing Script', 'Great Vibes', 'Merriweather', 'Playfair Display'];

  @override
  void initState() {
    super.initState();
    _data = CertificateData(templateStyle: widget.templateStyle);
    if (widget.templateStyle == 1) {
      _data.fontFamily = 'Lora';
      _data.borderColor = Colors.amber[700]!;
    } else if (widget.templateStyle == 2) {
      _data.fontFamily = 'Oswald';
      _data.borderColor = Colors.teal;
    }
  }

  void _exportAndShare() async {
    try {
      final imageBytes = await _screenshotController.capture();
      if (imageBytes != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/certificate_${DateTime.now().millisecondsSinceEpoch}.png').create();
        await imagePath.writeAsBytes(imageBytes);

        await Share.shareXFiles([XFile(imagePath.path)], text: 'Here is my certificate!');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error exporting certificate: $e')));
    }
  }

  void _pickColor(Color currentColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        Color pickerColor = currentColor;
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => pickerColor = color,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onColorChanged(pickerColor);
                Navigator.of(context).pop();
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Certificate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _exportAndShare,
            tooltip: 'Export & Share',
          ),
        ],
      ),
      body: Column(
        children: [
          // Preview Area
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: Screenshot(
                      controller: _screenshotController,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CertificateWidget(data: _data),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Controls Area
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(icon: Icon(Icons.text_fields), text: 'Text'),
                        Tab(icon: Icon(Icons.font_download), text: 'Font'),
                        Tab(icon: Icon(Icons.color_lens), text: 'Colors'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildTextEditor(),
                          _buildFontEditor(),
                          _buildColorEditor(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextEditor() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildTextField('Title', _data.title, (val) => setState(() => _data.title = val)),
        _buildTextField('Recipient Name', _data.recipientName, (val) => setState(() => _data.recipientName = val)),
        _buildTextField('Description', _data.description, (val) => setState(() => _data.description = val), maxLines: 3),
        _buildTextField('Date', _data.date, (val) => setState(() => _data.date = val)),
        _buildTextField('Signature', _data.signature, (val) => setState(() => _data.signature = val)),
      ],
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onChanged, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildFontEditor() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _fonts.length,
      itemBuilder: (context, index) {
        final font = _fonts[index];
        return ListTile(
          title: Text(font, style: TextStyle(fontFamily: font, fontSize: 18)),
          trailing: _data.fontFamily == font ? const Icon(Icons.check, color: Colors.blue) : null,
          onTap: () {
            setState(() {
              _data.fontFamily = font;
            });
          },
        );
      },
    );
  }

  Widget _buildColorEditor() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ListTile(
          title: const Text('Background Color'),
          trailing: _buildColorPreview(_data.backgroundColor),
          onTap: () => _pickColor(_data.backgroundColor, (color) => setState(() => _data.backgroundColor = color)),
        ),
        ListTile(
          title: const Text('Border/Accent Color'),
          trailing: _buildColorPreview(_data.borderColor),
          onTap: () => _pickColor(_data.borderColor, (color) => setState(() => _data.borderColor = color)),
        ),
        ListTile(
          title: const Text('Text Color'),
          trailing: _buildColorPreview(_data.textColor),
          onTap: () => _pickColor(_data.textColor, (color) => setState(() => _data.textColor = color)),
        ),
      ],
    );
  }

  Widget _buildColorPreview(Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
    );
  }
}
