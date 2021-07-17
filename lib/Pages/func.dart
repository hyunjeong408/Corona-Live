import 'package:pa3/Pages/countryV_model.dart';

class Func{
  Func();
  int funcCountTotal(Country country, int index, int len, int state){
    int total = 0;
    if(index >= 0){
      if(country.data[index].totalV != null) total += country.data[index].totalV;
      else if(country.data[index].peopleV != null) total += country.data[index].peopleV;
      else if(country.data[index].peopleFullV != null) total += country.data[index].peopleFullV;
    }
    else{
      if(country.data[len-1].totalV != null) total += country.data[len-1].totalV;
      else if(country.data[len-1].peopleV != null) total += country.data[len-1].peopleV;
      else if(country.data[len-1].peopleFullV != null) total += country.data[len-1].peopleFullV;
    }
    return total;
  }

  int funcCountFully(Country country, int index, int len, int state){
    int full = 0;
    if(index >= 0){
      if(country.data[index].peopleFullV != null) full += country.data[index].peopleFullV;
      else if(index >= 1){
        if(country.data[index-1].peopleFullV != null) full += country.data[index-1].peopleFullV;
      }
    }
    else{
      if(country.data[len-1].peopleFullV != null) full += country.data[len-1].peopleFullV;
    }
    return full;
  }

  int funcCountDaily(Country country, int index, int len, int state){
    int daily = 0;
    if(index >= 0){
      if(country.data[index].dailyV != null) daily += country.data[index].dailyV;
      else if(index >= 1){
        if(country.data[index-1].dailyV != null) daily += country.data[index-1].dailyV;
      }
    }
    else{
      if(country.data[len-1].dailyV != null) daily += country.data[len-1].dailyV;
    }
    return daily;
  }
}