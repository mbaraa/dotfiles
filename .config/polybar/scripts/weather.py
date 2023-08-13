#!/usr/bin/python3

import requests
import json
import time

class Weather:

    # constructor
    def __init__(self, cityName: str):
        # set city name
        self.__cityName = cityName
        # weather json variables
        self.__weatherData = None

        self.__downloadWeatherData()

    def getWeather(self):
        self.__updateWeatherVaraibles()
        print(" %.1f°C" % self.__temp)

    def __updateWeatherVaraibles(self):

        self.__downloadWeatherData()

        try:
            self.__temp = self.__weatherData['main']['temp'] - 273.15
            self.__description = self.__weatherData['weather'][0]['description']
            self.__windSpeed = self.__weatherData['wind']['speed'] * 3.6
            self.__airPressure = self.__weatherData['main']['pressure']
            self.__humidity = self.__weatherData['main']['humidity']
            self.__realTemp = self.__weatherData['main']['feels_like'] - 273.15
            self.__sunrise = time.ctime( self.__weatherData['sys']['sunrise'] )
            self.__sunset = time.ctime( self.__weatherData['sys']['sunset'] )

        except KeyError :
            print("No city found")
            exit(1)


    def __downloadWeatherData(self):
        try:
            # set url
            weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + self.__cityName + "&appid=2fb1078b1ae351cef587e0b7a1e479f0"
            # get weather data from the given url
            self.__weatherData = requests.get(weatherUrl).json()

        except requests.exceptions.ConnectionError:
            print("no internet connection!")
            exit(1)


w = Weather("Amman")
w.getWeather()
