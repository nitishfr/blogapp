import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/blogModel.dart';
import '../provider/blogProvider.dart';

class ApiServices {
  List<BlogModel> blogList = [];
  Future<List<BlogModel>> fetchBlogs(BuildContext context) async {
    BlogProvider blogProvider = Provider.of(context, listen: false);
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        print('Response data: ${response.body}');
        Map<String, dynamic> data = json.decode(response.body);
        data["blogs"].forEach((element) {
          {
            if (element["id"] != null && element["image_url"] != null && element["title"] != null) {
              BlogModel blogModel = BlogModel.fromJson(element);
              if (!blogModel.imageUrl.endsWith("(1).png")) {
                blogList.add(blogModel);
              }
            }
          }
        });
        blogProvider.updateBlogList(blogList);
        return blogList;
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
        return [];
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
      return [];
    }
  }
}
