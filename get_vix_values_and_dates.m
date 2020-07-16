function [vixData, vixData_dates] = get_vix_values_and_dates(filename)

% clear
% format bank

load_entry_dates;
trade_dates = cell2mat(entry_dates);

[vix.o, vix.h, vix.l, vix.c, vix.v, vidt, vidn, vids, vix.d] = read_data(filename);

for n=1:137 
    indx(n) = find(trade_dates(n)==vix.d); 
end

vixData_dates = vix.d(indx);

vixData = vix.c(indx);
%[trade_dates(1:end-1)' vixData_dates vixData ]

