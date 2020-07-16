function NumDays = daysAct_num( StartDate, EndDate )
% StartDate, EndDate are integers representing dates in Japanese format,
% i.e. 'yyyymmdd'

f = 'yyyymmdd';
NumDays = datenum(num2str(EndDate), f) - datenum(num2str(StartDate), f);


% StartDate_1 =  20160101
% EndDate_1 = 20160102
% F = 'yyyymmdd'
% 
% StartDate = datestr(StartDate_1, F)
% EndDate = datestr(EndDate_1, F)
% 
% % NumDays = datenum(datevec(EndDate)) - datenum(datevec(StartDate))
% 
% NumDays = datenum(EndDate) - datenum(StartDate)
% 
% n = datenum('19-May-2000') returns n = 730625. 
% 
% n = datenum('20000101', 'yyyymmdd')
% 
% 
% StartDate_1 =  20160101
% EndDate_1 = 20160703
% 
% NumDays = datenum(num2str(EndDate_1), 'yyyymmdd') - datenum(num2str(StartDate_1), 'yyyymmdd')
% daysAct_RPT(num2str(StartDate_1), 'yyyymmdd') , num2str(EndDate_1), 'yyyymmdd')) 

% StartDate =  20160110
% EndDate = 20160217
% f = 'yyyymmdd';
% NumDays = datenum(num2str(EndDate), f) - datenum(num2str(StartDate), f)  % 38 days

