create database insurance_kpi;
use insurance_kpi;
select * from invoice;

## 1
select `Account Executive`, count(*) from invoice
group by `Account Executive`
order by count(*) desc;

##2
select count(*) from meeting;
SELECT 
    YEAR(STR_TO_DATE(`meeting_date`, '%d-%m-%Y')) AS meeting_year,
    COUNT(*) AS total_meetings
FROM meeting
WHERE `meeting_date` IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(`meeting_date`, '%d-%m-%Y'))
ORDER BY meeting_year;

##3
-- New
SELECT
  'New' AS income_class,
  (SELECT SUM(`New Budget`) FROM indivi_bud) AS target,
  (SELECT SUM(amount) FROM brokerage WHERE income_class = 'New') +
  (SELECT SUM(amount) FROM fees WHERE income_class = 'New') As Archieved,
  (SELECT SUM(amount) FROM fees WHERE income_class = 'New') AS invoiced

UNION

-- Cross Sell
SELECT
  'Cross Sell',
  (SELECT SUM(`Cross sell bugdet`) FROM indivi_bud),
  (SELECT SUM(amount) FROM brokerage WHERE income_class = 'Cross Sell') +
  (SELECT SUM(amount) FROM fees WHERE income_class = 'Cross Sell'),
  (SELECT SUM(amount) FROM fees WHERE income_class = 'Cross Sell')

UNION

-- Renewal
SELECT
  'Renewal',
  (SELECT SUM(`Renewal Budget`) FROM indivi_bud),
  (SELECT SUM(amount) FROM brokerage WHERE income_class = 'Renewal') +
  (SELECT SUM(amount) FROM fees WHERE income_class = 'Renewal'),
  (SELECT SUM(amount) FROM fees WHERE income_class = 'Renewal');

## 4
select stage, sum(revenue_amount) as total_amount from opportunity
group by stage
order by total_amount desc;

## 5
select `Account Executive`, count(*) from meeting
group by `Account Executive`;

## 6
select opportunity_name , stage, revenue_amount from opportunity
order by revenue_amount desc;


desc `insurance_kpi`.`indivi_bud`;
select* from`insurance_kpi`.`indivi_bud`;


