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
  String exploitant = '';
  String exploitantActe = '';
  String acte = '';
  String montant = '';
  String devise = '';
  String annee = '';
  String mois = '';
  @override
  void initState() {
    exploitant = newPaiem["exploitant"] ?? 'Aucun';
    exploitantActe = newPaiem["exploitant_acte"];
    acte = newPaiem["acte"];
    montant = newPaiem["montant"];
    devise = newPaiem["device"];
    annee = newPaiem["annee"];
    mois = newPaiem["mois"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          return pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black)),
              child: pw.Center(
                  child: pw.Column(children: <pw.Widget>[
                pw.SizedBox(height: 10),
                pw.Text("TICKET",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Container(
                  color: PdfColors.black,
                  height: 2,
                ),
                pw.SizedBox(height: 30),
                pw.Container(
                    child: pw.Column(children: [
                  pw.Row(children: [
                    pw.Expanded(
                        child: pw.Text('Exploitant',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text('Acte Exploitant',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text('Acte',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text('Montant',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text('Devise',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text('Mois',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text('Année',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ]),
                  pw.SizedBox(height: 10),
                  pw.Container(color: PdfColors.black, height: 1),
                  pw.SizedBox(height: 30),
                  pw.Row(children: [
                    pw.Expanded(
                        child: pw.Text(exploitant,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text(exploitantActe,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text(acte,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text(montant,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text(devise,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(
                        child: pw.Text(mois,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ))),
                    pw.Expanded(
                        child: pw.Text(annee,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ]),
                ])),
              ])));
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
                final file = File('${dir.path}/ticket.pdf');

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
