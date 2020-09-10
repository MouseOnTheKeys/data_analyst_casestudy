# data_analyst_casestudy_Spark
Junior Data Analyst position at Spark Company - Case Study

# Product Analyst assignment

**Part 1**

Please answer the following questions in writing:

1) Imagine that you need to create a dashboard for the Zoosk Product team.
Which metrics would you include there and why?

2) We constantly A/B test new registration funnel in our SilverSingles brand, where users answer
various questions about their personality and a potential partner they are looking for. Later this
data is used in our matchmaking algorithm.
How would you measure the success of the test and which metrics would you use?

**Part 2**

Please, see the following DWH
diagram of an e-commerce
platform.

During a user’s lifecycle, before as
well as after registering on the
platform, any visits of platform
webpages are tracked (if possible).

In the **informations** table the total
amount of page visits is stored
( **info_page_visits)** for the
respective timestamp of the visit
and the respective used device
(phone, tablet, desktop, etc.).

At the moment the user registers
on the platform, a row is created
in the **users** table. Additionally, in
case the user visited the platform
before, rows are created in the **activities** table for all of the user’s previous visits with the respective
device_ID and timestamp of the visit ( **activity_timestamp** = **info_timestamp** ). After the registration any
user activity on the platform is also stored in the **activities** table. The **activity_is_last** field is
updated accordingly and always true for only one row per user in this table.

When the registered user buys something on the platform, this creates a row in the **sales** table and
when the item is paid, a row in the **payments** table.

The relations between tables are defined by the names, e. g. **sales.sale_user_ID** refers to
**users.user_ID**. A user does not need to have any activities or sales.

For the SQL queries, please choose any SQL dialect you prefer.


1) Please write the SQL SELECT query for the result described in a) and answer the questions in b).
Please ignore users here, who are not registered.
a) The number of daily active users per device
b) What kind of issue could occur, when using this result for further analysis, e.g. for calculating
the total number of daily active users? How would you adjust the query to fix it?

2) Please write the SQL SELECT queries for the following results:
a) The total **pay_amount** per city for sales in 201 9
b) The number of users, for whom the last activity was done with **device_name =** “phone”,
but who have also at least one additional activity with another device
c) Per day in 201 9 the number of page visits and registrations

3) Please write the SQL SELECT queries for the following results:
a) Per registration date and last device the number of users and the number of sales done by
users within 3 days after the registration.
b) Per visit day in 201 9 the number of page visits and registrations
Explain in writing: What would be measured with 2 c) and what with this result?



