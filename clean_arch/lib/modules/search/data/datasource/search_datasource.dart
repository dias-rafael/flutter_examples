import 'package:clean_arch/modules/search/data/models/result_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultSearchModel>?>? getSearch(String? searchText);
}
