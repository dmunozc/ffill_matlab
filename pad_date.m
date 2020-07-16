function new_date = pad_date(num)
  %{
  Pads an integer date.
  %}
  if num >= 10
    new_date = num2str(num);
  else
    new_date = strcat('0', num2str(num));
  end
end