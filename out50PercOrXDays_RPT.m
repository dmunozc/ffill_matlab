function [profit_out,tradesout,DIT]=out50PercOrXDays_RPT(trade,maxdaysout)

global opts_2
entry_dates = @() opts_2(:,1); % entry dates
exp_dates = @() opts_2(:,2);   % expiration dates
strks = @() opts_2(:,10);      % strikes

%index of options with same exp. & strk as short put at a date after buy in
inda=(exp_dates()==trade(1,2))&(strks()==trade(1,3))&(entry_dates()>trade(1,1));
A = opts_2(inda,:);
%index of options with same exp. & strk as long put at a date after buy in
indb=(exp_dates()==trade(2,2))&(strks()==trade(2,3))&(entry_dates()>trade(2,1));
B = opts_2(indb,:);

premium_in = trade(1,4) + trade(2,4); % premium tradesin

%init tradesout with maxdaysout or last entry
for j = 1:size(A,1) %  size(A,1) is # rows of A 
    % A(j,9)  ==> ask, -B(j,8) ==> bid
    %         entry_date  exp_date  strike   bid/ask  P/C  Delta     DTE
    tradeout{j} = [A(j,1)  A(j,2)   A(j,10)   A(j,9)   0  A(j,11)  A(j,3); 
                   B(j,1)  B(j,2)   B(j,10)  -B(j,8)   0  B(j,11)  B(j,3)];   
               
%     premium_out(j) = tradeout{j}(1,4) + tradeout{j}(2,4);
    premium_out(j) = sum(tradeout{j}(:,4)); 
end

% go through all possible exit trades and find first at 50%
for i = 1:maxdaysout-1    
    if premium_out(i) <= -0.25*premium_in   %   75%
        tradesout = tradeout{i};
        profit_out = -(premium_out(i) + premium_in);
        DIT = i;
        return
    end
end

% maxdaysout = size(A,1); % expiration
% DIT = tradeout{maxdaysout}(1,7); % use for exit at expiration

tradesout = tradeout{maxdaysout};
profit_out = -(premium_out(maxdaysout) + premium_in);
DIT = maxdaysout;
end
