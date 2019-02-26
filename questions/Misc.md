# Miscellaneous

* (**A**) Assume you want to create a table that should have at most one
  row. How can you guarantee this? Write an example CREATE TABLE
  statement, together with a trigger if you need one

* (**B**) Assume you have a table `Teachers(name,phoneNumber)` that
  lists the teachers currently in charge for some class. Assume the
  table already has some rows. How can you guarantee that this table
  will never become empty i.e. never have 0 rows?  Show the exact
  CREATE TABLE statement and/or trigger.

* (**C**) Consider a table with the schema
  `Distances(fromCity,toCity,distance)` that stores distances between
  cities. Since the distance from Y to X is always the same as the
  distance from X to Y, it would be redundant to store them both. How
  can you guarantee that the table never stores the distance from Y to
  X if it already has it.
