import 'package:clean_arch/app_widget.dart';
import 'package:clean_arch/modules/search/data/repositories/search_repository_impl.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  //Injeção dependência
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDataSource(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
      ];

  @override
  List get routers => throw UnimplementedError();

  @override
  Widget get bootstrap => AppWidget();
}
