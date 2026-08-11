from geocoding import get_coordinates
from weather import get_weather
from db_handler import save_weather_data


# -------------------------------
# STEP 1 : Ask user for city
# -------------------------------

city = input("Enter City: ").strip()


# -------------------------------
# STEP 2 : Validate input
# -------------------------------

if not city:

    print("City not found.")

    exit()


# -------------------------------
# STEP 3 : Geocoding API
# -------------------------------

try:

    latitude, longitude = get_coordinates(city)

except ValueError as error:

    print(error)

    exit()


# -------------------------------
# STEP 4 : Weather API
# -------------------------------

try:

    weather = get_weather(
        latitude,
        longitude
    )

except Exception as error:

    print(f"Weather API error: {error}")

    exit()


# -------------------------------
# STEP 5 : Extract weather data
# -------------------------------

temperature = weather["temperature"]

wind_speed = weather["wind_speed"]

time = weather["time"]


# -------------------------------
# STEP 6 : Display Weather Report
# -------------------------------

print()

print("------------- WEATHER REPORT -------------")

print(f"City        : {city}")
print(f"Latitude    : {latitude}")
print(f"Longitude   : {longitude}")
print(f"Time        : {time}")
print(f"Temperature : {temperature} °C")
print(f"Wind Speed  : {wind_speed} km/h")

print("------------------------------------------")


# -------------------------------
# STEP 7 : Save to PostgreSQL
# -------------------------------

try:

    save_weather_data(
        city,
        None,                  # State
        None,                  # Region
        latitude,
        longitude,
        time,
        temperature,
        wind_speed
    )

    print("\nWeather data saved successfully!")

except Exception:

    print("\nWeather data could not be saved.")