import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Exemplo abaixo sem Mockito
// class SearchRepositoryMock implements SearchRepository {
//   @override
//   Future<Either<FailureSearch, List<ResultSearch>?>> search(String searchText) {
//     // TODO: implement search
//     throw UnimplementedError();
//   }
// }

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();

  final usecase = SearchByTextImpl(repository);

  test('deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any)).thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await usecase("rafael");

    //expect(result, isA<Right>());
    expect(result?.getOrElse(() => []), isA<List<ResultSearch>>());
  });

  test('deve retornar uma exception', () async {
    when(repository.search(any)).thenAnswer((_) async => const Right(<ResultSearch>[]));

    var result = await usecase(null);
    expect(result?.fold((l) => l, (r) => r), isA<InvalidTextError>());

    result = await usecase("");
    expect(result?.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });
}
