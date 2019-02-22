# Books

Consider an online book shop which sometimes promotes books by
displaying them on the front page of their web site. Their web
application uses a database created in PostgreSQL using the following
statements:

```sql
CREATE TABLE Books (
               id INTEGER PRIMARY KEY,
               category TEXT,
               price FLOAT,
               promoted BOOLEAN DEFAULT True
);

INSERT INTO Books (id, category, price) VALUES(1, 'Dictionary', 100);
INSERT INTO Books (id, category, price) VALUES(2, 'Dictionary', 150);
INSERT INTO Books (id, category, price) VALUES(3, 'Science', 120);
INSERT INTO Books (id, category, price) VALUES(4, 'Science', 190);
INSERT INTO Books (id, category, price) VALUES(5, 'Science', 320);
```

* (**A**) Create a new VIEW called "PromotionSummary" which outputs 3
  columns named "category”, "minprice" and "maxprice" containing the
  category name, minimum price of all promoted books and maximum price
  of all promoted books. A promoted book has its "promoted" attribute
  set to True.

* (**B**) Create a trigger so that, when a tuple from the
  "PromotionSummary" view is deleted, all Books from the corresponding
  category have their "promoted" attribute set to False. E.g. if the
  entry in "PromotionSum- mary" for category "Novel" is deleted, all
  entries in "Books" with category "Novel" have their "promoted"
  attribute set to False.
