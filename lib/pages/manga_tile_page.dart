import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manga_flutter/data/manga_tile_data.dart';
import 'package:manga_flutter/scraper/home_scraper.dart';
import 'package:manga_flutter/components/manga_tile.dart';
import 'package:web_scraper/web_scraper.dart';

class MangaTilePage extends StatefulWidget {
  MangaTilePage({Key? key}) : super(key: key);

  @override
  _MangaTilePageState createState() => _MangaTilePageState();
}

class _MangaTilePageState extends State<MangaTilePage> {
  HomeScraper homeScraper = HomeScraper();
  late Future<bool> loadFuture;
  List<MangaTileData> mangaTileDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFuture = homeScraper.loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MangaTiles')),
      body: FutureBuilder(
        future: loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                mangaTileDataList = homeScraper.getMangaTiles();
                return GridView.extent(
                    padding: EdgeInsets.all(10.0),
                    childAspectRatio: 0.7,
                    maxCrossAxisExtent: 230,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: mangaTileDataList
                        .map((e) => MangaTile(
                            title: e.title, imgSrc: e.imgSrc, ref: e.ref))
                        .toList());
              } else {
                return DefaultTextStyle(
                    style: Theme.of(context).textTheme.headline2!,
                    child: Text('Loading error!'));
              }
            } else if (snapshot.hasError) {
              print((snapshot.error! as WebScraperException).errorMessage());
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                      style: Theme.of(context).textTheme.headline3!,
                      child: Text('Connection error!')),
                  Text('${snapshot.error}')
                ],
              ));
            } else
              return Text('Unknown error!');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
