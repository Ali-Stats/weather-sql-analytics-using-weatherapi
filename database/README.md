# Database Setup

## Recommended order

1. Run `01_create_tables.sql`
2. Run `02_seed_data.sql`
3. Run `03_constraints.sql` (documentation of constraints already defined in the schema)
4. Run `04_indexes.sql`
5. Run the SQL files under `../views/`

## Source audit

`00_source_audit.sql` contains the queries used to validate the uploaded source files before the final schema was designed.

## Note

`02_seed_data.sql` is intentionally self-contained so the database can be rebuilt without depending on a local CSV path.
