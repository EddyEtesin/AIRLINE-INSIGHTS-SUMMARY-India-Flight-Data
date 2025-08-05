# Airline Analytics Report – India Domestic Flights

A comprehensive data analysis project exploring ticket pricing, airline operations, passenger behavior, and route dynamics using Indian domestic airline data.

---

## Objective

To uncover key insights from flight booking and scheduling data including:
- How pricing varies by airline, route, stops, and time
- Operational performance by city and airline
- Passenger booking behavior and market trends

---

## Dataset Overview

The dataset includes the following fields:
- `airline`
- `flight` (Flight Code)
- `source_city`, `destination_city`
- `departure_time`, `arrival_time`
- `stops`
- `class` (Economy or Business)
- `duration` (in hours)
- `days_left` (days before departure ticket was booked)
- `price` (in INR ₹)

---

## Key Insights

### Pricing Trends
- **Vistara** had the highest average fare at ₹30,396.54, while **AirAsia** was most affordable at ₹4,091.07.
- **Business class** tickets averaged ₹52,540.08 vs. ₹6,572.34 for **Economy**, with up to ₹47,670.08 price gap.
- **Ticket price increases with stop count**: Non-stop flights average ₹9,375, while 1-stop jumps to ₹22,900.
- **Best value route**: *Chennai → Hyderabad* at ₹1,105  
- **Most expensive route**: *Kolkata → Delhi* via UK-772 at ₹1,23,071
- Booking early (15+ days) saves ~₹8,500 compared to last-minute tickets (0–3 days).

### Time-Based Behavior
- **Night departures** are the most expensive (₹23,062.15), while **Late Night** is cheapest (₹9,295.30).
- **Evening arrivals** dominate both volume and average fare (~₹23,044).

### Route Duration & Flight Ops
- Longest average duration: *Kolkata → Chennai* – 14.77 hrs  
- Shortest average: *Bangalore → Delhi* – 9.78 hrs  
- **Air India** flies the longest routes, **Indigo** the shortest.

### Airline & City Metrics
- **Vistara** operated the most flights (127,859).
- **Delhi** had the highest departures; **Mumbai** received the most arrivals.
- Top 5 airlines covered **30 unique routes**.

### Booking Behavior
- **AirAsia** customers book earliest: avg. 28 days before departure.
- Class-wise booking lead time:
  - Business: 25.74 days
  - Economy: 26.12 days
- Most common time window: **Morning departures → Evening arrivals** (24,289 bookings).

### Market & Passenger Insights
- **Economy class** dominates (68.85% of bookings)
- **Vistara** leads in Business class operations.
- Cheapest Economy routes:
  - Chennai → Hyderabad: ₹1,105
  - Chennai → Bangalore: ₹1,443

### Best-Value Flights
- **Cheapest Business flights**:
  1. AI-507 – ₹12,000  
  2. AI-507 – ₹12,000  
  3. AI-563 – ₹12,000  
- **AI-507** is the cheapest Business class flight in **Air India**.

---

## Tools & Technologies

- **SQL Server (SSMS)** – Querying and aggregation
- **Excel / Power BI** – Data cleaning & visualization
- **Markdown** – Report formatting
- *(Optional)*: Python (Pandas) or Tableau for additional exploration

---
## Conclusion

This project reveals how pricing, stops, flight times, and passenger behavior shape the Indian airline industry. It offers valuable insights for:
- **Airline strategy & pricing teams**
- **Travel agencies & booking platforms**
- **Frequent flyers & budget-conscious travelers**
