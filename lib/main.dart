// Copyright 2018 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:example_flutter/data/showcases.dart';
import 'package:example_flutter/widget/header_widget.dart';
import 'package:example_flutter/widget/showcase_widget.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  // Desktop platforms are not recognized as valid targets by
  // Flutter; force a specific target to prevent exceptions.
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

/// Top level widget for the example application.
class MyApp extends StatefulWidget {
  /// Constructs a new app with the given [key].
  const MyApp({Key key}) : super(key: key);

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<MyApp> {
  final String appTitle = 'ScreenDesignChaellenge';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Colors.black.withOpacity(0.8),
        primaryTextTheme:
            Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.white),
        accentColor: Colors.blue, // needs to be MaterialColor
        unselectedWidgetColor: Colors.grey, // needs to be MaterialColor
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        // Specify a font to reduce potential issues with the
        // example behaving differently on different platforms.
        fontFamily: 'Roboto',
      ),
      home: _MyHomePage(title: appTitle),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  const _MyHomePage({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: Drawer(child: Container()),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              HeaderWidget(),
              const SizedBox(height: 32),
              buildMainButton(),
              const SizedBox(height: 32),
              Text(
                'Showcasing the finest food, drinks and travel, Recipes, healthy tips, food photography',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Divider(),
              SizedBox(height: 32),
            ],
          ),
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(12),
            crossAxisCount: 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 12,
            itemCount: showcases.length,
            itemBuilder: (BuildContext context, int index) =>
                ShowcaseWidget(showcase: showcases[index]),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          ),
        ],
      ),
    );
  }

  Widget buildMainButton() => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildButton(5, 'Followers'),
            VerticalDivider(),
            buildButton(38, 'Posts'),
          ],
        ),
      );

  Widget buildButton(int number, String text) => FlatButton(
        onPressed: () {},
        child: Column(
          children: <Widget>[
            Text(
              '$number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      );
}
