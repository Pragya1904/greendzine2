import 'package:flutter/material.dart';
import 'package:greendzine2/home/data/data_sources/api_services.dart';
import 'package:greendzine2/home/presentation/widgets/custom_list_card.dart';

import '../../data/models/data_model.dart';


class DataList extends StatefulWidget {
  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<Data>? dataList = snapshot.data;
          return ListView.builder(
            itemCount: dataList?.length ?? 0,
            itemBuilder: (context, index) {
              final Data? data = dataList?[index];
              return CustomListCard(data: data,);
            },
          );
        }
      },
    );
  }}