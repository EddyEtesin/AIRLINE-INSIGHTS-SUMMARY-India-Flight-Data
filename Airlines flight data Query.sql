select * from airlines_flights_data$

----average price per airline
select airline, round(avg(price), 2) as avg_price
from airlines_flights_data$
group by airline;

----average ticket price by seat class
select class, round(avg(price), 2) as avg_price
from airlines_flights_data$
group by class;

----price difference between business and economy for each airline
select 
  airline,
  max(case when class = 'business' then avg_price end) - 
  max(case when class = 'economy' then avg_price end) as price_difference
from (
  select airline, class, avg(price) as avg_price
  from airlines_flights_data$
  group by airline, class
) as sub
group by airline;

---how does price vary with number of stops
select stops, round(avg(price), 2) as avg_price
from airlines_flights_data$
group by stops;

---- cheapest and most expensive route
-- cheapest route
select top 1 source_city, destination_city, flight, price
from airlines_flights_data$
order by price asc;

-- most expensive route
select top 1 source_city, destination_city, flight, price
from airlines_flights_data$
order by price desc;

---- average ticket price based on days left to departure
select 
  case 
    when days_left between 0 and 3 then '0–3'
    when days_left between 4 and 7 then '4–7'
    when days_left between 8 and 14 then '8–14'
    else '15+'
  end as days_group,
  round(avg(price), 2) as avg_price
from airlines_flights_data$
group by 
  case 
    when days_left between 0 and 3 then '0–3'
    when days_left between 4 and 7 then '4–7'
    when days_left between 8 and 14 then '8–14'
    else '15+'
  end;

----distribution of ticket prices by departure or arrival time bin
select 
  departure_time as time_bin,
  count(*) as total_flights,
  round(avg(price), 2) as avg_price,
  min(price) as min_price,
  max(price) as max_price
from airlines_flights_data$
group by departure_time
order by avg_price desc;

select 
  arrival_time as time_bin,
  count(*) as total_flights,
  round(avg(price), 2) as avg_price,
  min(price) as min_price,
  max(price) as max_price
from airlines_flights_data$
group by arrival_time
order by avg_price desc;

---- flight code with the highest average price
select top 1 flight, round(avg(price), 2) as avg_price
from airlines_flights_data$
group by flight
order by avg_price desc;

-----average price for each source–destination pair
select 
  source_city, destination_city,
  round(avg(price), 2) as avg_price
from airlines_flights_data$
group by source_city, destination_city
order by avg_price desc;

---routes with longest average duration
select 
  source_city, destination_city,
  round(avg(duration), 2) as avg_duration
from airlines_flights_data$
group by source_city, destination_city
order by avg_duration desc;

----average flight duration per airline
select airline, round(avg(duration), 2) as avg_duration
from airlines_flights_data$
group by airline
order by avg_duration desc;

 ---airlines that operate the most flights
select airline, count(*) as total_flights
from airlines_flights_data$
group by airline
order by total_flights desc;

---source city with highest number of departures
select source_city, count(*) as departures
from airlines_flights_data$
group by source_city
order by departures desc;

----destination city receiving most flights
select destination_city, count(*) as arrivals
from airlines_flights_data$
group by destination_city
order by arrivals desc;

----most common departure/arrival windows
-- departure window
select departure_time, count(*) as total
from airlines_flights_data$
group by departure_time
order by total desc;

-- arrival window
select arrival_time, count(*) as total
from airlines_flights_data$
group by arrival_time
order by total desc;

---airlines that specialize in specific departure windows
select 
  airline, departure_time,
  count(*) as flights,
  round(100.0 * count(*) / sum(count(*)) over (partition by airline), 2) as percent_within_airline
from airlines_flights_data$
group by airline, departure_time
order by airline, percent_within_airline desc;

----how does price change with departure time?
select departure_time, round(avg(price), 2) as avg_price
from airlines_flights_data$
group by departure_time
order by avg_price desc;

-----average days left before booking, by airline
select airline, round(avg(days_left), 2) as avg_days_left
from airlines_flights_data$
group by airline
order by avg_days_left desc;

----average days left before booking, by class
select class, round(avg(days_left), 2) as avg_days_left
from airlines_flights_data$
group by class;

---- are business class tickets booked earlier?
select class, round(avg(days_left), 2) as avg_days_before_booking
from airlines_flights_data$
group by class;

--- most frequent departure–arrival time combinations
select departure_time, arrival_time, count(*) as total
from airlines_flights_data$
group by departure_time, arrival_time
order by total desc;

---which class is more popular?
select class, count(*) as total
from airlines_flights_data$
group by class
order by total desc;

---which airline offers the most business class flights?
select airline, count(*) as business_flights
from airlines_flights_data$
where class = 'business'
group by airline
order by business_flights desc;

----which routes offer the cheapest economy seats?
select top 5 source_city, destination_city, round(min(price), 2) as cheapest_economy
from airlines_flights_data$
where class = 'economy'
group by source_city, destination_city
order by cheapest_economy asc;

---how many distinct routes per airline?
select airline, count(distinct source_city + '-' + destination_city) as route_count
from airlines_flights_data$
group by airline
order by route_count desc;

----rank airlines by average ticket price
select airline, round(avg(price), 2) as avg_price
from airlines_flights_data$
group by airline
order by avg_price desc;

----rank source cities by number of outbound flights
select source_city, count(*) as outbound_flights
from airlines_flights_data$
group by source_city
order by outbound_flights desc;

---- top 5 most frequent flight codes
select top 5 flight, count(*) as flight_count
from airlines_flights_data$
group by flight
order by flight_count desc;

---top 3 cheapest flights per class
select * from (
  select *,
         rank() over (partition by class order by price asc) as rank
  from airlines_flights_data$
) as ranked
where rank <= 3;

---- cheapest flight per airline
select airline, flight, min(price) as cheapest_price
from airlines_flights_data$
group by airline, flight
having min(price) = (
  select min(price) from airlines_flights_data$ as sub where sub.airline = airlines_flights_data$.airline
)
order by airline;

---does duration affect price?
select round(duration, 1) as duration_hours,
       round(avg(price), 2) as avg_price
from airlines_flights_data$
group by round(duration, 1)
order by duration_hours;

----for each route, find cheapest & most expensive ticket
select distinct source_city,destination_city,cheapest,costliest
from (
  select *, 
         min(price) over (partition by source_city, destination_city) as cheapest,
         max(price) over (partition by source_city, destination_city) as costliest
  from airlines_flights_data$
) as result;

----running average price per airline ordered by days left
select airline, days_left, price,
       avg(price) over (partition by airline order by days_left rows between unbounded preceding and current row) as running_avg_price
from airlines_flights_data$;

----rank each flight by price within its airline
select  airline, flight, price,
       rank() over (partition by airline order by price asc) as price_rank
from airlines_flights_data$;

---- price difference from previous flight in airline
select airline, flight, price,
       lag(price) over (partition by airline order by price) as prev_price,
       price - lag(price) over (partition by airline order by price) as price_difference
from airlines_flights_data$;



