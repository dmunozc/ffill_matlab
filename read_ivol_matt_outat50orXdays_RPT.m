% 2:
% in on the first trading day of the month for first trade only,
% exit at 50% or 21 days, then enter next trade on the same day and exit
% as before. Repeat

% clear
% close all
% format compact
% format bank

global opts_2
% load opts_data.mat  % variable opts from opts_data.mat

entry_dates = @() opts_2(:,1); % entry dates
exp_dates = @() opts_2(:,2);   % expiration dates
strks = @() opts_2(:,10);      % strikes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gets the index of the first trading day of the month
fday = find((opts_2(2:end,1)   - floor(opts_2(2:end,1)/100)* 100) < ...
            (opts_2(1:end-1,1) - floor(opts_2(1:end-1,1)/100)* 100)) + 1;
n = opts_2(fday(1)); % first day
strike_away = 10;  % change this variable for the long put
maxdaysout = 21;     % 21

i=1;
while n <= 20160600 
    ind1 = (entry_dates()==n); %index of options with entry date
    A = opts_2(ind1,:); % A contains all the options with same entry
    [~, k] = min(abs(A(:,3) - 45)); %find closest DTE to 45
    ind2 = (A(:,2)==A(k,2)); %index of options with entry +exit date
    A=A(ind2,:);%reduce A to opts_2 with entry & exit date closest to 45 days
       
    [~, k] = min(abs(abs(A(:,11)) - 0.16)); %find closest delta to 0.16
    B = A(k,:); % info for short put
    [~, j] = min(abs(A(:,10)-(B(10)-strike_away)));%find index for long put 
    C = A(j,:); % info for long put
    %       trade date, exp date, strike, premium, put/call, delta
    tradesin{i}=[B(1)    B(2)      B(10)   -B(8)    0   B(11); % short put
                 C(1)    C(2)      C(10)    C(9)    0   C(11)];% long  put  
     
    [profit(i), tradesout{i}, DIT(i)] = ...
                           out50PercOrXDays_RPT(tradesin{i}, maxdaysout);
    
    n = tradesout{i}(1,1); % new entry date 
    i = i+1;
end

prob = sum(profit>0)/length(profit)
figure
bar(100*profit)

equity = 100*cumsum(profit);
figure
plot(equity)
totalprofit=equity(end)
