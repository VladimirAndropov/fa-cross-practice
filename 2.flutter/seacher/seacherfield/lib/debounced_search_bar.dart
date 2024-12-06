import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async'; 

/// This is a simplified version of debounced search based on the following example:
/// https://api.flutter.dev/flutter/material/SearchAnchor-class.html#material.SearchAnchor.4
typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      print(error); // Should be 'Debounce cancelled' when cancelled.
      return null;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(_duration, _onComplete);
  }

  late final Timer _timer;
  final Duration _duration = const Duration(milliseconds: 500);
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError('Debounce cancelled');
  }
}

class DebouncedSearchBar<T> extends StatefulWidget {
  const DebouncedSearchBar({
    super.key,
    this.hintText,
    required this.resultToString,
    required this.resultTitleBuilder,
    required this.searchFunction,
    this.resultSubtitleBuilder,
    this.resultLeadingBuilder,
    this.onResultSelected,
  });

  final String? hintText;
  final String Function(T result) resultToString;
  final Widget Function(T result) resultTitleBuilder;
  final Widget Function(T result)? resultSubtitleBuilder;
  final Widget Function(T result)? resultLeadingBuilder;
  final Future<Iterable<T>> Function(String query) searchFunction;
  final Function(T result)? onResultSelected;

  @override
  State<StatefulWidget> createState() => DebouncedSearchBarState<T>();
}

class DebouncedSearchBarState<T> extends State<DebouncedSearchBar<T>> {
  final _searchController = SearchController();
  late final _Debounceable<Iterable<T>?, String> _debouncedSearch;
  final _debouncedSearchRx = BehaviorSubject<String>.seeded('');

  Future<Iterable<T>> _search(String query) async {
    print('Searching for: $query');
    if (query.isEmpty) {
      return <T>[];
    }

    try {
      final results = await widget.searchFunction(query);
      return results;
    } catch (error) {
      return <T>[];
    }
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<T>?, String>(_search);
    _searchController.addListener(() {
      _debouncedSearchRx.add(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncedSearchRx.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: _searchController,
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onTap: () {
            controller.openView();
          },
          leading: const Icon(Icons.search),
          hintText: widget.hintText,
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) async {
        final results = await _debouncedSearch(controller.text);
        if (results == null) {
          return <Widget>[];
        }
        // final results = await _debouncedSearchRx
        //     .debounceTime(const Duration(milliseconds: 500))
        //     .asyncMap((query) => _search(query))
        //     .first;
        return results.map((result) {
          return ListTile(
            title: widget.resultTitleBuilder(result),
            subtitle: widget.resultSubtitleBuilder?.call(result),
            leading: widget.resultLeadingBuilder?.call(result),
            onTap: () {
              widget.onResultSelected?.call(result);
              controller.closeView(widget.resultToString(result));
            },
          );
        }).toList();
      },
    );
  }
}