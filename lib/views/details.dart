import 'package:flutter/material.dart';
import 'package:nyt_api_test/repositories/news_repository.dart';

class NewsDetail extends StatefulWidget {
  String url;
  NewsDetail(this.url, {Key key}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  int photoIndex = 0;


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: FutureBuilder(
       future: NewsRepository().fetchNewsData(widget.url),
       builder: (context,snapshot) {
         if(snapshot.data==null){
           return const Center(child: CircularProgressIndicator());
         }else {
           return NestedScrollView(
             headerSliverBuilder: (BuildContext context,
                 bool innerBoxIsScrolled) {
               return <Widget>[
                 SliverAppBar(
                   expandedHeight: 230.0,
                   pinned: false,
                   flexibleSpace: FlexibleSpaceBar(
                    // title: Text('SliverAppBar Expand'),
                     background: Stack(
                       children: [
               Container(
              // height: 230.0,
               decoration: BoxDecoration(
               image: DecorationImage(
               image: NetworkImage(
               snapshot.data['multimedia'][0]['url'].length >
               0 ?
               'https://static01.nyt.com/' +
               snapshot.data['multimedia'][0]['url']
                   .toString()
                   : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
               ),
               fit: BoxFit.cover
               ),
               ),
               ),

                       ],
                     )
                   ),
                 )
               ];
             },
             body:  ListView(
               shrinkWrap: true,
               children: <Widget>[
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left: 15.0),
                   child: Text(
                     snapshot.data['section_name'],
                     style: const TextStyle(
                         fontSize: 15.0,
                         color: Colors.grey),
                   ),
                 ),
                 const SizedBox(height: 10.0),
                 Padding(
                   padding: const EdgeInsets.only(left: 15.0),
                   child: Text(
                     snapshot.data['headline']['main'],
                     style: const TextStyle(
                         fontSize: 25.0,
                         color: Colors.black,
                         fontWeight: FontWeight.bold),
                   ),
                 ),
                 const SizedBox(height: 10.0),
                 Padding(
                   padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                   child: Text(
                     snapshot.data['lead_paragraph'],
                     style: const TextStyle(
                       fontSize: 20.0,
                     ),
                   ),
                 ),
                 const SizedBox(height: 20.0),
               ],
             ),
           ]),

         );
         }
       },

     ),
  );
  }
}