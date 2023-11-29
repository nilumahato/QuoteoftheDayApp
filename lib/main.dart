import 'package:flutter/material.dart';
import 'package:quoteofthedayapp/quote_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes of the Day App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: QuoteScreen(),
    ),
  );
}
