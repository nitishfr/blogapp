
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DATABASE/dbManager.dart';
import '../models/blogModel.dart';
import '../provider/blogProvider.dart';
import '../widgets/blogCard.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    BlogProvider blogProvider = Provider.of(context, listen: false);
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
            "Saved Blogs",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: height * 0.03, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ))
          ],
        ),
        body: FutureBuilder<dynamic>(
            future: _query(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        blogModel: snapshot.data[index],
                        save: _insert,
                        saved: true,
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  void _insert(Map<String, dynamic> row) async {
    print('insert stRT');
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  Future<List<BlogModel>> _query() async {
    List<BlogModel> ls = [];
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    for (var i in allRows) {
      BlogModel blogModel = BlogModel.fromJson({
        "id": i["_id"],
        "image_url": i["img"],
        "title": i["title"],
      });
      ls.add(blogModel);
    }
    return ls;
  }
}
