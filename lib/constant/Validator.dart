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
