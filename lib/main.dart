import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Show browser cookies',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const MyHomePage(title: 'Show browser cookies'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0 * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Your cookies:",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(height: 8.0 * 2),
              Expanded(
                child: ListView(
                  children: getCookies()
                      .map((MapEntry<String, String> cookieEntry) =>
                          SelectableText(
                            "${cookieEntry.key} => ${cookieEntry.value}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(height: 2),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );

  Iterable<MapEntry<String, String>> getCookies() {
    String cookieString = window.document.cookie ?? "";

    return cookieString
        .split("; ")
        .map((String cookieEntryString) => cookieEntryString.split('='))
        .map((List<String> cookieEntry) =>
            MapEntry<String, String>(cookieEntry[0], cookieEntry[1]));
  }
}
