class Car {
  int? carId;
  String? name;
  String? model;
  String? phoneNumber;
  String? plateNumber;
  DateTime? enterDate;
  DateTime? exitDate;
  int? estimatedTime;
  int? exited;
  int? totalCharge;
  int? parkFloor;

  Car(
      {this.carId,
      this.name,
      this.model,
      this.phoneNumber,
      this.plateNumber,
      this.enterDate,
      this.exitDate,
      this.estimatedTime,
      this.exited,
      this.totalCharge,
      this.parkFloor});

  Car.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    name = json['name'];
    model = json['model'];
    phoneNumber = json['phoneNumber'];
    plateNumber = json['plateNumber'];
    enterDate = DateTime.parse(json['enterDate']);
    exitDate =
        json['exitDate'] != null ? DateTime.parse(json['exitDate']) : null;
    estimatedTime = json['estimatedTime'];
    parkFloor = json['parkFloor'];
    exited = json['exited'];
    totalCharge = json['totalCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carId'] = carId;
    data['name'] = name;
    data['model'] = model;
    data['phoneNumber'] = phoneNumber;
    data['plateNumber'] = plateNumber;
    data['enterDate'] = enterDate;
    data['exitDate'] = exitDate;
    data['estimatedTime'] = estimatedTime;
    data['parkFloor'] = parkFloor;
    data['exited'] = exited;
    data['totalCharge'] = totalCharge;
    return data;
  }
}
