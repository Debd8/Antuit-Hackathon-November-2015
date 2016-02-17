# Antuit-Hackathon-November-2015
A company-wide hackathon to predict daily sales for a restaurant chain

Problem statement:

MFF operates over 10,000 restaurants in 12 food crazy countries. Restaurant traffic is influenced by many factors, including food festivals, discounts, competition, state holidays, seasonality, and locality. MFF challenges you to predict sales at its 700 restaurants located across Republic of Chicken for the month of July 2015. Robust forecast would prove critical in improving efficiency & productivity across the board and help MFF focus on its ‘Customer First’ strategy. MFF will commission a panel who will compare the predicted sales with actuals. The team that predicts with minimal Root Mean Square Error will be rewarded a one-time meal voucher by MFF.

Data fields:

Most of the fields are self-explanatory

•             Id - an Id that represents a (restaurant, Date) duple within the test set

•             Restaurant - a unique Id for each restaurant

•             Sales - the turnover for any given day (this is what you are predicting)

•             Traffic - the number of customers on a given day, note that each member in groups are counted as 1 unit

•             Open_Close_ID - an indicator for whether the restaurant was open or not: 0 = closed, 1 = open

•             StateHoliday - indicates a state holiday. Normally all restaurants, with few exceptions, are closed on state holidays

•             RestaurantTypeDesc - differentiates between restaurant types

•             FoodTypesAvailable - describes cuisine type

•             CompetitionDistance - distance in meters to the nearest competitor restaurant

•             Promo - indicates whether a restaurant is running a promo on that day

 
