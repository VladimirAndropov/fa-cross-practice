import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loadmore_listview/loadmore_listview.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


// part 'person.g.dart';

// @JsonSerializable(explicitToJson: true)
class DataItem {
  final String id;
  final String label;
  final String description;

  DataItem({required this.id, required this.label, required this.description});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
        id: (json['id'] as String?) ?? '',
        label: (json['label'] as String?) ?? '',
        description: (json['description'] as String?) ?? '');
  }

// factory DataItem.fromJson(Map<String, dynamic> json) =>
//       _$DataItemFromJson(json);
//   Map<String, dynamic> toJson() => _$DataItemToJson(this);

  // method
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'id': id,
      'description': description,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  @override
  String toString() {
    return id;
  }
}

class LoadMoreListV extends StatefulWidget {
  const LoadMoreListV({super.key});

  @override
  State<LoadMoreListV> createState() => _MyAppState();
}

class _MyAppState extends State<LoadMoreListV>
    with SingleTickerProviderStateMixin {

  bool _hasNextData = true;
  List<DataItem> listItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Expanded(
          child:  LoadMoreListView.separated(
                hasMoreItem: _hasNextData,
                onLoadMore: loaMoreList,
                onRefresh: refreshList,
                refreshBackgroundColor: Colors.blueAccent,
                refreshColor: Colors.white,
                loadMoreWidget: Container(
                  margin: const EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                  ),
                ),
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.25),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: Image.network(
                                '')
                            .image,
                      ),
                      border: Border.all(
                          width: 5,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(.1)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            listItems[index].label,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            listItems[index].description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
        ),
      ],
    );
  }

  Future getList() async {
    listItems.clear();
    _hasNextData = true;
    String jsonString = await rootBundle.loadString('assets/prepods.json');
    List<dynamic> parsed = json.decode(jsonString);

// List<Map<String, dynamic>> ppp = parsed.cast<Map<String, dynamic>>();


    setState(() {
      listItems = List<DataItem>.from(
          parsed.map<DataItem>((dynamic e) => DataItem.fromJson(e)));
    });
  }

  Future refreshList() async {
    listItems.clear();
    await loaMoreList();
  }

  Future<List<DataItem>> loaMoreList() async {
    String jsonString = await rootBundle.loadString('assets/prepods.json');
    List<dynamic> parsed = json.decode(jsonString);

    listItems = List<DataItem>.from(
        parsed.map<DataItem>((dynamic e) => DataItem.fromJson(e)));

    setState(() {
      _hasNextData = listItems.length < 100;
    });

    return listItems;
  }
}
