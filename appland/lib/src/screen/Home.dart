import 'dart:math';

import 'package:app/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }
}

class _StateBody extends State<Home> {
  int i = 0;
  int x = 0;
  List colors = const [
    AppFont.blueColor,
    Color.fromARGB(255, 228, 10, 10),
    custom_orage,
  ];
  List colors1 = [
    color_blue,
    custom_red,
    custom_orag1,
  ];
  List icons = const <Widget>[
    Icon(
      LineIcons.peopleCarry,
      color: custom_white,
      size: 40,
    ),
    Icon(
      LineIcons.damagedHouse,
      color: custom_white,
      size: 40,
    ),
    Icon(
      LineIcons.user,
      color: custom_white,
      size: 40,
    ),
  ];
  Random random = Random();
  void changeIndex() {
    setState(() => i = random.nextInt(3));
  }

  List labeDashboard = ["Agent", "Maison", "Utilisateur"];
  List count = ["50", "540", "35"];

  @override
  Widget build(BuildContext context) {
    Size h = MediaQuery.of(context).size;
    Size w = MediaQuery.of(context).size;
    return SizedBox(
      height: h.height,
      width: w.width,
      child: Stack(children: [
        buildList(),
        Positioned(
          top: 0,
          child: Container(
            height: h.height * .09,
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
                              LineIcons.dashcube,
                              size: 30,
                              color: AppFont.blueColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Tableau de bord".toUpperCase(),
                              style: const TextStyle(
                                color: custom_black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
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

  Widget buildList() {
    FocusScopeNode focus = FocusScope.of(context);
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: color_grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              SizedBox(
                height: MediaQuery.of(context).size.height * .16,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return buildCard(
                      color: colors1[index],
                      onPressed: () {
                        setState(() {
                          x = index;
                        });
                      },
                      name: labeDashboard[index],
                      value: count[index],
                      widget: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: icons[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 0.0,
                  top: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "All",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildCard(
      {required String name,
      required String value,
      required Widget widget,
      required Color color,
      required VoidCallback onPressed}) {
    return Card(
      elevation: 1,
      borderOnForeground: true,
      color: color,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: MediaQuery.of(context).size.width * .32,
          width: MediaQuery.of(context).size.width * .32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                value,
                                style: const TextStyle(
                                  color: custom_black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
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
    );
  }
}
