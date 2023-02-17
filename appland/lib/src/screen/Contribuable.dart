import 'dart:convert';

import 'package:app/rapports/ticket.dart';
import 'package:app/src/app/data/Datasource.dart';
import 'package:app/src/models/session.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/CustomField.dart';
import '../utils/Utils.dart';
import '../utils/dropdown.dart';

class Contribuable extends StatefulWidget {
  const Contribuable({Key? key}) : super(key: key);
  @override
  State<Contribuable> createState() => _StateBody();
}

class _StateBody extends State<Contribuable> {
  var contribution = '';
  var devise = '';
  var mois = '';
  var annee = '';
  TextEditingController nomComplet = TextEditingController();
  TextEditingController montant = TextEditingController();

  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    MyPreferences().getPersistence();
  }

  String dropdownValue = 'Dog';

  Future<bool> postContrib() async {
    try {
      setState(() {
        inProgress = true;
      });
      var resultat =
          await DataSource.GetInstance!.isSave(url: 'add_payement.php', body: {
        'Fk_idtaxe': contribution,
        'montant': montant.text.trim(),
        'exploitant': nomComplet,
        'Fk_idmois': mois,
        'Fk_idanne': annee,
        'device': devise,
        'Fk_idagent': MyPreferences.userId
      });
      var res = await jsonDecode(resultat.body);
      print(res['msg']);
      if (resultat.statusCode == 201) {
        setState(() async {
          newPaiem = await jsonDecode(resultat.body);
          inProgress = false;
        });
        return true;
      }
    } catch (_) {
      setState(() {
        inProgress = false;
      });
      print(_.toString());
    }
    return false;
  }

  eventAddPaie() async {
    bool status = await postContrib();
    if (status) {
      setState(() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const Ticket())));
      });
    } else {
      setState(() {
        inProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size h = MediaQuery.of(context).size;
    Size w = MediaQuery.of(context).size;
    return SizedBox(
      height: h.height,
      width: w.width,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: w.width,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  buildTextField(
                    child: cbList(
                        list: listElement(val: contrib),
                        title: "Contribution",
                        valeur: null,
                        onChanged: (val) {
                          setState(() {
                            contribution = val;
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        }),
                    lineIcons: const Icon(LineIcons.edit),
                    name: "Selectionner",
                    textInputType: TextInputType.number,
                    controller: null,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          lineIcons: const Icon(LineIcons.edit),
                          name: "Montant",
                          controller: montant,
                        ),
                      ),
                      Expanded(
                        child: buildTextField(
                          child: cbList(
                              list: listElement(val: ['USD', 'CDF']),
                              title: "Devise",
                              valeur: "CDF",
                              onChanged: (val) {
                                setState(() {
                                  devise = val;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  buildTextField(
                    lineIcons: const Icon(LineIcons.edit),
                    name: "Nom complet du membre",
                    controller: nomComplet,
                  ),
                  buildTextField(
                    child: cbList(
                        list: listElement(val: moisData),
                        title: "Mois contribué",
                        valeur: null,
                        onChanged: (val) {
                          setState(() {
                            mois = val;
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        }),
                  ),
                  buildTextField(
                    child: cbList(
                        list: listElement(val: anneeData),
                        title: "Annee",
                        valeur: null,
                        onChanged: (val) {
                          setState(() {
                            annee = val;
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        }),
                  ),
                  const SizedBox(height: 10),
                  buildButton(
                      onPressed: () {
                        setState(() {
                          eventAddPaie();
                        });
                      },
                      context: w.width,
                      text: inProgress ? "..." : "Enregistrer",
                      color: color_green),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: h.height * .1,
            width: w.width,
            color: custom_white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              LineIcons.damagedHouse,
                              size: 30,
                              color: color_green,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Contribution".toUpperCase(),
                              style: const TextStyle(
                                color: custom_black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
