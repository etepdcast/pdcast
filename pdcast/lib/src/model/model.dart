abstract class Model {
  int _id;

  Model.init();

  Model.map();
  Map<String, dynamic> toMap();
  Model.fromMap();

  int get id => _id;

}