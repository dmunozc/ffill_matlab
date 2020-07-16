function formatted_data = raw_to_format(data_table)
  %{
  Converts a regular csv with date yyyy-MM-dd format to japanese int
  format yyyyMMdd
  %}
  dates = data_table.date;
  new_dates = zeros(size(dates));
  for i_loc = 1:length(dates)
    new_dates(i_loc) = str2double(strcat(num2str(year(dates(i_loc))), ...
      pad_date(month(dates(i_loc))), ...
      pad_date(day(dates(i_loc)))));
  end
  formatted_data = data_table;
  formatted_data.date = new_dates;
end