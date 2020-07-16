function date_out = increment_date(date_in, incr)
% increment the date by 'incr' days

% date_in = 20180531
% incr =1

f = 'yyyymmdd';
dn = datenum(num2str(date_in), f) + incr;

date_out = str2num(datestr(dn, f));
