class Validator {

  static String validate(String value){
    return null;
  }
}
class EmailValidator extends Validator{
  static String validate(String value){
    if(value.isEmpty)
      return "Email can't be empty";
    return null;
  }

}

class NameValidator extends Validator{
  static String validate(String value){
    if(value.isEmpty)
      return "Name Cant be Empty";
    return null;
  }
}

class PasswordValidator extends Validator{
  static String validate(String value){
    if(value.isEmpty)
      return "Password Cant be Empty";
    return null;
  }
}
class PhoneNumberValidator extends Validator{
  static String validate(String value){
    bool syrianNumber = (value[0]=="0"&&value[1]=='9');
    if(value.isEmpty)
      return "Phone Number cant be Empty";
    else if(!_isNumeric(value))
      return "PhoneNumber should only contains numbers ";
    else if (!syrianNumber)
      return "PhoneNumber must be syrian";
    else if (value.length != 10)
      return "PhoneNumber must has 10 numbers";
  }
  static  bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
