from database import get_connection


def save_weather_data(
    city,
    state,
    region,
    latitude,
    longitude,
    time,
    temperature,
    wind_speed
):

    connection = None
    cursor = None

    try:

        connection = get_connection()

        cursor = connection.cursor()

        query = """
            INSERT INTO weather_data (
                city,
                state,
                region,
                latitude,
                longitude,
                observed_at,
                temperature,
                wind_speed
            )
            VALUES (
                %s,
                %s,
                %s,
                %s,
                %s,
                %s,
                %s,
                %s
            )
        """

        cursor.execute(
            query,
            (
                city,
                state,
                region,
                latitude,
                longitude,
                time,
                temperature,
                wind_speed
            )
        )

        connection.commit()

    except Exception as error:

        if connection:
            connection.rollback()

        print(f"Database error: {error}")

        raise

    finally:

        if cursor:
            cursor.close()

        if connection:
            connection.close()