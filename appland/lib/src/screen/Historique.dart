import 'dart:convert';

import 'package:app/src/app/data/Datasource.dart';
import 'package:app/src/utils/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/CustomField.dart';
import '../utils/Utils.dart';

class Historique extends StatefulWidget {
  const Historique({Key? key}) : super(key: key);

  @override
  State<Historique> createState() => _StateBody();
}

class _StateBody extends State<Historique> {
  Map<String, dynamic> listedata = Map();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getUtilsData() async {
    try {
      var result = await DataSource.GetInstance!.getData(url: '/paiement/all');
      if (result.statusCode == 200) {
        setState(() {
          listedata = jsonDecode(result.body);
        });
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
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
                    lineIcons: const Icon(LineIcons.search),
                    name: "Rechercher",
                    controller: null,
                  ),
                  ListView.builder(
                    itemCount: listedata.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardOper(
                        devise: listedata[index]['devise'],
                        montant: listedata[index]['montant'],
                        date:
                            "${listedata[index]['mois']} - ${listedata[index]['annee']}",
                        motif: listedata[index]['motif'],
                        user: listedata[index]['agent'] ||
                            listedata[index]['acteGen'],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 2,
          child: Container(
            height: h.height * .1,
            width: w.width,
            color: custom_white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                LineIcons.history,
                                size: 30,
                                color: color_green,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Historique".toUpperCase(),
                                style: const TextStyle(
                                  color: custom_black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Center(
                          child: Icon(
                            LineIcons.print,
                            size: 30,
                            color: color_green,
                          ),
                        ),
                      ],
                    ),
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

class CardOper extends StatelessWidget {
  final type;
  final montant;
  final date;
  final motif;
  final user;
  final devise;

  const CardOper({
    Key? key,
    this.type,
    this.montant,
    this.date,
    this.motif,
    this.user,
    this.devise,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
      child: Material(
        elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 100,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: type != 'Sortie'
                                        ? const Color(0xFF42A5F5)
                                        : const Color(0xfff8b250),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  "$type",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              "${devise == 'USD' ? "USD" : 'CDF'} $montant",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              "$date",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              "$motif",
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: 14,
                                ),
                                Expanded(
                                  child: Text(
                                    "$user",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      // onTap: onPressed,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color_green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.rate_review_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
