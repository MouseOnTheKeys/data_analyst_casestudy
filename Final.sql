/*
 * Product Analyst assignment
 * Part 2
 * Queries are written and tested in PostgreSQL Database 
 * Database is created by DWH task diagram with some dummy data.
 */
 
/* 1) Please write the SQL SELECT query for the result described in a) and answer the questions in b).
 * Please ignore users here, who are not registered.
 * a) The number of daily active users per device
*/ 
select count(activity_user_id), activity_timestamp::date, device_name
from public.activities as ac
join public.users as us
on ac.activity_user_id=us.user_id
join public.devices as de
on ac.activity_device_id=de.device_id
group by activity_timestamp::date, device_name ;

/* b) What kind of issue could occur, when using this result for further analysis, e.g. for calculating
 * the total number of daily active users? How would you adjust the query to fix it?
*/
--The result shows us the false number of daily active users because it shows active users per device and
--users can be active on multiple devices. We can adjust the query by inserting where clause
--activity_is_last=true and removing device_name from the group by.
select count(activity_user_id) "num of active users", activity_timestamp::date
from public.activities as ac
join public.users as us
on ac.activity_user_id=us.user_id
join public.devices as de
on ac.activity_device_id=de.device_id
where activity_is_last=true
group by activity_timestamp::date ;

/* 2) Please write the SQL SELECT queries for the following results:
 * a) The total pay_amount per city for sales in 2019
*/
select sum(pay_amount), user_city
from public.users as us
join public.sales as sa
on us.user_id=sa.sale_user_id
join public.payments as py
on sa.sale_id=py.pay_sale_id
where sale_timestamp>='2019-01-01' and sale_timestamp<'2020-01-01'
group by user_city ;

/* b) The number of users, for whom the last activity was done with device_name = “phone”,
 * but who have also at least one additional activity with another device
*/
select count(activity_user_id) as "number of users"
from public.activities as ac
join public.devices as dev
on ac.activity_device_id=dev.device_id
where ac.activity_is_last=true and dev.device_name='phone'
and activity_user_id in (select activity_user_id
from public.activities
join public.devices
on public.activities.activity_device_id=public.devices.device_id
where public.devices.device_name != 'phone')
group by activity_user_id, device_id ;

/* c) Per day in 2019 the number of page visits and registrations */
select datum."Day of 2019", coalesce(visits."num of reg users",0) "num of reg users",
coalesce(visits."page visits",0) "page visits"
from
(select date_trunc('day', dd):: date as "Day of 2019"
from generate_series
( '2019-01-01'::timestamp
, '2019-12-31'::timestamp
, '1 day'::interval) dd) datum
left join
(select info_timestamp::date as "visits day of 2019", count(user_id) as "num of reg users",
sum(info_page_visits) as "page visits"
from public.users as us
join public.activities as ac
on us.user_id=ac.activity_user_id
join public.devices as dev
on ac.activity_device_id=dev.device_id
join public.informations as ifo
on dev.device_id=info_device_id
where info_timestamp > '2018-12-31' and info_timestamp < '2020-01-01' and
ac.activity_timestamp=ifo.info_timestamp
group by info_timestamp::date) visits
on datum."Day of 2019"=visits."visits day of 2019" ;

/* 3) Please write the SQL SELECT queries for the following results:
 * a) Per registration date and last device the number of users and the number of sales done by
 * users within 3 days after the registration
*/
select count(user_id) as "num of users", count(sale_id) as "num of sales", user_registration_timestamp,
activity_device_id
from public.users as us
join public.sales as sal
on us.user_id=sal.sale_id
join public.activities as ac
on us.user_id=ac.activity_user_id
where activity_is_last=true and sale_timestamp <= user_registration_timestamp + interval '72 hours'
and sale_timestamp>user_registration_timestamp
group by user_registration_timestamp, activity_device_id ;

/*b) Per visit day in 2019 the number of page visits and registrations
 *Explain in writing: What would be measured with 2 c) and what with this result?
*/
select info_timestamp::date as "visits day of 2019", count(user_id) as "num of reg users",
sum(info_page_visits) as "page visits"
from public.users as us
join public.activities as ac
on us.user_id=ac.activity_user_id
join public.devices as dev
on ac.activity_device_id=dev.device_id
join public.informations as ifo
on dev.device_id=info_device_id
where info_timestamp > '2018-12-31' and info_timestamp < '2020-01-01' and
ac.activity_timestamp=ifo.info_timestamp
group by info_timestamp::date ;

--With query from task 2. c) we measure the number of page visits and the number of registered users for
--every day of the year 2019, even if for that day we had zero page visits or zero registered users.

--And with this query "Per visit day in 2019" we measure the number of page visits and the number of
--registered users only on days that had page visits during the year 2019. , if there were zero page visits,
--that day was not taken into the account.