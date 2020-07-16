% Read csv file
filename = "VVIX";
prices_raw = readtable(strcat(filename, ".csv"));
% Create new structure containing date and close only
prices.date = prices_raw.Date;
prices.close = prices_raw.Close;
% Reformat to japanese int date format
prices = raw_to_format(prices);
% Forward fill missing prices
prices = ffill_prices(prices);
save(strcat(filename, ".mat"), 'prices')