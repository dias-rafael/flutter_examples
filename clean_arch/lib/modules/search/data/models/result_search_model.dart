import 'dart:convert';

import 'package:clean_arch/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String? img;
  final String? title;
  final String? content;

  ResultSearchModel({this.img, this.title, this.content});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (img != null) {
      result.addAll({'img': img});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (content != null) {
      result.addAll({'content': content});
    }

    return result;
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      img: map['img'],
      title: map['title'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) => ResultSearchModel.fromMap(json.decode(source));
}
