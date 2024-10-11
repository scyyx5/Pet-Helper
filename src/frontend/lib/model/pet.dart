class Pet {
  //int id;
  String pet_name;
  String pet_birth;
  String pet_sex;

  String pet_weight;
  // String pet_owner;
  // String pet_type;
  // pet_pic;
  //////////String pet_pic_base64;
  String pet_pic_path;
  String pet_owner;

  Pet(
      {required this.pet_name,
        required this.pet_birth,
        required this.pet_sex,
        //////////required this.pet_pic_base64,
        required this.pet_weight,
        required this.pet_pic_path,
        required this.pet_owner});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
        pet_name: json['pet_name'],
        pet_birth: json['pet_birth'],
        pet_sex: json['pet_sex'],
        pet_weight: json['pet_weight'],
        //////////pet_pic_base64: json['pet_pic_base64'],
        pet_pic_path: json['pet_pic_path'],
        pet_owner: json['pet_owner']);
  }
  dynamic toJson() => {
    'pet_name': pet_name,
    'pet_birth': pet_birth,
    'pet_sex': pet_sex,
    'pet_weight': pet_weight,
    'pet_owner': pet_owner,
    //////////'pet_pic_base64': pet_pic_base64,
  };
}


//The reason why we need another pet class is because this class retreives the pet's id
//and use the pet id as a tag for heroid animation, the first pet class does not get pet id

class Pet1 {
  final int id;
  final String pet_name;
  final String pet_birth;
  final String pet_sex;
  final String pet_weight;
  final String pet_type;
  final String pet_owner;
  final String pet_pic;

  Pet1(this.id, this.pet_name, this.pet_birth, this.pet_sex, this.pet_weight,
      this.pet_type, this.pet_owner, this.pet_pic);
}
