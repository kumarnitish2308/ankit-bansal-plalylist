-- 36 Incoming outgoing calls
-- 🔗 https://youtu.be/pk8BKFysjP8?si=sdNiergc4edNfq4m

-- table schema

create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values 
('OUT','181868',13),
('OUT','2159010',8),
('OUT','2159010',178),
('SMS','4153810',1),
('OUT','2159010',152),
('OUT','9140152',18),
('SMS','4162672',1),
('SMS','9168204',1),
('OUT','9168204',576),
('INC','2159010',5),
('INC','2159010',4),
('SMS','2159010',1),
('SMS','4535614',1),
('OUT','181868',20),
('INC','181868',54),
('INC','218748',20),
('INC','2159010',9),
('INC','197432',66),
('SMS','2159010',1),
('SMS','4535614',1);

/*
Write a query to find out the phone number that satisfy below condition
1. The numbers have both incoming and outgoing calls
2. The sum of duration of outgoing calls should be greater than sum of duration of incoming calls
*/

-- Solution 1
select * from
(
select 
    call_number,
    sum(case when call_type = 'OUT' then call_duration end) as outgoing_call_duration,
    sum(case when call_type = 'INC' then call_duration end) as incoming_call_duration
from call_details
where call_type in ('OUT', 'INC')
group by call_number
having count(distinct call_type) = 2
) a
where outgoing_call_duration > incoming_call_duration;

-- Solution 2
with calculated_cte as
(
select 
    call_number,
    sum(case when call_type = 'OUT' then call_duration else null end) as outgoing_call_duration,
    sum(case when call_type = 'INC' then call_duration else null end) as incoming_call_duration
from call_details
group by call_number
)
select * from calculated_cte
where outgoing_call_duration is not null and incoming_call_duration is not null and outgoing_call_duration > incoming_call_duration
