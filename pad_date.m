function new_date = pad_date(num)
  if num >= 10
    new_date = num2str(num);
  else
    new_date = strcat('0', num2str(num));
  end
end