CREATE database CRManalytics;
use CRManalytics;
select * from `opportunitytable`;

#lead values
#1.TOTAL LEADS
select count(*) As "total leads"
from`lead`;

#2.Expected amount from Converted leads
select count(*) "converted Leads",sum(`Amount`)as "Expected Amount from converted leads"
from `opportunitytable`
where stage = "closed won";

#3. conversion rate(%)
select (count(case when status= "converted" then 1 end)* 100.0/count(*))+ "%" AS "Conversion Rate(%)"
from `lead`;

#4.Converted Accounts
select count(*) As "converted Accounts"
from `lead`
where status = "converted";

#5.converted opportunities
select count(*) "Converted Opportunities"
from `opportunitytable`
where stage = "Closed won";

#6.lead by source
SELECT `Lead Source`, COUNT(*) AS Lead_Count
FROM `lead`
GROUP BY `Lead Source`
ORDER BY Lead_Count DESC;

#7. lead by industry
SELECT `Industry`, COUNT(*) AS Lead_Count
FROM `lead`
GROUP BY `Industry`
ORDER BY Lead_Count DESC;

#8.lead by stage
SELECT `Status`, COUNT(*) AS Lead_Count
FROM `lead`
GROUP BY `Status`
ORDER BY Lead_Count DESC;


#Opportunity values
#1.Expected Amount
SELECT 
  SUM(`Expected Amount`) AS TotalExpectedAmount
FROM 
  `opportunitytable`;
  
#2.Active opportunities
SELECT 
  COUNT(*) AS ActiveOpportunities
FROM 
  `opportunitytable`
WHERE 
  `Stage` NOT IN ('Closed Won', 'Closed Lost');
  
#3.Conversion rate
SELECT 
    (COUNT(CASE WHEN stage = 'Closed Won' THEN 1 END) * 100.0) / COUNT(*) AS conversion_rate_percent
FROM `opportunitytable`;

#4.win rate
SELECT 
    (COUNT(CASE WHEN stage = 'Closed Won' THEN 1 END) * 100.0) /
    COUNT(CASE WHEN stage IN ('Closed Won', 'Closed Lost') THEN 1 END) AS win_rate_percent
FROM `opportunitytable`;

#5.Loss rate
SELECT 
    (COUNT(CASE WHEN stage = 'Closed Lost' THEN 1 END) * 100.0) / COUNT(*) AS loss_rate_percent
FROM `opportunitytable`;

#6.Expected vs Forecast
SELECT 
  `Created Date`,
  SUM(`Expected Amount`) OVER (ORDER BY `Created Date`) AS RunningExpected,
  SUM(`Amount`) OVER (ORDER BY `Created Date`) AS RunningForecast
FROM 
  `opportunitytable`
WHERE 
  `Created Date`IS NOT NULL
ORDER BY 
  `Created Date`;
  
#7.Active vs Total Opportunities
SELECT 
  COUNT(*) AS TotalOpportunities,
  SUM(CASE 
        WHEN `Stage` NOT IN ('Closed Won', 'Closed Lost') THEN 1 
        ELSE 0 
      END) AS ActiveOpportunities
FROM 
  `opportunitytable`;

#8.Closed won vs Total Opportunities
SELECT 
  COUNT(*) AS TotalOpportunities,
  SUM(CASE 
        WHEN `Stage` = 'Closed Won' THEN 1 
        ELSE 0 
      END) AS ClosedWon
FROM 
  `opportunitytable`;

#9total won vs closed won
SELECT 
  SUM(CASE 
        WHEN `Stage` IN ('Closed Won', 'Closed Lost') THEN 1 
        ELSE 0 
      END) AS TotalClosed,
  SUM(CASE 
        WHEN `Stage` = 'Closed Won' THEN 1 
        ELSE 0 
      END) AS ClosedWon
FROM 
  `opportunitytable`;
  
#10. Expected amount by opportunity type
SELECT 
    `Opportunity Type`,
    SUM(`Expected Amount`) AS Total_Expected
FROM `opportunitytable`
GROUP BY `Opportunity Type`;

#11, Opportunities by industry
SELECT 
    industry,
    COUNT(*) AS opportunity_count
FROM `opportunitytable`
GROUP BY industry
ORDER BY opportunity_count DESC;