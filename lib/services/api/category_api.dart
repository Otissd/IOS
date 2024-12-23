import 'package:musicapp/models/categories.dart';

class CategoryApi {
  
  Future<List<Category>> fetchCategories() async {
    // Giả lập độ trễ khi gọi API
    await Future.delayed(const Duration(seconds: 2));

    // Dữ liệu danh mục giả lập
    return [
      Category(
        id: '1',
        title: 'Những gì bạn thích',
        albumIds: ['6', '7', '1', '2', '3', '4', '5'],
      ),
      Category(
        id: '2',
        title: 'Gợi Ý',
        albumIds: ['6', '7', '1', '2', '3', '4', '5'],
      ),
      Category(
        id: '3',
        title: 'BXH',
        albumIds: ['6', '7', '1', '2', '3', '4', '5'],
      ),
      Category(
        id: '4',
        title: 'BXH Quốc Tế',
        albumIds: ['6', '7', '1', '2', '3', '4', '5'],
      ),
       Category(
        id: '5',
        title: 'BXH Quốc Tế',
        albumIds: ['6', '7', '1', '2', '3', '4', '5'],
      ),
       Category(
        id: '6',
        title: 'BXH Quốc Tế',
        albumIds: ['6', '7', '1', '2', '3', '4', '5'],
      ),
    ];
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/category.dart';

// class CategoryApi {
//   static const String _baseUrl = 'https://example.com/api/categories';

//   static Future<List<Category>> fetchCategories() async {
//     final response = await http.get(Uri.parse(_baseUrl));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Category.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }
// }
