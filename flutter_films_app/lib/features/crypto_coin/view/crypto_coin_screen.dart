import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  final String coinName;
  const CryptoCoinScreen({required this.coinName, super.key});

  @override
  State<StatefulWidget> createState() => _CryptoCoinScreen();
}

class _CryptoCoinScreen extends State<CryptoCoinScreen> {
  late String? coinName;

  @override
  void initState() {
    coinName = widget.coinName;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
        automaticallyImplyLeading: true,
      ),
    );
  }
}