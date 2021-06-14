import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MangaPreviewTile extends StatelessWidget {
  MangaPreviewTile(
      {required this.title, required this.imgSrc, required this.ref});

  final String title, imgSrc, ref;

  void buildSnackBar(String url, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text('Opening $url...'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black87,
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 1))
        ]),
        child: InkWell(
          onTap: () => {buildSnackBar(ref, context)},
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.hardEdge,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              FittedBox(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                child: Image.network(imgSrc),
              ),
              // Text(title)
              Wrap(
                  // alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.7)),
                      child: Text(
                        title,
                        textScaleFactor: 1.2,
                      ),
                      padding: EdgeInsets.only(
                          top: 6.0, left: 6.0, bottom: 8.0, right: 6.0),
                    )
                  ]),
            ],
          ),
        ));
  }
}
