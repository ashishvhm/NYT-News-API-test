import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt_api_test/blocs/newsbloc/news_bloc.dart';
import 'package:nyt_api_test/blocs/newsbloc/news_states.dart';
import 'package:nyt_api_test/models/article_model.dart';
import 'details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.03),
                child: const Text(
                  "NYT Most Popular News",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: height * 0.08),
            child: BlocBuilder<NewsBloc, NewsStates>(
              builder: (BuildContext context, NewsStates state) {
                if (state is NewsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NewsLoadedState) {
                  List<ArticleModel> _articleList = [];
                  _articleList = state.articleList;
                  return ListView.builder(
                      itemCount: _articleList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewsDetail(_articleList[index].url)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 1,
                                      color: Colors.grey,
                                      offset: Offset(0, 2),
                                      spreadRadius: 1)
                                ]),
                           // height: height * 0.15,
                            margin: EdgeInsets.only(
                                bottom: height * 0.01,
                                top: height * 0.01,
                                left: width * 0.02,
                                right: width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.15,
                                      width: width * 0.55,
                                      padding: EdgeInsets.only(left:height * 0.01,top: 10),
                                      child: Text(
                                        _articleList[index].title,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.04,
                                      margin: const EdgeInsets.only(left: 10),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(_articleList[index].section.toString(),style: TextStyle(color: Colors.white),),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                            border: Border.all(
                                              color: Colors.grey[700],
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(12))
                                        ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Container(
                                  margin: EdgeInsets.all(height * 0.02),
                                  width: width * 0.3,
                                  height: height * 0.15,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            _articleList[index].media.isNotEmpty?
                                            _articleList[index].media[0]['media-metadata'][0]['url'].toString()
                                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state is NewsErrorState) {
                  String error = state.errorMessage;
                  return Center(child: Text(error));
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ));
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
