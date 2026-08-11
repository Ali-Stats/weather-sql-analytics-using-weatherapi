import requests

from config import WEATHER_URL
from config import TIMEZONE


def get_weather(latitude, longitude):

    params = {
        "latitude": latitude,
        "longitude": longitude,
        "current": "temperature_2m,wind_speed_10m",
        "timezone": TIMEZONE
    }

    response = requests.get(
        WEATHER_URL,
        params=params
    )

    data = response.json()

    weather = {

        "temperature": data["current"]["temperature_2m"],

        "wind_speed": data["current"]["wind_speed_10m"],

        "time": data["current"]["time"]

    }

    return weather