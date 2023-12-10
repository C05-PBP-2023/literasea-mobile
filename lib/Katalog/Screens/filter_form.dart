import 'package:flutter/material.dart';

class FilterForm extends StatefulWidget {
  final Function(String?, String?, int?) onFilter;

  const FilterForm({Key? key, required this.onFilter}) : super(key: key);

  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  final _formKey = GlobalKey<FormState>();
  String? authorName;
  String? publisher;
  int? publishedYear;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onFilter(authorName, publisher, publishedYear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Author Name'),
            onSaved: (value) => authorName = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Publisher'),
            onSaved: (value) => publisher = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Published Year'),
            keyboardType: TextInputType.number,
            onSaved: (value) => publishedYear = int.tryParse(value ?? ''),
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Filter'),
          ),
        ],
      ),
    );
  }
}
