# Votes

In the year 2127, the first spaceship to colonize Mars carries 1337
colonists. When they arrive on the planet, they will build a city and
live there. Following democratic principles, the spaceship captain,
captain Picard, asks you to improve an SQL database to help with the
voting process.  The existing SQL database was created with the
following statement:

```sql
CREATE TABLE Votes (
               cityname TEXT PRIMARY KEY,
               votecount INT
);
```

To add a vote, you can use either INSERT or UPDATE, as shown below:

```sql
INSERT INTO Votes (cityname, votecount) VALUES ('Mars_City_One', 34);
INSERT INTO Votes (cityname, votecount) VALUES ('New_Gothenburg', 11);
INSERT INTO Votes (cityname, votecount) VALUES ('Picardia', 1);
UPDATE Votes SET votecount=votecount+3 WHERE cityname='New_Gothenburg';
```

* (**A**) Create a new `VIEW` called "VoteSummary" which outputs 2
  columns named "cityname" and "percentage" containing the cityname
  and percentage of votes cast for that cityname. The output is sorted
  according to the votecount, highest votecount first. After the
  example votes above, there would be 34 votes for "Mars City One" out
  of a total of 49 votes, so the top row of the "VoteSummary" VIEW
  would be `(’Mars City One’, 69.3878)`. There is no need to round off
  the percentage.

* (**B**) Create a trigger to update the "Votes" table, to keep track
  of how many colonists have not voted yet. This count will appear
  next to the special cityname `<not voted>`. In the example above, 49
  votes have been cast out of 1337 possible votes. This means the
  trigger needs to create or update an entry with cityname `<not
  voted>` and votecount 1288 (1337 - 49). Keep in mind that you
  need to create this entry if it does not exist yet. There is no need
  for a trigger on DELETE. Be careful with infinite recursion!
