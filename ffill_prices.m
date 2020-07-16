function resampled_prices = ffill_prices(prices)
  %{
  This function forward fills a structure given the dates and prices.
  prices structure needs .date in japanese int form. .close for prices.
  The forward fill fills the gaps produced by holidays. It only fills
  week days. Forward fill works by using the last known value as the 
  missing value.
  %}
  start_date = datetime(num2str(prices.date(1)),'InputFormat','yyyyMMdd');
  end_date = datetime(num2str(prices.date(end)),'InputFormat','yyyyMMdd');
  % Create all days between price dates
  resampled_prices.date = start_date:caldays(1):end_date;
  % Remove weekends
  resampled_prices.date = resampled_prices.date(~isweekend(resampled_prices.date))';
  resampled_prices = raw_to_format(resampled_prices);
  resampled_prices.close = zeros(size(resampled_prices.date));
  prev_match_loc = 1;
  for i_loc = 1:length(resampled_prices.date)
    match_loc = find(prices.date == resampled_prices.date(i_loc));
    % If found location, fill it, else use previous found location;
    if match_loc
      resampled_prices.close(i_loc) = prices.close(match_loc);
      prev_match_loc = match_loc;
    else
      resampled_prices.close(i_loc) = prices.close(prev_match_loc);
    end
  end
end