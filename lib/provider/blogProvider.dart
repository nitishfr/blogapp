import 'package:flutter/material.dart';

import '../models/blogModel.dart';

class BlogProvider with ChangeNotifier {
  List<BlogModel> blogList = [];
  void updateBlogList(List<BlogModel> blogList) {
    this.blogList = blogList;
    notifyListeners();
  }
}
