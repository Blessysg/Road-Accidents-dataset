Select * From road_accident

Select SUM(number_of_casualties) as CY_Casualties
from road_accident
where year(accident_date) = '2022' And road_surface_conditions = 'Dry'

Select Count(distinct accident_index) as CY_Accidents
from road_accident
where year(accident_date) = '2022'

Select SUM(number_of_casualties) as CY_Fatal_Casualties
from road_accident
where year(accident_date) = '2022' And accident_severity = 'Fatal'

Select SUM(number_of_casualties) as CY_Fatal_Casualties
from road_accident
where accident_severity = 'Fatal'

Select SUM(number_of_casualties) as CY_Serious_Casualties
from road_accident
where year(accident_date) = '2022' And accident_severity = 'Serious'

Select SUM(number_of_casualties) as CY_Serious_Casualties
from road_accident
where accident_severity = 'Serious'

Select SUM(number_of_casualties) as CY_Slight_Casualties
from road_accident
where year(accident_date) = '2022' And accident_severity = 'Slight'

Select SUM(number_of_casualties) as CY_Slight_Casualties
from road_accident
where accident_severity = 'Slight'

Select cast(SUM(number_of_casualties) as decimal(10,2))*100 / 
(Select cast(SUM(number_of_casualties) as decimal(10,2)) from road_accident) as CY_Fatal_Casualties_percentage
from road_accident
where accident_severity = 'Fatal'

Select cast(SUM(number_of_casualties) as decimal(10,2))*100 / 
(Select cast(SUM(number_of_casualties) as decimal(10,2)) from road_accident) as CY_Serious_Casualties_percentage
from road_accident
where accident_severity = 'Serious'

Select cast(SUM(number_of_casualties) as decimal(10,2))*100 / 
(Select cast(SUM(number_of_casualties) as decimal(10,2)) from road_accident) as CY_Slight_Casualties_percentage
from road_accident
where accident_severity = 'Slight'

select distinct vehicle_type from road_accident

select 
case
when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
when vehicle_type in ('Car', 'Taxi/Private hire car') then'Car'
when vehicle_type in ('Motorcycle over 125cc and up to 500cc', 'Motorcycle 125cc and under', 'Motorcycle over 500cc', 'Motorcycle 50cc and under', 'Pedal cycle') then'Bike'
when vehicle_type in ('Minibus (8 - 16 passenger seats)', 'Bus or coach (17 or more pass seats)') then'Bus'
when vehicle_type in ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3.5 tonnes mgw or under') then'Van'
else 'Other'
end as vehicle_group,
sum (number_of_casualties) as CY_Casualties
from road_accident
where year(accident_date) = '2022'
group by
case
when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
when vehicle_type in ('Car', 'Taxi/Private hire car') then'Car'
when vehicle_type in ('Motorcycle over 125cc and up to 500cc', 'Motorcycle 125cc and under', 'Motorcycle over 500cc', 'Motorcycle 50cc and under', 'Pedal cycle') then'Bike'
when vehicle_type in ('Minibus (8 - 16 passenger seats)', 'Bus or coach (17 or more pass seats)') then'Bus'
when vehicle_type in ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3.5 tonnes mgw or under') then'Van'
else 'Other'
end

select DATENAME(month, accident_date) as Month_name, sum(number_of_casualties) as CY_Casualties
from road_accident
where YEAR(accident_date)='2022'
group by DATENAME(month, accident_date)
order by Month_name

SELECT road_type,
SUM(CASE WHEN YEAR(accident_date) = 2021 THEN number_of_casualties ELSE 0 END) AS casualties_2021,
SUM(CASE WHEN YEAR(accident_date) = 2022 THEN number_of_casualties ELSE 0 END) AS casualties_2022
FROM road_accident
WHERE YEAR(accident_date) IN (2021, 2022)
GROUP BY road_type;

select urban_or_rural_area, cast(sum(number_of_casualties) as decimal(10,2)) * 100 /
(select cast(sum(number_of_casualties) as decimal(10,2)) from road_accident where YEAR(accident_date)='2022') as PCT
from road_accident
where YEAR(accident_date)='2022'
group by urban_or_rural_area

select distinct light_conditions from road_accident

select
	case 
		when light_conditions in ('Daylight') then 'Day'
		when light_conditions in ('Darkness - no lighting','Darkness - lights unlit','Darkness - lights lit','Darkness - lighting unknown') then 'Night'
	end as Light_Condition,
	cast(cast(sum(number_of_casualties) as decimal(10,2)) * 100 /
	(select cast(sum(number_of_casualties) as decimal(10,2)) from road_accident where YEAR(accident_date)='2022') as decimal(10,2)) 
	as CY_Casualties_PCT
from road_accident
where YEAR(accident_date)='2022'
group by 
case 
		when light_conditions in ('Daylight') then 'Day'
		when light_conditions in ('Darkness - no lighting','Darkness - lights unlit','Darkness - lights lit','Darkness - lighting unknown') then 'Night'
	end

select top 10 local_authority, sum(number_of_casualties) as Total_Casualties
from road_accident
group by local_authority
order by Total_Casualties desc