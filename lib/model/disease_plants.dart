class DiseasePlants {
  late String describe;
  late String enName;
  late String viName;
  late String idDisease;
  late int idCategoriesPlant;

  DiseasePlants(
      {required this.describe,
      required this.enName,
      required this.viName,
      required this.idDisease,
      required this.idCategoriesPlant});

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'describe': describe,
      'enName': enName,
      'viName': viName,
      'idDisease': idDisease,
      'idCategoriesPlant': idCategoriesPlant
    };
  }

  DiseasePlants.fromValues(var json) {
    describe = json['describe'];
    enName = json['enName'];
    viName = json['viName'];
    idDisease = json['idDisease'];
    idCategoriesPlant = json['idCategoriesPlant'];
  }
}
