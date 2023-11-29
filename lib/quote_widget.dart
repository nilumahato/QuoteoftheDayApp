import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quoteofthedayapp/theme_text.dart';
import 'package:share_plus/share_plus.dart';

class QuoteWidget extends StatelessWidget {
  final String quote, author;
  final Color backgroundColor;
  final Function() onSaveToFavorites;
  final Function() onViewFavorites;

  const QuoteWidget({
    Key? key,
    required this.quote,
    required this.author,
    required this.backgroundColor,
    required this.onSaveToFavorites,
    required this.onViewFavorites,
  }) : super(key: key);

  void _onShare() async {
    await Share.share(
      '"$quote" - $author',
      subject: 'Check out this inspiring quote!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      color: backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(16),
        vertical: ScreenUtil().setHeight(48),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/quotes.png",
            color: Colors.white.withOpacity(0.4),
            width: ScreenUtil().setWidth(70),
            height: ScreenUtil().setHeight(70),
          ),
          Expanded(
            child: Center(
              child: Text(
                quote,
                style: ThemeText.headline,
              ),
            ),
          ),
          Center(
            child: Text(
              author,
              style: ThemeText.subhead,
            ),
          ),
          SizedBox(height: 20), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  _onShare(); 
                },
                icon: Icon(Icons.share),
              ),
              IconButton(
                onPressed: onSaveToFavorites,
                icon: Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: onViewFavorites,
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
