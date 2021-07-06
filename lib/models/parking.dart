class Parking {
  int? parkingId;
  String? email;
  String? parkingName;
  int? capacity;
  int? occupied;
  int? enterCharge;
  int? chargePerHour;
  String? password;
  String? question;
  String? answer;
  int? floors;

  Parking(
      {this.parkingId,
      this.email,
      this.parkingName,
      this.capacity,
      this.occupied,
      this.enterCharge,
      this.chargePerHour,
      this.floors,
      this.password,
      this.question,
      this.answer});

  Parking.fromJson(Map<String, dynamic> json) {
    parkingId = json['parkingId'];
    email = json['email'];
    parkingName = json['parkingName'];
    capacity = json['capacity'];
    occupied = json['occupied'];
    enterCharge = json['enterCharge'];
    floors = json['floors'];
    chargePerHour = json['chargePerHour'];
    password = json['password'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parkingId'] = this.parkingId;
    data['email'] = this.email;
    data['parkingName'] = this.parkingName;
    data['capacity'] = this.capacity;
    data['occupied'] = this.occupied;
    data['enterCharge'] = this.enterCharge;
    data['chargePerHour'] = this.chargePerHour;
    data['password'] = this.password;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['floors'] = this.floors;
    return data;
  }
}
