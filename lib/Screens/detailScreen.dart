import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/blogModel.dart';
import '../widgets/detailCard.dart';

class DetailScreen extends StatefulWidget {
  BlogModel blogModel;
  DetailScreen({Key? key, required this.blogModel}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // BlogProvider blogProvider = Provider.of(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Blogs",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: height * 0.03, fontWeight: FontWeight.w500),
        ),
      ),
      body: DetailCard(blogModel: widget.blogModel),
    );
  }
}
