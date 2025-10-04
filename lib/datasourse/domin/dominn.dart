class WeatherModel {
  String? _cityname;
  int? _lon;
  int? _lat;
  String? _description;
  int? _temp;
  int? _temp_min;
  int? _temp_max;

  String? get cityname => _cityname;
  int? _pressure;
  int? _humidity;
  int? _speed;
  String? _country;
  var _sunrise;
  var _sunset;
  String? _name;

  WeatherModel(
      this._cityname,
      this._lon,
      this._lat,
      this._description,
      this._temp,
      this._temp_min,
      this._temp_max,
      this._pressure,
      this._humidity,
      this._speed,
      this._country,
      this._sunrise,
      this._sunset,
      this._name);

  int? get lon => _lon;

  int? get lat => _lat;

  String? get description => _description;

  int? get temp => _temp;

  int? get temp_min => _temp_min;

  int? get temp_max => _temp_max;

  int? get pressure => _pressure;

  int? get humidity => _humidity;

  int? get speed => _speed;

  String? get country => _country;

  get sunrise => _sunrise;

  get sunset => _sunset;

  String? get name => _name;


}