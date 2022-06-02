import 'dart:convert';

import 'package:clean_arch/app_module.dart';
import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'modules/search/external/datasources/github_datasources_test.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  Modular.init(AppModule());
  AppModule().changeBinds([Bind<Dio>((i) => dio)]);
  test('deve recuperar usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('deve trazer uma lista de ResultSearch', () async {
    when(dio.get("https://api.github.com/search/users?q=")).thenAnswer((_) async => Response(
        data: jsonDecode(githubResult),
        statusCode: 200,
        requestOptions: RequestOptions(path: "https://api.github.com/search/users?q=")));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("rafael");
    expect(result?.getOrElse(() => []), isA<List<ResultSearch>>());
  });
}
