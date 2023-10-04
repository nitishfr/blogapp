import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../DATABASE/dbManager.dart';
import '../Screens/detailScreen.dart';
import '../models/blogModel.dart';
import '../utils/utils.dart';
import 'likeAnimation.dart';

class PostCard extends StatefulWidget {
  BlogModel blogModel;
  Function save;
  bool saved;
  PostCard({required this.blogModel, required this.save, required this.saved});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentslen = 0;
  bool saved = false;
  final dbHelper = DatabaseHelper.instance;
  check() async {
    bool fill = await dbHelper.queryData(widget.blogModel.id);
    setState(() {
      saved = fill;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final UserData user = Provider.of<UserProvider>(context).getUser;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.push(context,
          CupertinoPageRoute(builder: (context) => DetailScreen(blogModel: widget.blogModel))),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.deepPurple,
          child: Column(
            children: [
              //image section......................................
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  color: Colors.grey,
                  shadowColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GestureDetector(
                    onDoubleTap: () async {},
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(widget.blogModel.imageUrl), fit: BoxFit.fill)),
                        width: double.infinity,
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: height * 0.02,
                            ),
                            isAnimating: isLikeAnimating,
                            duration: Duration(milliseconds: 400),
                            onEnd: () {
                              setState(() {
                                isLikeAnimating = false;
                              });
                            }),
                      ),
                    ]),
                  ),
                ),
              ),
              //Like Comment...................................................................
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple, borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.001, horizontal: width * 0.015),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: FaIcon(
                                    Icons.favorite,
                                    color: saved ? Colors.red : Colors.white,
                                    size: height * 0.03,
                                  ),
                                  onPressed: () {
                                    if (saved) {
                                      _delete(widget.blogModel.id.toString());
                                      setState(() {
                                        saved = false;
                                      });
                                      showToast(context, "Unsaved");
                                    } else {
                                      widget.save({
                                        DatabaseHelper.columnTitle: widget.blogModel.title,
                                        DatabaseHelper.columnImg: widget.blogModel.imageUrl,
                                        DatabaseHelper.columnId: widget.blogModel.id.toString()
                                      });
                                      showToast(context, "Saved");
                                      setState(() {
                                        saved = true;
                                      });
                                    }
                                  },
                                ),
                              ),
                              Text(
                                " Favorite ",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.015),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: FaIcon(
                          saved ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.deepPurple,
                          size: height * 0.03,
                        ),
                        onPressed: () {
                          if (saved) {
                            _delete(widget.blogModel.id.toString());
                            setState(() {
                              saved = false;
                            });
                          } else {
                            widget.save({
                              DatabaseHelper.columnTitle: widget.blogModel.title,
                              DatabaseHelper.columnImg: widget.blogModel.imageUrl,
                              DatabaseHelper.columnId: widget.blogModel.id.toString()
                            });
                            setState(() {
                              saved = true;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              //Description..........................................................
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(style: TextStyle(color: Colors.black), children: [
                          // TextSpan(
                          //   text: widget.snap['username'],
                          //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                          // ),
                          TextSpan(
                            text: widget.blogModel.title,
                            style: TextStyle(color: Colors.deepPurple.withOpacity(0.8)),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _delete(String id) async {
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    // _query();
  }
}
