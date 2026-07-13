import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/constants.dart';
import '../helpers/refresh_token_model.dart';
import '../helpers/secured_storage_helper.dart';
import '../helpers/sharedprefrences_helper.dart';
import 'api_constants.dart';

//Dio Helper That's Connect and Talk to API.
class DioHelper {
  static late Dio dio;

  //Here The Initialize of Dio and Start Connect to API Using baseUrl.
  static init() {
    dio = Dio(
      BaseOptions(
        //Here the URL of API.
        baseUrl: ApiConstants.apiBaseUrl,
        //  receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
          //'lang':'en'
        },
      ),
    );


    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401 ) {
          final String? refreshToken = await SecureStorageHelper.getData(key:SecureStorageKeys.refreshToken );
          final String? token = await SecureStorageHelper.getData(key:SecureStorageKeys.accessToken );
          RefreshTokenModel? refreshTokenModel;
          debugPrint("===================> 401 Error Caught! Attempting Token Refresh...");
          debugPrint(refreshToken);
          if (refreshToken != null) {
            try{
              final response = await  getData(
                token: token,
                url: "${ApiConstants.refreshTokenUrl}$refreshToken",
              );

              if (response.statusCode == 200) {
                final refreshTokenModel = RefreshTokenModel.fromJson(response.data);
                final String newAccessToken = refreshTokenModel.accessToken.toString();

                // 4. Persist the newly fetched access token
                await SecureStorageHelper.saveData(key: SecureStorageKeys.accessToken, value: newAccessToken);
                debugPrint("====> TOKEN REFRESHED SUCCESSFULLY: $newAccessToken");

                // 5. CLONE AND RE-CALL THE ORIGINAL FUNCTION SEAMLESSLY
                final requestOptions = e.requestOptions;

                // Update authorization header with the brand new token
                requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

                // Re-submit the exact same network request (this repeats your original function)
                final clonedResponse = await dio.fetch(requestOptions);

                // Resolve the handler with the successful cloned response back to Bloc
                return handler.resolve(clonedResponse);
              }
              if (response.statusCode == 403) {
                await SecureStorageHelper.removeData(key: SecureStorageKeys.accessToken);
              }
            }catch(e){
              debugPrint("====> Token refresh request failed: $e");

            }

          }

        }
        return handler.next(e);
      },
    ));
  }

  //This Function to call API and get Some Data based on url(End Points) and Headers needed in API to get the Specific Data.
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
      };
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    }  catch (e) {
      rethrow;
    }
  }

  //This Function that's Used To Post Data to API based on URL(End Points) and Headers.
  static Future<Response> postData({
    required String url,
    required dynamic data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  })async {
    String rawJsonData = jsonEncode(data);
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        "Accept": "*/*",
        "Content-Type": "application/json",
      };

      final Response response = await dio.post(
        url,
        data: rawJsonData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }

  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> putData({
    required String url,
    required dynamic data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    String rawJsonData = jsonEncode(data);

    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
      };
      final Response response = await dio.put(
        url,
        data: rawJsonData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    }  catch (e) {
      rethrow;
    }

  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
    bool files = false,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio.patch(
      url,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    //String lang = 'en',
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        // 'Authorization': token ,
        //'Content-Type': 'application/json',
      };
      final Response response = await dio.delete(
        url,
        data: data,
      );
      return response;
    }  catch (e) {
      rethrow;
    }

  }



  static Future<Response> postImageData({
    required String url,
    required dynamic data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  })async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        "Accept": "*/*",
        "Content-Type": "application/json",
      };

      final Response response = await dio.post(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }

  }
















}


