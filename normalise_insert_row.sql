CREATE TABLE custom (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    email TEXT
);
--Create a function to normalize both full name and email, then insert a row
CREATE OR REPLACE FUNCTION insert_normalized_custom(
 input_name TEXT,
input_email TEXT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO custom(full_name, email)
    VALUES (
        LOWER(TRIM(input_name)),
        LOWER(TRIM(input_email))
    );
END;
$$ LANGUAGE plpgsql;
-- Insert multiple rows using this function
SELECT insert_normalized_custom('  JoHn DOe  ', ' John.DOE@Example.Com ');
SELECT insert_normalized_custom('  Alice Johnson ', '  Alice.J@example.com ');
SELECT insert_normalized_custom('BOB smith', ' BOB.SMITH@Email.COM ');
SELECT insert_normalized_custom('  Clara  ', ' Clara@example.net ');
SELECT insert_normalized_custom('dave WILLIAMS ', ' Dave.Williams@Example.org ');

SELECT * FROM custom;
