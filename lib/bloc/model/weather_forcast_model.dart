class ForcastModel {
  Location? location;
  Current? current;
  Forecast? forecast;

  /// ✅ New: App-level preferences for Settings Screen
  String? temperatureUnit; // "C" or "F"
  String? windSpeedUnit; // "kph" or "mph"
  String? pressureUnit; // "mb" or "in"
  bool? isDarkMode; // for theme preference

  ForcastModel({
    this.location,
    this.current,
    this.forecast,
    this.temperatureUnit = "C",
    this.windSpeedUnit = "kph",
    this.pressureUnit = "mb",
    this.isDarkMode = false,
  });

  ForcastModel.fromJson(Map<String, dynamic> json) {
    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
    json['current'] != null ? Current.fromJson(json['current']) : null;
    forecast =
    json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;

    /// ✅ New Settings Fields
    temperatureUnit = json['temperatureUnit'] ?? "C";
    windSpeedUnit = json['windSpeedUnit'] ?? "kph";
    pressureUnit = json['pressureUnit'] ?? "mb";
    isDarkMode = json['isDarkMode'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (location != null) data['location'] = location!.toJson();
    if (current != null) data['current'] = current!.toJson();
    if (forecast != null) data['forecast'] = forecast!.toJson();

    /// ✅ Add new settings fields
    data['temperatureUnit'] = temperatureUnit;
    data['windSpeedUnit'] = windSpeedUnit;
    data['pressureUnit'] = pressureUnit;
    data['isDarkMode'] = isDarkMode;

    return data;
  }

  /// ✅ Helper methods for displaying data based on settings

  // String getTemperature(double? celsius) {
  //   if (celsius == null) return '--';
  //   if (temperatureUnit == 'F') {
  //     return '${(celsius * 9 / 5 + 32).toStringAsFixed(1)} °F';
  //   } else {
  //     return '${celsius.toStringAsFixed(1)} °C';
  //   }
  // }
  //
  // String getWindSpeed(double? kph) {
  //   if (kph == null) return '--';
  //   if (windSpeedUnit == 'mph') {
  //     return '${(kph / 1.609).toStringAsFixed(1)} mph';
  //   } else {
  //     return '${kph.toStringAsFixed(1)} kph';
  //   }
  // }
  //
  // String getPressure(double? mb) {
  //   if (mb == null) return '--';
  //   if (pressureUnit == 'in') {
  //     return '${(mb * 0.02953).toStringAsFixed(2)} inHg';
  //   } else {
  //     return '${mb.toStringAsFixed(1)} mb';
  //   }
  // }
}

class Location {
  String? name, region, country, tzId, localtime;
  double? lat, lon;
  int? localtimeEpoch;

  Location(
      {this.name,
        this.region,
        this.country,
        this.lat,
        this.lon,
        this.tzId,
        this.localtimeEpoch,
        this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = (json['lat'] is int) ? (json['lat'] as int).toDouble() : json['lat'];
    lon = (json['lon'] is int) ? (json['lon'] as int).toDouble() : json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'region': region,
    'country': country,
    'lat': lat,
    'lon': lon,
    'tz_id': tzId,
    'localtime_epoch': localtimeEpoch,
    'localtime': localtime,
  };
}

class Current {
  int? lastUpdatedEpoch, isDay, windDegree, humidity, cloud;
  String? lastUpdated, windDir;
  double? tempC, tempF, windMph, windKph, pressureMb, pressureIn;
  double? feelslikeC, feelslikeF, uv, gustMph, gustKph, visKm, visMiles;
  Condition? condition;

  Current(
      {this.lastUpdatedEpoch,
        this.lastUpdated,
        this.tempC,
        this.tempF,
        this.isDay,
        this.condition,
        this.windMph,
        this.windKph,
        this.windDegree,
        this.windDir,
        this.pressureMb,
        this.pressureIn,
        this.humidity,
        this.cloud,
        this.feelslikeC,
        this.feelslikeF,
        this.uv,
        this.gustMph,
        this.gustKph,
        this.visKm,
        this.visMiles});

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];
    tempC = (json['temp_c'] is int)
        ? (json['temp_c'] as int).toDouble()
        : json['temp_c'];
    tempF = (json['temp_f'] is int)
        ? (json['temp_f'] as int).toDouble()
        : json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windMph = (json['wind_mph'] is int)
        ? (json['wind_mph'] as int).toDouble()
        : json['wind_mph'];
    windKph = (json['wind_kph'] is int)
        ? (json['wind_kph'] as int).toDouble()
        : json['wind_kph'];
    windDegree = json['wind_degree'];
    windDir = json['wind_dir'];
    pressureMb = (json['pressure_mb'] is int)
        ? (json['pressure_mb'] as int).toDouble()
        : json['pressure_mb'];
    pressureIn = (json['pressure_in'] is int)
        ? (json['pressure_in'] as int).toDouble()
        : json['pressure_in'];
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = (json['feelslike_c'] is int)
        ? (json['feelslike_c'] as int).toDouble()
        : json['feelslike_c'];
    feelslikeF = (json['feelslike_f'] is int)
        ? (json['feelslike_f'] as int).toDouble()
        : json['feelslike_f'];
    uv = (json['uv'] is int) ? (json['uv'] as int).toDouble() : json['uv'];
    gustMph = (json['gust_mph'] is int)
        ? (json['gust_mph'] as int).toDouble()
        : json['gust_mph'];
    gustKph = (json['gust_kph'] is int)
        ? (json['gust_kph'] as int).toDouble()
        : json['gust_kph'];
    visKm = (json['vis_km'] is int)
        ? (json['vis_km'] as int).toDouble()
        : json['vis_km'];
    visMiles = (json['vis_miles'] is int)
        ? (json['vis_miles'] as int).toDouble()
        : json['vis_miles'];
  }

  Map<String, dynamic> toJson() => {
    'last_updated_epoch': lastUpdatedEpoch,
    'last_updated': lastUpdated,
    'temp_c': tempC,
    'temp_f': tempF,
    'is_day': isDay,
    'condition': condition?.toJson(),
    'wind_mph': windMph,
    'wind_kph': windKph,
    'wind_degree': windDegree,
    'wind_dir': windDir,
    'pressure_mb': pressureMb,
    'pressure_in': pressureIn,
    'humidity': humidity,
    'cloud': cloud,
    'feelslike_c': feelslikeC,
    'feelslike_f': feelslikeF,
    'uv': uv,
    'gust_mph': gustMph,
    'gust_kph': gustKph,
    'vis_km': visKm,
    'vis_miles': visMiles,
  };
}

class Condition {
  String? text, icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() => {'text': text, 'icon': icon, 'code': code};
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = [];
      json['forecastday']
          .forEach((v) => forecastday!.add(Forecastday.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() =>
      {'forecastday': forecastday?.map((v) => v.toJson()).toList()};
}

class Forecastday {
  String? date;
  int? dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({this.date, this.dateEpoch, this.day, this.astro, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateEpoch = json['date_epoch'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = [];
      json['hour'].forEach((v) => hour!.add(Hour.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'date_epoch': dateEpoch,
    'day': day?.toJson(),
    'astro': astro?.toJson(),
    'hour': hour?.map((v) => v.toJson()).toList(),
  };
}

class Day {
  double? maxtempC,
      mintempC,
      avgtempC,
      maxwindKph,
      totalprecipMm,
      uv;
  int? avghumidity, dailyWillItRain;
  Condition? condition;

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = (json['maxtemp_c'] is int)
        ? (json['maxtemp_c'] as int).toDouble()
        : json['maxtemp_c'];
    mintempC = (json['mintemp_c'] is int)
        ? (json['mintemp_c'] as int).toDouble()
        : json['mintemp_c'];
    avgtempC = (json['avgtemp_c'] is int)
        ? (json['avgtemp_c'] as int).toDouble()
        : json['avgtemp_c'];
    maxwindKph = (json['maxwind_kph'] is int)
        ? (json['maxwind_kph'] as int).toDouble()
        : json['maxwind_kph'];
    totalprecipMm = (json['totalprecip_mm'] is int)
        ? (json['totalprecip_mm'] as int).toDouble()
        : json['totalprecip_mm'];
    avghumidity = json['avghumidity'];
    dailyWillItRain = json['daily_will_it_rain'];
    uv = (json['uv'] is int) ? (json['uv'] as int).toDouble() : json['uv'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() => {
    'maxtemp_c': maxtempC,
    'mintemp_c': mintempC,
    'avgtemp_c': avgtempC,
    'maxwind_kph': maxwindKph,
    'totalprecip_mm': totalprecipMm,
    'avghumidity': avghumidity,
    'daily_will_it_rain': dailyWillItRain,
    'uv': uv,
    'condition': condition?.toJson(),
  };
}

class Astro {
  String? sunrise, sunset, moonrise, moonset, moonPhase;
  int? isSunUp;

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    isSunUp = json['is_sun_up'];
  }

  Map<String, dynamic> toJson() => {
    'sunrise': sunrise,
    'sunset': sunset,
    'moonrise': moonrise,
    'moonset': moonset,
    'moon_phase': moonPhase,
    'is_sun_up': isSunUp,
  };
}

class Hour {
  int? timeEpoch, isDay;
  String? time, windDir;
  double? tempC, tempF, windKph, pressureMb, precipMm, feelslikeC, uv;
  Condition? condition;

  Hour.fromJson(Map<String, dynamic> json) {
    timeEpoch = json['time_epoch'];
    time = json['time'];
    tempC = (json['temp_c'] is int)
        ? (json['temp_c'] as int).toDouble()
        : json['temp_c'];
    tempF = (json['temp_f'] is int)
        ? (json['temp_f'] as int).toDouble()
        : json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = (json['wind_kph'] is int)
        ? (json['wind_kph'] as int).toDouble()
        : json['wind_kph'];
    windDir = json['wind_dir'];
    pressureMb = (json['pressure_mb'] is int)
        ? (json['pressure_mb'] as int).toDouble()
        : json['pressure_mb'];
    precipMm = (json['precip_mm'] is int)
        ? (json['precip_mm'] as int).toDouble()
        : json['precip_mm'];
    feelslikeC = (json['feelslike_c'] is int)
        ? (json['feelslike_c'] as int).toDouble()
        : json['feelslike_c'];
    uv = (json['uv'] is int) ? (json['uv'] as int).toDouble() : json['uv'];
  }

  Map<String, dynamic> toJson() => {
    'time_epoch': timeEpoch,
    'time': time,
    'temp_c': tempC,
    'temp_f': tempF,
    'is_day': isDay,
    'condition': condition?.toJson(),
    'wind_kph': windKph,
    'wind_dir': windDir,
    'pressure_mb': pressureMb,
    'precip_mm': precipMm,
    'feelslike_c': feelslikeC,
    'uv': uv,
  };
}
