import 'dart:convert';

import 'package:alphabet_search_view/alphabet_search_view.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';


// final List<Actor> actors = [
//     Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
//     Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
//     Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
//     Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
//     Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
//     Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
//   ];

//   final Map<String, List<Actor>> mapOfActors = {
//     'test 1': [
//       Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
//       Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
//       Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
//     ],
//     'test 2': [
//       Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
//       Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
//       Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
//     ]
//   };
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


class ModeListWithBuilderExamplePage extends StatefulWidget {
  const ModeListWithBuilderExamplePage({Key? key}) : super(key: key);

  @override
  State<ModeListWithBuilderExamplePage> createState() =>
      _ModeListWithBuilderExamplePageState();
}

class _ModeListWithBuilderExamplePageState
    extends State<ModeListWithBuilderExamplePage> {

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
          child:  AlphabetSearchView<DataItem>.list(
          decoration: AlphabetSearchDecoration.fromContext(
            context,
            titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          list: listItems
              .map(
                (e) => AlphabetSearchModel<DataItem>(
                  title: e.id,
                  subtitle: e.label,
                  data: e,
                ),
              )
              .toList(),
          onItemTap: (_, __, item) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(item.title),
            ));
          },
          buildItem: (_, index, item) {
            // return ListTile(
            //   title: Text(item.title),
            //   subtitle: Text(item.data.name),
            // );
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
                            item.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            item.subtitle!,
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
}
