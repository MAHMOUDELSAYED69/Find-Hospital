class PlaceInfo {
  final String businessStatus;
  final double lat;
  final double lng;
  final double northeastLat;
  final double northeastLng;
  final double southwestLat;
  final double southwestLng;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final String placeId;
  final String compoundCode;
  final String globalCode;
  final String reference;
  final String scope;
  final List<String> types;
  final String vicinity;
  final bool? openNow;
  final List<Map<String, dynamic>>? photos;
  final double? rating;
  final int? userRatingsTotal;

  PlaceInfo({
    required this.businessStatus,
    required this.lat,
    required this.lng,
    required this.northeastLat,
    required this.northeastLng,
    required this.southwestLat,
    required this.southwestLng,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.placeId,
    required this.compoundCode,
    required this.globalCode,
    required this.reference,
    required this.scope,
    required this.types,
    required this.vicinity,
    this.openNow,
    this.photos,
    this.rating,
    this.userRatingsTotal,
  });

  factory PlaceInfo.fromJson(Map<String, dynamic> json) {
    var geometry = json['geometry'] ?? {};
    var location = geometry['location'] ?? {};
    var viewport = geometry['viewport'] ?? {};
    var northeast = viewport['northeast'] ?? {};
    var southwest = viewport['southwest'] ?? {};
    var openingHours = json['opening_hours'] ?? {};
    var photoList = json['photos'] as List? ?? [];
    var plusCode = json['plus_code'] ?? {};

    return PlaceInfo(
      businessStatus: json['business_status'] ?? 'UNKNOWN',
      lat: location['lat'] ?? 0.0,
      lng: location['lng'] ?? 0.0,
      northeastLat: northeast['lat'] ?? 0.0,
      northeastLng: northeast['lng'] ?? 0.0,
      southwestLat: southwest['lat'] ?? 0.0,
      southwestLng: southwest['lng'] ?? 0.0,
      icon: json['icon'] ?? '',
      iconBackgroundColor: json['icon_background_color'] ?? '',
      iconMaskBaseUri: json['icon_mask_base_uri'] ?? '',
      name: json['name'] ?? '',
      placeId: json['place_id'] ?? '',
      compoundCode: plusCode['compound_code'] ?? '',
      globalCode: plusCode['global_code'] ?? '',
      reference: json['reference'] ?? '',
      scope: json['scope'] ?? '',
      types: List<String>.from(json['types'] ?? []),
      vicinity: json['vicinity'] ?? '',
      openNow: openingHours['open_now'] ?? false,
      photos: photoList
          .map((photo) => {
                'height': photo['height'] ?? 0,
                'html_attributions':
                    List<String>.from(photo['html_attributions'] ?? []),
                'photo_reference': photo['photo_reference'] ?? '',
                'width': photo['width'] ?? 0,
              })
          .toList(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
    );
  }
}
