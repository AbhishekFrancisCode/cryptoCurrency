class OrderBook {
    OrderBook({
      this.timestamp,
      this.microtimestamp,
      this.bids,
      this.asks,
    });

    String timestamp;
    String microtimestamp;
    List<List<String>> bids;
    List<List<String>> asks;

    factory OrderBook.fromJson(Map<String, dynamic> json) => OrderBook(
        timestamp: json["timestamp"],
        microtimestamp: json["microtimestamp"],
        bids: List<List<String>>.from(json["bids"].map((x) => List<String>.from(x.map((x) => x)))),
        asks: List<List<String>>.from(json["asks"].map((x) => List<String>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "microtimestamp": microtimestamp,
        "bids": List<dynamic>.from(bids.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "asks": List<dynamic>.from(asks.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}