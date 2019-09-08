import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'product_row_item.dart';
import 'search_bar.dart';
import 'styles.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {



  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);//这里的级联操作是对等号左边的_controller进行的
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }                                     // TO HERE



  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final results = model.search(_terms);

    return DecoratedBox(
      decoration: const BoxDecoration(
      //  color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ProductRowItem(
                  index: index,
                  product: results[index],
                  lastItem: index == results.length - 1,
                ),
                itemCount: results.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}