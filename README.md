# weather_app

A weather application for assignment project of Go India Stocks. It fetch data from OpenWeatherMap and shows weather condition of user's desired city.

## Description

This Flutter application fetch data form OpenWeatherMap API and show following data:
- Temperature
- Humidity
- Wind Speed
- Sky Condition
- Weather condition
- An icon based on weather condition

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [API Reference](#api-reference)


## Features

- Show weather data of city name entered by user
- Show error message if internet connection is not proper
- Show error message if the entered city name does not exist


## Installation

Follow these steps to set up and run the project locally.

1. **Clone the repository**:
    ```
    git clone https://github.com/ommishraji/weather_app_project
    ```

2. **Install dependencies**:
    ```
    flutter pub get
    ```

3. **Run the application**:
    ```
    flutter run
    ```

## Usage

1. Open the application
2. Enter city name
3. The app will show weather condition of entered location

## API Reference

The app fetches posts from the following API:
- OpenWeatherMap API via city name