//extension on string
import '../data/mapper/mapper.dart';

extension NonNullString on String{
  String orEmpty(){
    if(this == null){
      return EMPTY;
    }else{
      return this;
    }
  }
}

//extension on int
extension NonNullInteger on int?{
  int orZero(){
    if(this == null){
      return ZERO;
    }else{
      return this!;
    }
  }
}