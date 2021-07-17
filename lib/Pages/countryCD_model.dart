class CountryCDList {
  final List<CDdata> countries;
  CountryCDList({
    this.countries,
  });
  factory CountryCDList.fromJson(List<dynamic> parsedJson) {
    List<CDdata> countries = [];
    countries = parsedJson.map((i)=>CDdata.fromJson(i)).toList();
    return CountryCDList( //new CountryVList라고 쓰여져있었는데... 왜 new지?
        countries: countries
    );}
}

class CDdata {
  final String continent;
  final String location;
  final List<Dates> data;

  CDdata({
    this.continent,
    this.location,
    this.data,
  });

  factory CDdata.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Dates> dataList = list.map((i) => Dates.fromJson(i)).toList();
    return CDdata(
      continent: json['continent'],
      location: json['location'],
      data: dataList,
    );}
}

class Dates{
  final String date;
  final double totalC;
  final double newC;
  final double totalD;

  Dates({
    this.date,
    this.totalC,
    this.newC,
    this.totalD,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      date: json['date'],
      totalC: json['total_cases'],
      newC: json['new_cases'],
      totalD: json['total_deaths'],
    );}

}