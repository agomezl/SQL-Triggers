-- (A)
CREATE TABLE AtMostOneROWS(
       theRow TEXT
);


CREATE or REPLACE FUNCTION COUNT2() RETURNS TRIGGER AS $$
DECLARE rcount INT;
BEGIN
  SELECT COUNT(theRow) INTO rcount FROM AtMostOneROWS;

  IF (rcount >1)
  THEN
    RAISE EXCEPTION 'Cannot Insert another row' ;
  END IF ;

  RETURN NULL;
END
$$ LANGUAGE 'plpgsql' ;


CREATE TRIGGER Atmost
AFTER INSERT ON AtMostOneROWS
FOR EACH ROW
EXECUTE PROCEDURE COUNT2() ;

-- (B)
CREATE TABLE Teachers (
  name TEXT,
  phoneNumber NUMERIC(8)
);

CREATE OR REPLACE FUNCTION notNoTeachers() RETURNS TRIGGER AS $$
DECLARE
 tcount INT;
BEGIN
  RAISE NOTICE 'FROM TRIGGER FUNCTION';

  SELECT COUNT(name) INTO tcount FROM Teachers;

  IF (tcount < 1)
  THEN
    RAISE EXCEPTION 'no teacher left';
  END IF ;

  RETURN NULL ;
END
$$ LANGUAGE 'plpgsql' ;

CREATE TRIGGER guaranteeTeachers
AFTER DELETE ON Teachers
FOR EACH ROW
EXECUTE PROCEDURE notNoTeachers() ;

-- (C)
CREATE TABLE Distances (
  fromCity TEXT,
  toCity TEXT,
  distance INT,
  CONSTRAINT only_one_direction CHECK (fromCity < toCity),
  CONSTRAINT UNIQ UNIQUE(fromCity,toCity)
) ;

ALTER TABLE Distances DROP CONSTRAINT only_one_direction;
ALTER TABLE Distances DROP CONSTRAINT UNIQ;

CREATE OR REPLACE FUNCTION ensureCity() RETURNS TRIGGER AS $$
DECLARE
  COUNTS INT;
BEGIN
  COUNTS := (SELECT COUNT(*)
             FROM Distances
             WHERE fromCity = NEW.toCity AND
                   toCity = NEW.fromCity);
  IF(COUNTS > 0)
  THEN RAISE EXCEPTION 'Cannot Insert Duplicate row' ;
  END IF;
  RETURN NEW;
  END
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER ensureDirection
BEFORE INSERT ON Distances FOR EACH ROW
EXECUTE PROCEDURE ensureCity();
