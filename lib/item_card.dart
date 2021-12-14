import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final int age;
  final Function? onUpdate;
  final Function? onDelete;

  const ItemCard(this.name, this.age, {this.onUpdate, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: "aed9e0".toColor(),
        border: Border.all(
          color: Colors.blue.shade900,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              Text(
                "$age years old",
                style: GoogleFonts.poppins(),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                // ignore: deprecated_member_use
                child: RaisedButton(
                    shape: const CircleBorder(),
                    color: Colors.green[900],
                    child: const Center(
                        child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (onUpdate != null) onUpdate!();
                    }),
              ),
              SizedBox(
                height: 40,
                width: 60,
                // ignore: deprecated_member_use
                child: RaisedButton(
                    shape: const CircleBorder(),
                    color: Colors.red[900],
                    child: const Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (onDelete != null) onDelete!();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
