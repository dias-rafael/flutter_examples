import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchByText {
  //Either força tratamento de erros no contrato
  Future<Either<FailureSearch, List<ResultSearch>?>?>? call(String? searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository? repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>?>?>? call(String? searchText) async {
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }
    return repository?.search(searchText);
    // TODO: implement call
    throw UnimplementedError();
  }
}
