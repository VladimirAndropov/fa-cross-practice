class ITunesItem {
  String wrapperType;
  String kind;
  String trackName;
  String artistName;
  String collectionName;
  String? artworkUrl30;
  String? artworkUrl60;
  String? artworkUrl100;

  ITunesItem({
    required this.wrapperType,
    required this.kind,
    required this.trackName,
    required this.artistName,
    required this.collectionName,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
  });

  factory ITunesItem.fromJson(Map<String, dynamic> json) {
    return ITunesItem(
      wrapperType: json['wrapperType'] as String,
      kind: json['kind'] as String,
      trackName: json['trackName'] as String,
      artistName: json['artistName'] as String,
      collectionName: json['collectionName'] as String,
      artworkUrl30: json['artworkUrl30'] as String?,
      artworkUrl60: json['artworkUrl60'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
    );
  }
}