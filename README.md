# Le Baluchon

## Description of the application

Le Baluchon is therefore a three-page application:

Get the exchange rate between the dollar and your current currency.
Translate from your favorite language to English
Compare the local weather forecast and that of your good old home (just to be happy to be gone ... or not!: Sun :)
To navigate between the pages, you will use a tab bar, each tab corresponding to one of the three pages described previously.

During calls to networks in the application, if an error occurs, you must present it in the form of a pop-up using the UIAlertController class.

### Exchange rate

In the exchange rate page, you can insert an amount in your local currency and see the result in dollars ($). Nothing really rocket science a priori!

To get the exchange rate, you will use the fixer.io API, which is updated daily. You will therefore need to obtain the exchange rate at least once a day to be sure to display the correct dollar amount to your users.

#### Little more

User can choose exchange rate from the list offered by the API.

### Translation
In the translation page, the user can write the sentence of his choice in French and obtain its translation in English of course!

For that, you will use the API of Google Translate. Unlike the previous one, this API requires a key which you will get by following the steps explained in the documentation.

#### Little more

the application detects the language and offers the possibility of translating into 4 different languages ​​(French, English, Spanish, and German)

### The weather

In the weather page, you will display the weather information for New York and the city of your choice (where you live).

For each city, you will display the current conditions using the OpenWeathermap API, specifying in particular:

Temperature
Description of conditions (cloudy, sunny), etc.

#### Little more

On another page, the user can choose to consult the weather forecast for the city of his choice

