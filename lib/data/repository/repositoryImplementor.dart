import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/data/mapper/mapper.dart';
import 'package:learning_mvvm_architecture/data/network/errorHandler.dart';
import 'package:learning_mvvm_architecture/data/network/failure.dart';
import 'package:learning_mvvm_architecture/data/request/request.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/domain/repository/repository.dart';
import '../dataSource/localDataSources.dart';
import '../dataSource/remoteDataSource.dart';
import '../network/networkInfo.dart';
import 'dart:developer';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        //call the api
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //right -> authentication (Either <Failure or Authenticate>)
          return Right(response.toDomain());
        } else {
          //return biz logic server
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgottenPassword(String email) async {
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.forgottenPassword(email);

        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,response.message ?? ResponseMessage.UNKNOWN));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        //call the api
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //right -> authentication (Either <Failure or Authenticate>)
          return Right(response.toDomain());
        } else {
          //return biz logic server
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      // get from cache
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          //call the api
          final response = await _remoteDataSource.getHome();

          if (response.status == ApiInternalStatus.SUCCESS) {
            //success
            //right -> authentication (Either <Failure or Authenticate>)
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            //return biz logic server
            log('here home');
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.UNKNOWN));
          }
        } catch (error) {
          return (Left(ErrorHandler
              .handle(error)
              .failure));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ExerciseDetails>> getExerciseDetails() {
    // TODO: implement getExerciseDetails
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, ExerciseDetails>> getExerciseDetails() async {
  //   try {
  //     // get data from cache
  //     final response = await _localDataSource.getExerciseDetails();
  //     return Right(response.toDomain());
  //   } catch (cacheError) {
  //     if (await _networkInfo.isConnected) {
  //       try {
  //         final response = await _remoteDataSource.getExerciseDetails();
  //         if (response.status == ApiInternalStatus.SUCCESS) {
  //           _localDataSource.saveExerciseDetailsToCache(response);
  //           return Right(response.toDomain());
  //         } else {
  //           return Left(Failure(response.status ?? ResponseCode.DEFAULT,
  //               response.message ?? ResponseMessage.UNKNOWN));
  //         }
  //       } catch (error) {
  //         return Left(ErrorHandler.handle(error).failure);
  //       }
  //     } else {
  //       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  //     }
  //   }
  // }
  // }

}
