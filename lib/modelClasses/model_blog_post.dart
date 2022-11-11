class ModelBlogPost {
  String? blogImageUrl;
  String? blogTitle;
  String? blogBody;

  static String keyBlogImageUrl = 'BlogImageUrl';
  static String keyBlogTitle = 'BlogTitle';
  static String keyBlogBody = 'BlogBody';

  ModelBlogPost(
      {required this.blogImageUrl,
      required this.blogTitle,
      required this.blogBody});

  Map<String, dynamic> toMap() {
    return {
      keyBlogImageUrl: blogImageUrl,
      keyBlogTitle: blogTitle,
      keyBlogBody: blogBody
    };
  }
}
