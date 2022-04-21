import 'package:clean_arch/modules/search/data/datasource/search_datasource.dart';
import 'package:clean_arch/modules/search/data/models/result_search_model.dart';
import 'package:clean_arch/modules/search/data/repositories/search_repository_impl.dart';
import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('deve retornar uma lista de ResultSearch', () async {
    when(datasource.getSearch(any)).thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search("rafael");

    expect(result?.getOrElse(() => []), isA<List<ResultSearch>>());
  });

  test('deve retornar erro se datasource falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("rafael");

    expect(result?.fold(id, id), isA<DataSourceError>());
  });
}
