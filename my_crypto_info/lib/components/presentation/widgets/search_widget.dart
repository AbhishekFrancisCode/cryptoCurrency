import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String title;
  final ValueChanged<String> onTextChanged;

  const SearchWidget({this.title, this.onTextChanged});

  @override
  _SearchWidgetState createState() => _SearchWidgetState(this.onTextChanged);
}

class _SearchWidgetState extends State<SearchWidget> {
  final ValueChanged<String> onPressed;
  final controller = TextEditingController();
  bool _hasText = false;

  _SearchWidgetState(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: TextField(
                key: Key("valueText"),
                style: TextStyle(fontSize: 18),
                onChanged: (text) {
                  setState(() {
                    _hasText = text.isNotEmpty;
                  });
                },
                onSubmitted: (text) {
                  onPressed(text);
                },
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Enter currency pair",
                    prefixIcon: Icon(Icons.search, color: Colors.grey[700]))),
          ),
          Visibility(
              visible: _hasText,
              child: IconButton(
                  onPressed: () {
                    controller.text = "";
                    setState(() {
                      _hasText = controller.text.isNotEmpty;
                    });
                  },
                  icon: Icon(
                    Icons.highlight_remove_rounded,
                    color: Colors.grey[700],
                  ))),
          Visibility(
              visible: _hasText,
              child: TextButton(
                  key: Key("searchKey"),
                  onPressed: () {
                    onPressed(controller.text);
                  },
                  child: Text("Search")))
        ],
      ),
    );
  }
}
