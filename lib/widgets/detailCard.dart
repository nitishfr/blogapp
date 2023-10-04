import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/blogModel.dart';

class DetailCard extends StatefulWidget {
  BlogModel blogModel;
  DetailCard({required this.blogModel});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  bool isLikeAnimating = false;
  int commentslen = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final UserData user = Provider.of<UserProvider>(context).getUser;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(widget.blogModel.imageUrl), fit: BoxFit.fill)),
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: width,
              child: Text(
                widget.blogModel.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: height * 0.03, color: Colors.deepPurple, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
