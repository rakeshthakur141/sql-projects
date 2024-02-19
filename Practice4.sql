use hero;
select * from heroes_information;
/*select   Race, avg(Weight) as avg_weigh from heroes_information
group by Race

having avg_weigh <= 100; */









/*
Select `Eye color`,
CASE 
When `Eye color` = "red" then "Normal"
when 'Eye Color' = "yellow" Then "Spooky"
Else "Other"

End as eye_color_category
from heroes_information; 
*/

select race,
CASE
when Race = "Human" then 1
else 0
end as human
from heroes_information;

select * from heroes_information;
select name, weight from heroes_information;
SELECT name, weight, RANK() OVER (ORDER BY weight DESC) 	
FROM heroes_information;

select * from heroes_information;
select avg(weight)  as avg_weight, avg(Height) as avg_height, race from heroes_information
group by Race
having avg_weight > 150 && avg_height > 100;


select left(name, 1) as letter , count(*) as freq 
from heroes_information
group by letter;


select * from heroes_information
where `Eye color` in (
select `Eye color` from heroes_information group by `Eye color` having avg(weight) >100 );
 
