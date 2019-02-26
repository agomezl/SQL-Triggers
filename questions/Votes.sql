CREATE TABLE Votes (
               cityname TEXT PRIMARY KEY,
               votecount INT
);

INSERT INTO Votes (cityname, votecount) VALUES ('Mars_City_One', 34);
INSERT INTO Votes (cityname, votecount) VALUES ('New_Gothenburg', 11);
INSERT INTO Votes (cityname, votecount) VALUES ('Picardia', 1);
UPDATE Votes SET votecount=votecount+3 WHERE cityname='New_Gothenburg';

SELECT * FROM Votes;

CREATE VIEW VoteSummary AS
  SELECT cityname, 100*votecount/(SELECT SUM(votecount) FROM Votes) AS percentage
  FROM Votes
  ORDER BY percentage DESC;

SELECT * FROM VoteSummary;

CREATE VIEW VoteSummary1 AS
  SELECT cityname, 100.0*votecount/(SELECT SUM(votecount) FROM Votes) AS percentage
  FROM Votes
  ORDER BY percentage DESC;

SELECT * FROM VoteSummary1;

CREATE OR REPLACE FUNCTION updateNotVoted() RETURNS TRIGGER AS $$
DECLARE
vcount INT;
BEGIN
  IF NOT EXISTS (SELECT * FROM Votes WHERE cityname = '<not voted>')
  THEN
    INSERT INTO Votes (cityname, votecount) VALUES ('<not voted>', 0);
  END IF;

  SELECT SUM(votecount) INTO vcount
  FROM Votes
  WHERE cityname <> '<not voted>';

  UPDATE Votes
  SET votecount = 1337-vcount
  WHERE cityname = '<not voted>';

RETURN NULL;
END
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER updateNotVotedTrigger
               AFTER INSERT OR UPDATE ON Votes
               FOR EACH ROW WHEN (NEW.cityname <> '<not voted>')
               EXECUTE PROCEDURE updateNotVoted();

UPDATE Votes SET votecount=votecount+2 WHERE cityname='Picardia';

SELECT * FROM Votes;

SELECT * FROM VoteSummary1;

SELECT * FROM VoteSummary;
