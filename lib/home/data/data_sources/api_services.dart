import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/data_model.dart';

  final String url = 'https://reqres.in/api/users?page=2';

  Future<List<Data>> getData() async{
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode==200)
      {

        final jsonData = jsonDecode(response.body);

        final List<dynamic> dataJson = jsonData['data'];
        final List<Data> dataList = dataJson.map((json) => Data.fromJson(json)).toList();
        //  print("check data $dataJson");
        return dataList;
      }
      else
      {
        print("response code is not 200");
        throw("couldn't fetch the blogs");
      }
    }
    catch(exception){

      print(exception);
      print("Error during fetching response from api check ApiService class!!");

    }
    return [];
  }
