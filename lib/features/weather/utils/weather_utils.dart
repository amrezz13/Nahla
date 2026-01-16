import '../../../l10n/app_localizations.dart';

class WeatherUtils {
  static String getWeatherIcon(int code) {
    switch (code) {
      case 0:
        return '☀️'; // Clear
      case 1:
      case 2:
      case 3:
        return '⛅'; // Partly cloudy
      case 45:
      case 48:
        return '🌫️'; // Fog
      case 51:
      case 53:
      case 55:
        return '🌦️'; // Drizzle
      case 61:
      case 63:
      case 65:
        return '🌧️'; // Rain
      case 66:
      case 67:
        return '🌨️'; // Freezing rain
      case 71:
      case 73:
      case 75:
        return '❄️'; // Snow
      case 77:
        return '🌨️'; // Snow grains
      case 80:
      case 81:
      case 82:
        return '🌧️'; // Rain showers
      case 85:
      case 86:
        return '❄️'; // Snow showers
      case 95:
        return '⛈️'; // Thunderstorm
      case 96:
      case 99:
        return '⛈️'; // Thunderstorm with hail
      default:
        return '🌤️';
    }
  }

  static String getWeatherDescription(int code, AppLocalizations l10n) {
    switch (code) {
      case 0:
        return l10n.weatherClear;
      case 1:
        return l10n.weatherMainlyClear;
      case 2:
        return l10n.weatherPartlyCloudy;
      case 3:
        return l10n.weatherOvercast;
      case 45:
      case 48:
        return l10n.weatherFoggy;
      case 51:
      case 53:
      case 55:
        return l10n.weatherDrizzle;
      case 61:
      case 63:
      case 65:
        return l10n.weatherRainy;
      case 66:
      case 67:
        return l10n.weatherFreezingRain;
      case 71:
      case 73:
      case 75:
        return l10n.weatherSnowy;
      case 80:
      case 81:
      case 82:
        return l10n.weatherRainShowers;
      case 95:
      case 96:
      case 99:
        return l10n.weatherThunderstorm;
      default:
        return l10n.weatherUnknown;
    }
  }

  static String getWindDirection(int degrees, AppLocalizations l10n) {
    if (degrees >= 337 || degrees < 23) return l10n.windN;
    if (degrees >= 23 && degrees < 68) return l10n.windNE;
    if (degrees >= 68 && degrees < 113) return l10n.windE;
    if (degrees >= 113 && degrees < 158) return l10n.windSE;
    if (degrees >= 158 && degrees < 203) return l10n.windS;
    if (degrees >= 203 && degrees < 248) return l10n.windSW;
    if (degrees >= 248 && degrees < 293) return l10n.windW;
    return l10n.windNW;
  }

  static String getBeeAdvice(double temp, int humidity, double windSpeed, int weatherCode, AppLocalizations l10n) {
    List<String> advice = [];

    // Temperature advice
    if (temp < 10) {
      advice.add('🥶 ${l10n.beeTooCold}');
    } else if (temp < 15) {
      advice.add('❄️ ${l10n.beeSluggish}');
    } else if (temp >= 15 && temp <= 30) {
      advice.add('✅ ${l10n.beeGoodTemp}');
    } else if (temp > 30 && temp <= 35) {
      advice.add('🌡️ ${l10n.beeHot}');
    } else {
      advice.add('🔥 ${l10n.beeTooHot}');
    }

    // Humidity advice
    if (humidity < 40) {
      advice.add('💨 ${l10n.beeLowHumidity}');
    } else if (humidity > 80) {
      advice.add('💧 ${l10n.beeHighHumidity}');
    }

    // Wind advice
    if (windSpeed > 25) {
      advice.add('💨 ${l10n.beeTooWindy}');
    } else if (windSpeed > 15) {
      advice.add('🌬️ ${l10n.beeWindy}');
    }

    // Rain advice
    if (weatherCode >= 51 && weatherCode <= 67) {
      advice.add('🌧️ ${l10n.beeRainy}');
    } else if (weatherCode >= 80 && weatherCode <= 82) {
      advice.add('🌧️ ${l10n.beeShowers}');
    } else if (weatherCode >= 95) {
      advice.add('⛈️ ${l10n.beeStorm}');
    }

    if (advice.isEmpty) {
      advice.add('🐝 ${l10n.beeGreatDay}');
    }

    return advice.join('\n');
  }
}