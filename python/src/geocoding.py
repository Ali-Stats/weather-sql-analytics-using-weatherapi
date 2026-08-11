import requests
import unicodedata

from config import GEOCODING_URL


def normalize_text(text):

    """
    Normalize text so that accented characters
    can be compared with their basic equivalents.

    Example:

        Sibsāgar → Sibsagar
    """

    normalized = unicodedata.normalize(
        "NFKD",
        text
    )

    return "".join(
        character
        for character in normalized
        if not unicodedata.combining(character)
    ).lower().strip()


def get_coordinates(city, state=None):

    params = {
        "name": city,
        "count": 10,
        "language": "en",
        "format": "json"
    }

    response = requests.get(
        GEOCODING_URL,
        params=params
    )

    response.raise_for_status()

    data = response.json()

    if "results" not in data:

        raise ValueError(
            f"City not found: {city}"
        )

    results = data["results"]


    # --------------------------------
    # Step 1 : Prefer India
    # --------------------------------

    india_results = [
        result
        for result in results
        if result.get("country_code") == "IN"
    ]

    if india_results:

        results = india_results


    # --------------------------------
    # Step 2 : Prefer matching state
    # --------------------------------

    if state:

        normalized_state = normalize_text(state)

        state_results = [
            result
            for result in results
            if normalize_text(
                result.get("admin1", "")
            ) == normalized_state
        ]

        if state_results:

            results = state_results


    # --------------------------------
    # Step 3 : Prefer exact city name
    # --------------------------------

    normalized_city = normalize_text(city)

    exact_results = [
        result
        for result in results
        if normalize_text(
            result.get("name", "")
        ) == normalized_city
    ]

    if exact_results:

        results = exact_results


    # --------------------------------
    # Step 4 : Select best result
    # --------------------------------

    result = results[0]


    return (
        result["latitude"],
        result["longitude"]
    )