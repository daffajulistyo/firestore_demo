import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_demo/item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: const Text('Firestore Demo'),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                //! VIEW DATA HERE
                //? note: 1x Ambil
                // FutureBuilder<QuerySnapshot>(
                //   future: users.get(),
                //   builder: (_, snapshot) {
                //     if (snapshot.hasData) {
                //       return Column(
                //         children: snapshot.data!.docs
                //             .map(
                //               (e) => ItemCard((e.data() as dynamic)['name'],
                //                   (e.data() as dynamic)['age']),
                //             )
                //             .toList(),
                //       );
                //     } else {
                //       return const Text('Loading');
                //     }
                //   },
                // ),
                //? note: Sync
                StreamBuilder<QuerySnapshot>(
                  stream: users.orderBy('name').snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs
                            .map(
                              (e) => ItemCard(
                                (e.data() as dynamic)['name'],
                                (e.data() as dynamic)['age'],
                                onUpdate: () {
                                  users.doc(e.id).update(
                                    {'age': (e.data() as dynamic)['age'] + 1},
                                  );
                                },
                                onDelete: () {
                                  users.doc(e.id).delete();
                                },
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return const Text('Loading');
                    }
                  },
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 130,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: nameController,
                              decoration:
                                  const InputDecoration(hintText: "Name"),
                            ),
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: ageController,
                              decoration:
                                  const InputDecoration(hintText: "Age"),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.blue[900],
                            child: Text(
                              'Add Data',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              //! ADD DATA HERE
                              users.add({
                                'name': nameController.text,
                                'age': int.tryParse(ageController.text) ?? 0
                              });

                              nameController.text = '';
                              ageController.text = '';
                            }),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
