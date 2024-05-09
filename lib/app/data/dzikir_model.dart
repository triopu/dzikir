import 'dart:convert';

// {
//   "title": null,
//   "dzikirs": [
//     {
//       "dzikir": null,
//       "dzikir_source": null,
//       "text": null,
//       "translation": null
//     }
//   ],
//   "count": 1,
//   "benefit": null,
//   "benefit_source": null
// }

class DzikirModel {
  String? title;
  List<Dzikir>? dzikirs;
  int? count;
  String? benefit;
  String? benefitSource;

  DzikirModel({
    this.title,
    this.dzikirs,
    this.count,
    this.benefit,
    this.benefitSource,
  });

  factory DzikirModel.fromRawJson(String str) => DzikirModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DzikirModel.fromJson(Map<String, dynamic> json) => DzikirModel(
        title: json["title"],
        dzikirs: json["dzikirs"] == null ? [] : List<Dzikir>.from(json["dzikirs"]!.map((x) => Dzikir.fromJson(x))),
        count: json["count"],
        benefit: json["benefit"],
        benefitSource: json["benefit_source"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "dzikirs": dzikirs == null ? [] : List<dynamic>.from(dzikirs!.map((x) => x.toJson())),
        "count": count,
        "benefit": benefit,
        "benefit_source": benefitSource,
      };
}

class Dzikir {
  String? dzikir;
  String? dzikirSource;
  String? text;
  String? translation;

  Dzikir({
    this.dzikir,
    this.dzikirSource,
    this.text,
    this.translation,
  });

  factory Dzikir.fromRawJson(String str) => Dzikir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dzikir.fromJson(Map<String, dynamic> json) => Dzikir(
        dzikir: json["dzikir"],
        dzikirSource: json["dzikir_source"],
        text: json["text"],
        translation: json["translation"],
      );

  Map<String, dynamic> toJson() => {
        "dzikir": dzikir,
        "dzikir_source": dzikirSource,
        "text": text,
        "translation": translation,
      };
}
