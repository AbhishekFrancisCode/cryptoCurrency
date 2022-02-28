class CryptoList {
  CryptoList({
    this.urlSymbol = "",
    this.description = "",
  });

  String urlSymbol;
  String description;

  factory CryptoList.fromJson(Map<String, dynamic> json) => CryptoList(
        urlSymbol: json["url_symbol"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "url_symbol": urlSymbol,
        "description": description,
      };
}
