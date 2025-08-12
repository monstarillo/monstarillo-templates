-- Auto-generated ALTER statements to convert PK columns to identity (ALWAYS)
-- Notes:
-- - If a column already has an IDENTITY, the ADD statement will error; remove it for those tables if needed.
-- - DROP DEFAULT is included to convert from SERIAL/sequence-backed defaults.
-- - For composite primary keys, identity is skipped.

-- Skipped PlaylistTrack: composite primary key (PlaylistId, TrackId); identity applies to a single column.

-- Album: set "AlbumId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Album" ALTER COLUMN "AlbumId" DROP DEFAULT;
ALTER TABLE "Album" ALTER COLUMN "AlbumId" ADD GENERATED ALWAYS AS IDENTITY;
-- Artist: set "ArtistId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Artist" ALTER COLUMN "ArtistId" DROP DEFAULT;
ALTER TABLE "Artist" ALTER COLUMN "ArtistId" ADD GENERATED ALWAYS AS IDENTITY;
-- Customer: set "CustomerId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Customer" ALTER COLUMN "CustomerId" DROP DEFAULT;
ALTER TABLE "Customer" ALTER COLUMN "CustomerId" ADD GENERATED ALWAYS AS IDENTITY;
-- Employee: set "EmployeeId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Employee" ALTER COLUMN "EmployeeId" DROP DEFAULT;
ALTER TABLE "Employee" ALTER COLUMN "EmployeeId" ADD GENERATED ALWAYS AS IDENTITY;
-- Genre: set "GenreId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Genre" ALTER COLUMN "GenreId" DROP DEFAULT;
ALTER TABLE "Genre" ALTER COLUMN "GenreId" ADD GENERATED ALWAYS AS IDENTITY;
-- Invoice: set "InvoiceId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Invoice" ALTER COLUMN "InvoiceId" DROP DEFAULT;
ALTER TABLE "Invoice" ALTER COLUMN "InvoiceId" ADD GENERATED ALWAYS AS IDENTITY;
-- InvoiceLine: set "InvoiceLineId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "InvoiceLine" ALTER COLUMN "InvoiceLineId" DROP DEFAULT;
ALTER TABLE "InvoiceLine" ALTER COLUMN "InvoiceLineId" ADD GENERATED ALWAYS AS IDENTITY;
-- MediaType: set "MediaTypeId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "MediaType" ALTER COLUMN "MediaTypeId" DROP DEFAULT;
ALTER TABLE "MediaType" ALTER COLUMN "MediaTypeId" ADD GENERATED ALWAYS AS IDENTITY;
-- Playlist: set "PlaylistId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Playlist" ALTER COLUMN "PlaylistId" DROP DEFAULT;
ALTER TABLE "Playlist" ALTER COLUMN "PlaylistId" ADD GENERATED ALWAYS AS IDENTITY;
-- Track: set "TrackId" as GENERATED ALWAYS AS IDENTITY
ALTER TABLE "Track" ALTER COLUMN "TrackId" DROP DEFAULT;
ALTER TABLE "Track" ALTER COLUMN "TrackId" ADD GENERATED ALWAYS AS IDENTITY;


DO $$
DECLARE
  r record;
  v_next bigint;
BEGIN
  FOR r IN
    SELECT table_schema, table_name, column_name
    FROM information_schema.columns
    WHERE is_identity = 'YES'
  LOOP
    EXECUTE format(
      'SELECT COALESCE(MAX(%s),0) + 1 FROM %I.%I',
      quote_ident(r.column_name), r.table_schema, r.table_name
    )
    INTO v_next;

    EXECUTE format(
      'ALTER TABLE %I.%I ALTER COLUMN %s RESTART WITH %s',
      r.table_schema, r.table_name, quote_ident(r.column_name), v_next
    );
  END LOOP;
END $$;
