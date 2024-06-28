//
//?------------------------------------- hospitals Model
class HospitalsPlaceInfo {
  final String businessStatus;
  final double lat;
  final double lng;
  final String name;
  final String placeId;

  final bool? openNow;
  final List<Map<String, dynamic>>? photos;
  final double? rating;
  final int? userRatingsTotal;
  final String? formattedPhoneNumber;
  final String? internationalPhoneNumber;
  final String? formattedAddress;
  final String? distance;
  final String? duration;

  HospitalsPlaceInfo({
    required this.businessStatus,
    required this.lat,
    required this.lng,
    required this.name,
    required this.placeId,
    this.openNow,
    this.photos,
    this.rating,
    this.userRatingsTotal,
    this.formattedPhoneNumber,
    this.internationalPhoneNumber,
    this.formattedAddress,
    this.distance,
    this.duration,
  });

  factory HospitalsPlaceInfo.fromJson(Map<String, dynamic> json) {
    var geometry = json['geometry'] ?? {};
    var location = geometry['location'] ?? {};
    var openingHours = json['opening_hours'] ?? {};
    var photoList = json['photos'] as List? ?? [];
    return HospitalsPlaceInfo(
      businessStatus: json['business_status'] ?? 'UNKNOWN',
      lat: location['lat'] ?? 0.0,
      lng: location['lng'] ?? 0.0,
      name: json['name'] ?? '',
      placeId: json['place_id'] ?? '',
      openNow: openingHours['open_now'] ?? false,
      photos: photoList
          .map((photo) => {
                'height': photo['height'] ?? 0,
                'html_attributions':
                    List<String>.from(photo['html_attributions'] ?? []),
                'photo_reference': photo['photo_reference'] ?? '',
                'width': photo['width'] ?? 0,
              })
          .toList() as List<Map<String, dynamic>>?,
      rating: (json['rating'] ?? 0.0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      formattedPhoneNumber: json['formatted_phone_number'] ?? '',
      internationalPhoneNumber: json['international_phone_number'] ?? '',
      formattedAddress: json['formatted_address'] ?? '',
      distance: json['distance'] ?? '',
      duration: json['duration'] ?? '',
    );
  }
}
