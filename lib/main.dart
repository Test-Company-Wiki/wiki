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

    cookieString =
        "_gcl_au=1.1.92481872.1635150080; gfg_theme=gfgThemeDark; _pubcid=c3b9e4c8-3516-49b5-ad2b-99bba098f75c; _gd_visitor=f8294bdc-4c3a-4a96-8666-e71e447dc2f6; _gd_svisitor=24edef5033240000c6567661e600000000020000; _hjid=a5773c26-0d0e-4008-8e02-348dc23ce6db; __qca=P0-597628366-1635150083232; pbjs-unifiedid=%7B%22TDID%22%3A%22f57f525a-4eea-4e48-9366-d995043a92be%22%2C%22TDID_LOOKUP%22%3A%22FALSE%22%2C%22TDID_CREATED_AT%22%3A%222021-10-25T08%3A21%3A24%22%7D; _gd_session=5f6dab04-8cbb-44e6-8b54-9776bc5ee9c0; _an_uid=0; __utma=245605906.472065855.1635150082.1635150082.1636537911.2; __utmc=245605906; __utmz=245605906.1636537911.2.2.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided); __gads=ID=870fbf89fdc53311-223c5e7affca0031:T=1635150083:S=ALNI_MYPkqOWdHWlbAOs9VeKWj6eDM5D4Q; guest=yes; _pbjs_userid_consent_data=3524755945110770";

    return cookieString
        .split("; ")
        .map((String cookieEntryString) => cookieEntryString.split('='))
        .map((List<String> cookieEntry) =>
            MapEntry<String, String>(cookieEntry[0], cookieEntry[1]));
  }
}
