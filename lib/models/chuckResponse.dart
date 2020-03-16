import 'dart:convert';

class ChuckResponse {
    List<String> categories;
    DateTime createdAt;
    String iconUrl;
    String id;
    DateTime updatedAt;
    String url;
    String value;

    ChuckResponse({
        this.categories,
        this.createdAt,
        this.iconUrl,
        this.id,
        this.updatedAt,
        this.url,
        this.value,
    });

    factory ChuckResponse.fromRawJson(String str) => ChuckResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChuckResponse.fromJson(Map<String, dynamic> json) => ChuckResponse(
        categories: List<String>.from(json["categories"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        iconUrl: json["icon_url"],
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "icon_url": iconUrl,
        "id": id,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "value": value,
    };
}