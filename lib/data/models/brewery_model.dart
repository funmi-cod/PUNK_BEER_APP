class Brewery {
  List<BreweryHistory>? data;

  Brewery({
    this.data,
  });

  // factory Brewery.fromJson(Map<String, dynamic> json) => Brewery(
  //       data: json["data"] == null
  //           ? []
  //           : List<BreweryHistory>.from(json["data"]!.map((x) => x)),
  //     );

  factory Brewery.fromJson(List<dynamic> json) {
    return Brewery(
      data: json == null
          ? []
          : List<BreweryHistory>.from(
              json.map((x) => BreweryHistory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}

class BreweryHistory {
  String? id;
  String? name;
  String? breweryType;
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? stateProvince;
  String? postalCode;
  String? country;
  String? longitude;
  String? latitude;
  String? phone;
  String? websiteUrl;
  String? state;
  String? street;

  BreweryHistory({
    this.id,
    this.name,
    this.breweryType,
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.stateProvince,
    this.postalCode,
    this.country,
    this.longitude,
    this.latitude,
    this.phone,
    this.websiteUrl,
    this.state,
    this.street,
  });

  factory BreweryHistory.fromJson(Map<String, dynamic> json) {
    return BreweryHistory(
      id: json['id'],
      name: json['name'],
      breweryType: json['brewery_type'],
      address1: json['address_1'],
      address2: json['address_2'] ?? '',
      address3: json['address_3'] ?? '',
      city: json['city'],
      stateProvince: json['state_province'],
      postalCode: json['postal_code'],
      country: json['country'],
      longitude: json['longitude']?.toString(),
      latitude: json['latitude']?.toString(),
      phone: json['phone'],
      websiteUrl: json['website_url'],
      state: json['state'],
      street: json['street'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brewery_type": breweryType,
        "address_1": address1,
        "address_2": address2,
        "address_3": address3,
        "city": city,
        "state_province": stateProvince,
        "country": country,
        "longitude": longitude,
        "latitude": latitude,
        "phone": phone,
        "website_url": websiteUrl,
        "state": state,
        "street": street,
      };
}
