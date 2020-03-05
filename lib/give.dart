import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 4.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
String selectedUrl = 'https://flutterwave.com/pay/ncww';

class Giving extends StatefulWidget {
  @override
  _GivingState createState() => _GivingState();
}

class _GivingState extends State<Giving> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(

      body: Center(
        child: new Stack(
          alignment: Alignment.topCenter,
          children: [
            Stack(
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                        'https://nairobichapel.files.wordpress.com/2014/05/dsc_0261.jpg',
                      ),
                    ),
                  ),
                ),
                new SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    children: <Widget>[
                      new SizedBox(
                        height: 300.0,
                      ),
                      new Card(
                        color: Colors.black12,
                        elevation: 1,
                        child: new Container(
                          width: screenSize.width,
                          margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              new SizedBox(
                                height: 10.0,
                              ),
                              new SizedBox(
                                height: 10.0,
                              ),
                              new Text(
                                "2 Corinthians 9:7 \n \n Each of you should give what you have decided in your heart to give, not reluctantly or under compulsion, for God loves a cheerful giver.",
                                style: new TextStyle(
                                    fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                              new SizedBox(
                                height: 10.0,
                              ),
                              const SizedBox(height: 30),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(new CupertinoPageRoute(
                                      builder: (BuildContext context) => new offer()
                                  ));
                                  },
                                textColor: Colors.white,
                                color: Colors.purple,
                                padding: const EdgeInsets.all(0.0),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(


                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                  const Text('Give now', style: TextStyle(fontSize: 20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class offer extends StatefulWidget {

  @override
  _offerState createState() => _offerState();
}

class _offerState extends State<offer> {


  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.launch(selectedUrl);
  }


  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      appBar: AppBar(
        title:  Text('Offer',
          style: new TextStyle(

              color: Colors.indigo,
              fontWeight: FontWeight.w700),),

      ),
      withZoom: true,
      withLocalStorage: true,
    );
  }

}