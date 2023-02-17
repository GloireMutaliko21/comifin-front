// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:async';
import 'dart:convert';

import 'package:app/src/app/data/Datasource.dart';
import 'package:app/src/models/contribution.dart';
import 'package:app/src/models/session.dart';
import 'package:app/src/utils/CustomField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/Utils.dart';
import 'Principale.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }
}

class _StateBody extends State<Login> {
  bool status = true;
  bool setSession = false;
  bool getStatu = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    getUtilsData();
  }

  Future<bool> getUtilsData() async {
    try {
      var resultActeGen = await DataSource.GetInstance!
          .getData(url: 'get_list_actes_for_select.php');
      if (resultActeGen.statusCode == 200) {
        var res = await jsonDecode(resultActeGen.body);
        setState(() {
          acteGen.clear();
          for (var i = 0; i < res['actes'].length; i++) {
            acteGen.add(
                "${res['actes'][i]['idacte']}-${res['actes'][i]['nomActe']}");
          }
        });
      }

      var result = await DataSource.GetInstance!
          .getData(url: 'get_list_taxes_for_select.php');
      if (result.statusCode == 200) {
        var res = await jsonDecode(result.body);
        setState(() {
          contrib.clear();
          for (var i = 0; i < res['taxes'].length; i++) {
            contrib.add(
                "${res['taxes'][i]['idtaxe']}-${res['taxes'][i]['nomTaxe']}");
          }
        });
      }

      var resultMois = await DataSource.GetInstance!
          .getData(url: 'get_list_mois_for_select.php');
      if (resultMois.statusCode == 200) {
        var res = await jsonDecode(resultMois.body);
        setState(() {
          moisData.clear();
          for (var i = 0; i < res['mois'].length; i++) {
            moisData
                .add("${res['mois'][i]['idmois']}-${res['mois'][i]['mois']}");
          }
        });
      }

      var resultAnnee = await DataSource.GetInstance!
          .getData(url: 'get_list_annees_for_select.php');
      if (resultAnnee.statusCode == 200) {
        var res = await jsonDecode(resultAnnee.body);
        setState(() {
          anneeData.clear();
          for (var i = 0; i < res['annees'].length; i++) {
            anneeData.add(
                "${res['annees'][i]['idanne']}-${res['annees'][i]['anne']}");
          }
        });
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> login() async {
    try {
      getUtilsData();
      setState(() {
        inProgress = true;
      });
      var resultat = await DataSource.GetInstance!.isSave(
          url: 'login/login.php',
          body: {'user': username.text.trim(), 'pass': password.text.trim()});
      if (resultat.statusCode == 200) {
        var res = await jsonDecode(resultat.body);
        if (res.length > 0) {
          await MyPreferences.getInit.setPersistence(res).then((value) {
            setState(() {
              // print(res['id']);
              inProgress = false;
            });
          });
          return true;
        } else {
          // Display a message login failed
        }
      }
    } catch (_) {
      setState(() {
        inProgress = false;
      });
      print(_.toString());
    }
    return false;
  }

  eventLogin() async {
    bool status = await login();
    await login();
    if (status) {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const Principal();
        }));
      });
    } else {
      print(status);
      setState(() {
        inProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var focus = FocusScope.of(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          Positioned(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height / 1.5,
                      decoration: const BoxDecoration(
                        // color: custom_blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        // height: size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const SizedBox(height: 10),
                                Expanded(
                                  child: Image.asset("assets/img/logo.png",
                                      width: size.width * .4),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(height: 20),
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                buildTextField(
                                    lineIcons: const Icon(LineIcons.user),
                                    name: "Username ID",
                                    controller: username),
                                buildTextField(
                                  lineIcons: const Icon(LineIcons.lock),
                                  obscureText: status,
                                  ispassword: true,
                                  name: "Password",
                                  status: status,
                                  iconButton: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        status = !status;
                                      });
                                    },
                                    icon: status
                                        ? const Icon(LineIcons.eyeSlash,
                                            size: 20)
                                        : const Icon(LineIcons.eye, size: 20),
                                  ),
                                  controller: password,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            activeColor: color_green,
                                            value: setSession,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                setSession = value!;
                                              });
                                            }),
                                        const Text(
                                            "Gardez votre session ouverte",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ))
                                      ]),
                                ),
                                const SizedBox(height: 10),
                                buildButton(
                                    color: color_green,
                                    text: inProgress ? "..." : "Connexion",
                                    onPressed: () {
                                      setState(() {
                                        eventLogin();
                                      });
                                    }),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildButton({VoidCallback? onPressed, var text, Color? color}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "$text",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
