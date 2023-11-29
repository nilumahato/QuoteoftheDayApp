import 'package:flutter/material.dart';

class FavoriteQuotesScreen extends StatefulWidget {
  final List<Map<String, String>> favoriteQuotes;
  final Function(List<Map<String, String>>) onUpdateFavorites;

  const FavoriteQuotesScreen({
    Key? key,
    required this.favoriteQuotes,
    required this.onUpdateFavorites,
  }) : super(key: key);

  @override
  _FavoriteQuotesScreenState createState() => _FavoriteQuotesScreenState();
}

class _FavoriteQuotesScreenState extends State<FavoriteQuotesScreen> {
  late List<Map<String, String>> localFavoriteQuotes;

  @override
  void initState() {
    super.initState();
    localFavoriteQuotes = widget.favoriteQuotes.toList();
  }

  void removeFromFavorites(int index) {
    setState(() {
      localFavoriteQuotes.removeAt(index);
    });

    widget.onUpdateFavorites(localFavoriteQuotes);
  }

  @override
  void didUpdateWidget(covariant FavoriteQuotesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.favoriteQuotes != oldWidget.favoriteQuotes) {
      setState(() {
        localFavoriteQuotes = widget.favoriteQuotes.toList();
      });
      widget.onUpdateFavorites(localFavoriteQuotes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 37.0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Favorite Quotes',
              style: TextStyle(
                color: Colors.deepPurple[300],
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: localFavoriteQuotes.isEmpty
                  ? Center(
                      child: Text('No favorite quotes yet'),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: localFavoriteQuotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: Key(localFavoriteQuotes[index]['quote'] ?? ''),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            removeFromFavorites(index);
                          },
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: Card(
                              color: Colors.deepPurple[100],
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      localFavoriteQuotes[index]['quote'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      localFavoriteQuotes[index]['author'] ??
                                          '',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color.fromARGB(255, 21, 21, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Back',
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
