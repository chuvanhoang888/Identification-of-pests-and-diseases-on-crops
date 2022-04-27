class RiceDisease {
  String describe, images, name, reasons, solution;
  String idRice;

  RiceDisease(this.describe, this.images, this.name, this.reasons,
      this.solution, this.idRice);

  RiceDisease.fromValues(var value)
      : describe = value['describe'],
        images = value['images'],
        name = value['name'],
        reasons = value['reasons'],
        solution = value['solution'],
        idRice = value['id'];
}
