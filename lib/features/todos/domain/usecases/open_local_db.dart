import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/todo_repo.dart';


class OpenLocalDb implements AsyncEitherUsecase<Success, OpenLocalDbParams>{

  final TodoRepo _repo;

  OpenLocalDb(this._repo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(OpenLocalDbParams params) async{
    return await _repo.openLocalDb(currentUid: params.currentUid);
  }

}

class OpenLocalDbParams {
  final String currentUid;

  OpenLocalDbParams({required this.currentUid});
}

