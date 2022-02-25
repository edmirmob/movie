import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchField extends StatefulWidget {
  final String initialValue;
  final String hint;
  final void Function(String value) onChanged;

  SearchField({
    required this.initialValue,
    required this.hint,
    required this.onChanged,
  });

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> with RouteAware {
  final _searchController = BehaviorSubject<String>();
  final _isSearching = BehaviorSubject<bool>();
  late TextEditingController _textEditingController;
  late StreamSubscription _searchSubscription;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
    _searchSubscription = _searchController
        .distinct()
        .debounceTime(
          const Duration(milliseconds: 500),
        )
        .listen(
      (value) {
        widget.onChanged(value);
        if (value.isEmpty) {
          _isSearching.add(false);
        } else {
          _isSearching.add(true);
        }
      },
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _isSearching.close();
    _searchController.close();
    _searchSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(32, 54, 93, 0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: _textEditingController,
        onChanged: (String value) {
          _searchController.add(value);
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorBorder: InputBorder.none,
            suffixIcon: StreamBuilder<bool>(
                initialData: false,
                stream: _isSearching,
                builder: (context, value) {
                  return GestureDetector(
                    onTap: value.hasData && value.data == true
                        ? () {
                            _textEditingController.clear();
                            _searchController.add('');
                            FocusScope.of(context).unfocus();
                          }
                        : null,
                    child: Icon(
                      value.data == true ? Icons.close : Icons.search_outlined,
                      size: 16,
                      color: Colors.black,
                    ),
                  );
                }),
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}
