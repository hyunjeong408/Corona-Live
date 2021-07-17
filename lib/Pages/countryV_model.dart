
class CountryVList {
  final List<Country> countries;

  CountryVList({
    this.countries,
  });

  factory CountryVList.fromJson(List<dynamic> parsedJson) {
    List<Country> countries = [];
    countries = parsedJson.map((i)=>Country.fromJson(i)).toList();
    return CountryVList( //new CountryVList라고 쓰여져있었는데... 왜 new지?
        countries: countries
    );}
}

class Country {
  final String country;
  final String code;
  final List<Dates> data;

  Country({
    this.country,
    this.code,
    this.data,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    //print(json);
    var list = json['data'] as List;
    List<Dates> dataList = list.map((i) => Dates.fromJson(i)).toList();
    return Country(
        country: json['country'],
        code: json['iso_code'],
        data: dataList,
    );}
}

class Dates{
  final String date;
  final int totalV;
  final int peopleV;
  final int peopleFullV;
  final int dailyV;

  Dates({
    this.date,
    this.totalV,
    this.peopleV,
    this.peopleFullV,
    this.dailyV,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
        date: json['date'],
        totalV: json['total_vaccinations'],
        peopleV: json['people_vaccinated'],
        peopleFullV: json['people_fully_vaccinated'],
        dailyV:json ['daily_vaccinations'],
    );}

}