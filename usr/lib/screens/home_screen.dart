import 'package:flutter/material.dart';
import '../models/certificate_data.dart';
import '../widgets/certificate_widget.dart';
import 'editor_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate Maker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Template',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                childAspectRatio: 4 / 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildTemplateCard(context, 0, 'Simple Professional'),
                  _buildTemplateCard(context, 1, 'Elegant Gold'),
                  _buildTemplateCard(context, 2, 'Modern Creative'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(BuildContext context, int styleIndex, String title) {
    // Create dummy data for preview
    final dummyData = CertificateData(templateStyle: styleIndex);
    if (styleIndex == 1) {
      dummyData.fontFamily = 'Lora';
      dummyData.borderColor = Colors.amber[700]!;
    } else if (styleIndex == 2) {
      dummyData.fontFamily = 'Oswald';
      dummyData.borderColor = Colors.teal;
    }

    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorScreen(templateStyle: styleIndex),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: IgnorePointer(
                    child: CertificateWidget(data: dummyData),
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
