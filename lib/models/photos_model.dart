class PhotosModel {
  int? page;
  int? perPage;
  List<Photos> photos;
  int? totalResults;
  String? nextPage;

  PhotosModel({
    this.page,
    this.perPage,
    this.photos = const <Photos>[],
    this.totalResults,
    this.nextPage,
  });

  PhotosModel.fromJson(Map<String, dynamic> json) : photos = <Photos>[] {
    page = json['page'] as int?;
    perPage = json['per_page'] as int?;
    final photoList = json['photos'];
    if (photoList is List) {
      for (final v in photoList) {
        photos.add(Photos.fromJson(v as Map<String, dynamic>));
      }
    }
    totalResults = json['total_results'] as int?;
    nextPage = json['next_page'] as String?;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'per_page': perPage,
        'photos': photos.map((v) => v.toJson()).toList(),
        'total_results': totalResults,
        'next_page': nextPage,
      };
}

class Photos {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;

  Photos({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    width = json['width'] as int?;
    height = json['height'] as int?;
    url = json['url'] as String?;
    photographer = json['photographer'] as String?;
    photographerUrl = json['photographer_url'] as String?;
    photographerId = json['photographer_id'] as int?;
    avgColor = json['avg_color'] as String?;
    src = json['src'] != null
        ? Src.fromJson(json['src'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'width': width,
        'height': height,
        'url': url,
        'photographer': photographer,
        'photographer_url': photographerUrl,
        'photographer_id': photographerId,
        'avg_color': avgColor,
        if (src != null) 'src': src!.toJson(),
      };
}

class Src {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Src({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'] as String?;
    large2x = json['large2x'] as String?;
    large = json['large'] as String?;
    medium = json['medium'] as String?;
    small = json['small'] as String?;
    portrait = json['portrait'] as String?;
    landscape = json['landscape'] as String?;
    tiny = json['tiny'] as String?;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'original': original,
        'large2x': large2x,
        'large': large,
        'medium': medium,
        'small': small,
        'portrait': portrait,
        'landscape': landscape,
        'tiny': tiny,
      };
}
