/// title : "Flutter"
/// description : "Cross-platform mobile framework from Google"
/// image : "https://frontend-test-api.digitalcreative.cn/flutter.png"
/// url : "https://flutter.dev/"
/// category : "Languages & Frameworks"

class SearchResponseModule {
  SearchResponseModule({
      String? title, 
      String? description, 
      String? image, 
      String? url, 
      String? category,}){
    _title = title;
    _description = description;
    _image = image;
    _url = url;
    _category = category;
}

  SearchResponseModule.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _url = json['url'];
    _category = json['category'];
  }
  String? _title;
  String? _description;
  String? _image;
  String? _url;
  String? _category;
SearchResponseModule copyWith({  String? title,
  String? description,
  String? image,
  String? url,
  String? category,
}) => SearchResponseModule(  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  url: url ?? _url,
  category: category ?? _category,
);
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get url => _url;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['url'] = _url;
    map['category'] = _category;
    return map;
  }

}