import 'package:pa3/Pages/countryCD_model.dart';

class Func {
  Func();
  double funcCntTotalC(CDdata country, int index, int len, int state){
    double totalC = 0;
    if(index >= 0){
      if(country.data[index].totalC != null) totalC += country.data[index].totalC;
      else if(index >= 1){
        if(country.data[index-1].totalC != null) totalC += country.data[index-1].totalC;
      }
    }
    else{
      if(country.data[len-1].totalC != null) totalC += country.data[len-1].totalC;
    }
    return totalC;
  }
  double funcCntDailyC(CDdata country, int index, int len, int state){
    double daily = 0;
    if(index >= 0){
      if(country.data[index].newC != null) daily += country.data[index].newC;
      else if(index >= 1){
        if(country.data[index-1].newC != null) daily += country.data[index-1].newC;
      }
    }
    else{
      if(country.data[len-1].newC != null) daily += country.data[len-1].newC;
    }
    return daily;
  }
  double funcCntTotalD(CDdata country, int index, int len, int state){
    double totalD = 0;
    if(index >= 0){
      if(country.data[index].totalD != null) totalD += country.data[index].totalD;
      else if(index >= 1){
        if(country.data[index-1].totalD != null) totalD += country.data[index-1].totalD;
      }
    }
    else{
      if(country.data[len-1].totalD != null) totalD += country.data[len-1].totalD;
    }
    return totalD;
  }
}