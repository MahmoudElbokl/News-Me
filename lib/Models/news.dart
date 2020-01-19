class News {
  Source source;
  String author, title, description, urlToImage, url, content, publishedAt;

  News(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.urlToImage,
      this.url,
      this.content,
      this.publishedAt});
}

class Source {
  String id;
  String name;

  Source(this.id, this.name);
}
