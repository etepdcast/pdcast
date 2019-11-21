import 'model.dart';

class ProfileModel extends Model {
  int _id;
  String _name;
  String _profilePic;

  ProfileModel(this._name, this._profilePic) : super.init();

  int get id => _id;
  String get name => _name;
  String get profilePic => _profilePic;

  ProfileModel.map(dynamic obj) : super.map() {
    this._id = obj['id'];
    this._name = obj['name'];
    this._profilePic = obj['profilePic'];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["profilePic"] = _profilePic;
    if(id != null) {
      map["id"] = _id;
    }
    return map;
  }

  ProfileModel.fromMap(Map<String, dynamic> map) : super.fromMap() {
    this._id = map['id'];
    this._name = map['name'];
    this._profilePic = map['profilePic'];   
  }

}