
import 'package:blogapp/Screens/savedScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DATABASE/dbManager.dart';
import '../Services/api.dart';
import '../widgets/blogCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
                onPressed: () {
                  print("nitish");
                  setState(() {});
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => SavedScreen()));
                },
                icon: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ))
          ],
        ),
        body: FutureBuilder<dynamic>(
            future: ApiServices().fetchBlogs(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        blogModel: snapshot.data[index],
                        save: _insert,
                        saved: false,
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  void _insert(Map<String, dynamic> row) async {
    print('insert....');
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }
}
