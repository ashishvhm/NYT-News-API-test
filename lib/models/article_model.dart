class ArticleModel {
  String title;
  String url;
  String section;
  List media;

  ArticleModel(
      {this.media,
      this.title,
      this.section,
      this.url,
     });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    title = json['title'];
    media = json['media'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section'] = this.section;
    data['title'] = this.title;
    data['media'] = this.media;
    data['url'] = this.url;
    return data;
  }
}