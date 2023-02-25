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
  List listedata = [];

  @override
  void initState() {
    getUtilsData();
    super.initState();
  }

  Future<bool> getUtilsData() async {
    try {
      var result =
          await DataSource.GetInstance!.getData(url: 'get_list_payement.php');
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildTextField(
                lineIcons: const Icon(LineIcons.search),
                name: "Rechercher",
                controller: null,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listedata.length,
                  itemBuilder: (context, int index) {
                    var data = listedata[index];
                    return CardOper(
                      date: data['datePayement'],
                      devise: data['device'],
                      id: data['idpayement'],
                      montant: data['montant'],
                      motif:
                          "${data['Fk_idtaxe']}     ${data['Fk_idmois']}/${data['Fk_idanne']}",
                      user: data['exploitant'].length > 0
                          ? data['exploitant']
                          : data['Fk_idacte'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardOper extends StatelessWidget {
  final id;
  final montant;
  final date;
  final motif;
  final user;
  final devise;

  const CardOper({
    Key? key,
    this.id,
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
                                    color: id != 'Sortie'
                                        ? const Color(0xFF42A5F5)
                                        : const Color(0xfff8b250),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  "$id",
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
