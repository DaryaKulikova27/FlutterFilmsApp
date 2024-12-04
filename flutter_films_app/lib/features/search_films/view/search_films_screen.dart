import 'package:flutter/material.dart';

class SearchFilmsScreen extends StatefulWidget {
  const SearchFilmsScreen({super.key, required this.title});
  final String title;

  @override
  State<SearchFilmsScreen> createState() => _SearchFilmsScreenState();
}

class _SearchFilmsScreenState extends State<SearchFilmsScreen> {
  final TextEditingController _textController = TextEditingController();
  String _enteredText = '';
  bool _isTextEntered = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateTextState);
  }

  void _updateTextState() {
    setState(() {
      _isTextEntered = _textController.text.isNotEmpty;
    });
  }

  void _sendText() {
    if (_isTextEntered) {
      setState(() {
        _enteredText = _textController.text;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: _sendText,
                    child: Icon(
                      Icons.send,
                      color: _isTextEntered ? Colors.black : Colors.grey,
                    ),
                  ),
                  fillColor: Colors.white, 
                  filled: true, 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
              ),
              const SizedBox(height: 80), 
              Image.asset(
                'assets/png/empty_films_list.png', 
                width: 200, 
                height: 300,
              )
            ]
          )
        )
    );
  }
}