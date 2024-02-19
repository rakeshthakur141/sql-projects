use hero;
select * from heroes_information;
select * from heroes_information
  where Race in (
  select Race from heroes_information
    group by Race
   having avg(weight) > 400 );
   
   
   create temporary table bigs(
    select * from heroes_information
  where Race in (
  select Race from heroes_information
    group by Race
   having avg(weight) > 400 )
   );
   
create view	 view1 as 
select * from heroes_information
where Publisher = "Marvel Comics"
and Height > (select avg(Height) from heroes_information
where Publisher = "Marvel Comics");

select* from view1;

create index index1 on heroes_information(name, Race);
show index from heroes_information;



DELIMITER $$

CREATE PROCEDURE all_dc_rows()
BEGIN
    SELECT *
    FROM heroes_information
    WHERE Publisher = 'DC Comics';
END $$

DELIMITER ;
call all_dc_rows();


call all_dc_rows();


   