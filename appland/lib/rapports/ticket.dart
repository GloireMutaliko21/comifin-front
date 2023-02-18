import 'dart:io';

import 'package:app/src/app/data/Datasource.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Ticket extends StatefulWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    final headers = [
      '',
      '',
    ];

    final pdf = pw.Document();

    Future<void> docs() async {
      final bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/paiement.pdf');

      await file.writeAsBytes(bytes);
      final url = file.path;

      await OpenFile.open(url);
    }

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(children: <pw.Widget>[
            pw.Text("TICKET",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Container(color: PdfColors.black, height: 1),
            pw.SizedBox(height: 30),
            pw.Table.fromTextArray(
              data: newPaiem,
              headers: headers,
              border: pw.TableBorder.all(),
              headerStyle:
                  pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 10),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                // 2: pw.Alignment.centerLeft,
                // 3: pw.Alignment.centerLeft,
                // 4: pw.Alignment.centerLeft,
                // 5: pw.Alignment.centerLeft,
              },
            )
          ]));
        }));

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                setState(() => {docs()});
              },
              child: const Text('Ouvrir'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                final bytes = await pdf.save();
                final dir = await getApplicationDocumentsDirectory();
                final file = File('${dir.path}/vendeurs.pdf');

                await file.writeAsBytes(bytes);
                final url = file.path;
                await OpenFile.open(url);
              },
              child: const Text('Télécharger'),
            ),
          ],
        ),
      ),
    );
  }
}
