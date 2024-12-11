class Travel {
  //ตัวแปรเก็บข้อมูลที่สอดรับกับตารางใน DB
  int? id;
  String? pictureTravel;
  String? placeTravel;
  String? costTravel;
  String? dateTravel;
  String? dayTravel;
  String? locationTravel;

  Travel({
    this.pictureTravel,
    this.placeTravel,
    this.costTravel,
    this.dateTravel,
    this.dayTravel,
    this.locationTravel,
  });

  factory Travel.fromMap(Map<String, dynamic> json) {
    return Travel(
      pictureTravel: json['pictureTravel'],
      placeTravel: json['placeTravel'],
      costTravel: json['costTravel'],
      dateTravel: json['dateTravel'],
      dayTravel: json['dayTravel'],
      locationTravel: json['locationTravel'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pictureTravel': pictureTravel,
      'placeTravel': placeTravel,
      'costTravel': costTravel,
      'dateTravel': dateTravel,
      'dayTravel': dayTravel,
      'locationTravel': locationTravel,
    };
  }
}
