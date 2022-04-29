import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'locations.dart';

class MenuButton extends StatefulWidget {
  MenuButton(
      {required this.beamer,
      required this.uri,
      required this.child,
      this.onChanged});

  final GlobalKey<BeamerState> beamer;
  final String uri;
  final Widget child;
  final void Function(bool)? onChanged;

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  void _setStateListener() {
    log("listener fired in " + widget.uri + " changed");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => widget
        .beamer.currentState?.routerDelegate
        .addListener(_setStateListener));
  }

  @override
  Widget build(BuildContext context) {
    final path = (context.currentBeamLocation.state as BeamState).uri.path;

    return ElevatedButton(
      onPressed: () {
        widget.beamer.currentState?.routerDelegate.root.beamToNamed(widget.uri);
      },
      style: ButtonStyle(
        backgroundColor: path.contains(widget.uri)
            ? MaterialStateProperty.all<Color>(Colors.green)
            : MaterialStateProperty.all<Color>(Colors.blue),
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.beamer.currentState?.routerDelegate
        .removeListener(_setStateListener);
    super.dispose();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _booksBeamerKey = GlobalKey<BeamerState>();
  final _articlesBeamerKey = GlobalKey<BeamerState>();

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.blue[300],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MenuButton(
                  beamer: _booksBeamerKey,
                  uri: '/books',
                  child: Text('Books'),
                  onChanged: (bool isActive) {
                    if (isActive) currentIndex = 1;
                  },
                ),
                SizedBox(height: 16.0),
                MenuButton(
                    beamer: _articlesBeamerKey,
                    uri: '/articles',
                    child: Text('Articles'),
                    onChanged: (bool isActive) {
                      if (isActive) currentIndex = 2;
                    }),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
          Expanded(
            child: Container(
              color: Colors.pink,
              child: Center(
                child: IndexedStack(
                    index: currentIndex,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Text('Home'),
                        ),
                      ),
                      Center(
                        child: Beamer(
                          key: _booksBeamerKey,
                          routerDelegate: BeamerDelegate(
                            routeListener: (r, d) {
                              log("books router Navigating to:" +
                                  (r.location ?? ""));
                            },
                            transitionDelegate:
                                const NoAnimationTransitionDelegate(),
                            locationBuilder: (routeInformation, _) =>
                                BooksLocation(routeInformation),
                          ),
                        ),
                      ),
                      Center(
                        child: Beamer(
                          key: _articlesBeamerKey,
                          routerDelegate: BeamerDelegate(
                            routeListener: (r, d) {
                              log("articles router Navigating to:" +
                                  (r.location ?? ""));
                            },
                            transitionDelegate:
                                const NoAnimationTransitionDelegate(),
                            locationBuilder: (routeInformation, _) =>
                                ArticlesLocation(routeInformation),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BooksScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.blue[300],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/books/authors',
                  child: Text('Book Authors'),
                ),
                SizedBox(height: 16.0),
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/books/genres',
                  child: Text('Book Genres'),
                ),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
          Expanded(
            child: ClipRRect(
              child: Beamer(
                key: _beamerKey,
                routerDelegate: BeamerDelegate(
                  locationBuilder: (routeInformation, _) =>
                      BooksContentLocation(routeInformation),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BooksHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books Home'),
      ),
    );
  }
}

class BookAuthorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Authors'),
      ),
    );
  }
}

class BookGenresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Genres'),
      ),
    );
  }
}

class ArticlesScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.blue[300],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/articles/authors',
                  child: Text('Article Authors'),
                ),
                SizedBox(height: 16.0),
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/articles/genres',
                  child: Text('Article Genres'),
                ),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
          Expanded(
            child: ClipRRect(
              child: Beamer(
                key: _beamerKey,
                routerDelegate: BeamerDelegate(
                  locationBuilder: (routeInformation, _) =>
                      ArticlesContentLocation(routeInformation),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticlesHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles Home'),
      ),
    );
  }
}

class ArticleAuthorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Authors'),
      ),
    );
  }
}

class ArticleGenresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Genres'),
      ),
    );
  }
}
