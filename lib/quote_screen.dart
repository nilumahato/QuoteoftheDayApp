import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:quoteofthedayapp/quote_widget.dart';
import 'package:quoteofthedayapp/favorite_quotes_screen.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final List<Map<String, String>> quotes = [
    {
      'quote': "The only way to do great work is to love what you do.",
      'author': "Steve Jobs",
    },
    {
      'quote': "In the middle of difficulty lies opportunity.",
      'author': "Albert Einstein",
    },
    {
      'quote': "Believe you can and you're halfway there.",
      'author': "Theodore Roosevelt",
    },
    {
      'quote':
          "Success is not final, failure is not fatal: It is the courage to continue that counts.",
      'author': "Winston Churchill",
    },
    {
      'quote':
          "The only limit to our realization of tomorrow will be our doubts of today.",
      'author': "Franklin D. Roosevelt",
    },
    {
      'quote':
          "Do not go where the path may lead, go instead where there is no path and leave a trail.",
      'author': "Ralph Waldo Emerson",
    },
    {
      'quote': "The best way to predict the future is to create it.",
      'author': "Peter Drucker",
    },
  ];
  List<Map<String, String>> favoriteQuotes = [];

  late int currentIndex;
  late DateTime lastDisplayedDate;
  late Color randomColor;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    lastDisplayedDate = DateTime.now();
    randomColor = getRandomColor();
    updateQuoteIfNeeded();
  }

  bool isNewDay() {
    DateTime now = DateTime.now();
    return now.difference(lastDisplayedDate).inDays > 0;
  }

  void updateQuoteIfNeeded() {
    if (isNewDay()) {
      setState(() {
        currentIndex = (currentIndex + 1) % quotes.length;
        lastDisplayedDate = DateTime.now();
        randomColor = getRandomColor();
      });
    }
  }

  Color getRandomColor() {
    Options options = Options(
      format: Format.hex,
      colorType: ColorType.random,
      luminosity: Luminosity.random,
    );
    return HexColor.fromHex(RandomColor.getColor(options));
  }

  void updateQuote() {
    setState(() {
      currentIndex = (currentIndex + 1) % quotes.length;
      lastDisplayedDate = DateTime.now();
      randomColor = getRandomColor();
    });
  }

  void navigateToFavoriteQuotesScreen() async {
    final updatedFavorites = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteQuotesScreen(
          favoriteQuotes: favoriteQuotes,
          onUpdateFavorites: (List<Map<String, String>> updatedQuotes) {
            setState(() {
              favoriteQuotes = updatedQuotes;
            });
          },
        ),
      ),
    );
    if (updatedFavorites != null) {
      setState(() {
        favoriteQuotes = updatedFavorites;
      });
    }
  }

  void addToFavorites() {
    final currentQuote = quotes[currentIndex];
    if (!favoriteQuotes.contains(currentQuote)) {
      final updatedFavorites = List<Map<String, String>>.from(favoriteQuotes);
      updatedFavorites.add(currentQuote);
      setState(() {
        favoriteQuotes = updatedFavorites;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      body: QuoteWidget(
        quote: quotes[currentIndex]['quote']!,
        author: quotes[currentIndex]['author']!,
        backgroundColor: randomColor,
        onSaveToFavorites: addToFavorites,
        onViewFavorites: navigateToFavoriteQuotesScreen,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: updateQuote,
            tooltip: 'Refresh',
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
