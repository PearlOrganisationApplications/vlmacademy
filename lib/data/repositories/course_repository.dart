import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:vlm_academy/data/models/course_model.dart';

class CourseRepository {
  Future<List<CourseModel>> loadCourses() async {
    final data = await rootBundle.loadString('assets/data/courses.json');
    final List jsonResult = json.decode(data);
    return jsonResult.map((e) => CourseModel.fromJson(e)).toList();
  }
}
