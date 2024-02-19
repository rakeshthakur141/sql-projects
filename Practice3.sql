create database hero;

/*
select cast("24.423423"  as float);

select *, date(date), hour(date), time(date), month(date)
SELECT num_enemies,
       COUNT(*) AS count,
       RPAD('*', COUNT(*), '*') AS bar
FROM hero_battles
GROUP BY num_enemies;




select * from hero_battles;
select replace(name, "Batman", "Batwoman" ) from hero_battles;

	select concat("This Battle Occured at"  ,  hour(date), " O' Clock") from hero_battles;
    
    
select * from hero_battles
left join heroes_information
on hero_battles.name = heroes_information.name; /* returns all rows from the left table and matching rows from right table */
/*
	select name from heroes_information
where Gender = "Female"
union
select hero_names from super_hero_powers
where `Accelerated Healing` = 'True';

select * from super_hero_powers
right join hero_battles
on super_hero_powers.hero_names = hero_battles.name;


*/


select date, name, num_enemies, /* Use of Window Functions in SQL */
num_enemies *100 / sum(num_enemies) 
over(partition by name) as pt
from hero_battles; 
/*
select date(date), name, num_enemies, 
Rank()Over(partition by name order by name desc)  as tough_battles from hero_battles;
*/

select date, num_enemies,
avg(num_enemies) over(order by date rows between 2 preceding and current row) 

 from hero_battles;
 
 /*select * from hero_battles; */
 select station_number, left(right(regexp_replace(station_number, '[^0-9]', ''),10),3) from hero_battles;
 
 show index from hero_battles;
 create index name_index on hero_battles(name);

Delimiter $$
Create procedure sp_all_rows_hero_battles()
Begin
  select * from hero_battles;
End $$


select * from information_schema.routines; /*  Gives List of all stored procedures in SQL */
call sp_all_rows_hero_battles();






