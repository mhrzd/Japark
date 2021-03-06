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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = this.carId;
    data['name'] = this.name;
    data['model'] = this.model;
    data['phoneNumber'] = this.phoneNumber;
    data['plateNumber'] = this.plateNumber;
    data['enterDate'] = this.enterDate;
    data['exitDate'] = this.exitDate;
    data['estimatedTime'] = this.estimatedTime;
    data['parkFloor'] = this.parkFloor;
    data['exited'] = this.exited;
    data['totalCharge'] = this.totalCharge;
    return data;
  }
}
