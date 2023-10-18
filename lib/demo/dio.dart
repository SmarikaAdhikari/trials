// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, file_names, await_only_futures

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:get/get.dart' as gt;
import 'package:nb_utils/nb_utils.dart';
import 'package:trials/demo/cons/constants.dart';
import 'package:trials/demo/cons/my_config.dart';

class Api {
  final Dio api = Dio();

  final dio = createDio();

  final tokenDio = Dio(BaseOptions(baseUrl: getAppUrl()));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    // String accesstoken = StorageUtil.getString(access);
    var dio = Dio(BaseOptions(
      baseUrl: getAppUrl(),
      receiveTimeout: 150000, // 15 seconds
      connectTimeout: 150000,
      sendTimeout: 150000,
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    return dio;
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    DioError? error,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    print("300e");
    try {
      Response response = await dio.post<String>(
        uri,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      final message = json.decode(response.data)["message"];
      if (message != null) {
        Fluttertoast.showToast(msg: message);
      }

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    DioError? error,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.get<String>(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      // refreshToken();
      throw const FormatException("Unable to get the data");
    } catch (e) {
      print(e.toString());

      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    DioError? error,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.put<String>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      final message = json.decode(response.data)["message"];
      Fluttertoast.showToast(msg: message);

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to get the data");
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    Future? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await dio.delete<String>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to delete the data");
    } catch (e) {
      rethrow;
    }
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getStringAsync(accessToken);
    print(token);

    // options.headers.addAll({
    //   "Authorization": token.isEmptyOrNull ? "" : "Bearer $token",
    //   'content-Type': 'application/json',
    //   "validateStatus": (_) => true,
    // });
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err.type);
    print(err.response);
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions, "");
      case DioErrorType.response:
        String errorMsg =
            json.decode(err.response.toString())["error"]["message"];
        Fluttertoast.showToast(msg: errorMsg);
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, errorMsg);
          case 401:
            throw UnauthorizedException(err.requestOptions, errorMsg);
          case 404:
            throw NotFoundException(err.requestOptions, errorMsg);
          case 409:
            throw ConflictException(err.requestOptions, errorMsg);
          case 500:
            throw InternalServerErrorException(err.requestOptions, errorMsg);
        }
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions, "Failed");
      case DioErrorType.cancel:
        break;
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    return error.toString();
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);
  @override
  String toString() {
    return error.toString();
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    return error.toString();
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r, String errorMsg)
      : super(
          requestOptions: r,
          error: errorMsg,
        );

  @override
  String toString() {
    // gt.Get.toNamed("/login");
    // AppNavigatorService.pushNamedAndRemoveUntil("login");
    return error.toString();
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    return error.toString();
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);
  @override
  String toString() {
    return error.toString();
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r, String errorMsg)
      : super(requestOptions: r, error: errorMsg);

  @override
  String toString() {
    // AppNavigatorService.pushNamedAndRemoveUntil("login");

    return error.toString();
  }
}
