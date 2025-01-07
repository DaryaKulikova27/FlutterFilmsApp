import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trailer.g.dart';

@JsonSerializable()
class Trailer extends Equatable {
  final String url;
  final String name;
  final String site;
  final String type;

  Trailer({
    required this.url,
    required this.name,
    required this.site,
    required this.type,
  });
  
  // factory Trailer.fromJSON(Map<String, dynamic> json) => Trailer(
  //       url: json['url'],
  //       name: json['name'],
  //       site: json['site'],
  //       type: json['type'],
  //     );

  // Map<String, dynamic> toJson() {
  //   return {
  //     'url': url,
  //     'name': name,
  //     'site': site,
  //     'type': type,
  //   };
  // }

  factory Trailer.fromJson(Map<String, dynamic> json) => _$TrailerFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerToJson(this);
  
  @override
  List<Object?> get props => [url, name, site, type];
}


//         "url": "https://www.youtube.com/embed/Xtf3c-Y20Lw",
//         "name": "Ведьмак (1 сезон) — Русский трейлер (Озвучка, 2019)",
//         "site": "youtube",
//         "type": "TRAILER"
//