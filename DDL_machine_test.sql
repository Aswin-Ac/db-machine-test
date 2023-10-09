Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
psql (14.4)
WARNING: Console code page (437) differs from Windows code page (1252)
         8-bit characters might not work correctly. See psql reference
         page "Notes for Windows users" for details.
Type "help" for help.

postgres=#
postgres=# CREATE DATABASE stock
postgres-# ;
CREATE DATABASE
postgres=#
postgres=# /c stock
postgres-# ;
ERROR:  syntax error at or near "/"
LINE 1: /c stock
        ^
postgres=# \c stock;
You are now connected to database "stock" as user "postgres".
stock=# CREATE TABLE tbl_stock()
stock-# h;
ERROR:  syntax error at or near "h"
LINE 2: h;
        ^
stock=# CREATE TABLE tbl_stock()
stock-# ss
stock-# ;
ERROR:  syntax error at or near "ss"
LINE 2: ss
        ^
stock=# CREATE TABLE tbl_stock(
stock(# pk_int_stock_id SERIAL PRIMARY KEY ,
stock(# vchr_name VARCHAR(50)
stock(# int_Quantity INT,
stock(# int_price INT
stock(# );
ERROR:  syntax error at or near "int_Quantity"
LINE 4: int_Quantity INT,
        ^
stock=# CREATE TABLE tbl_stock(
stock(# pk_int_stock_id SERIAL PRIMARY KEY ,
stock(# vchr_name VARCHAR(50),
stock(# int_Quantity INT,
stock(# int_price INT
stock(# );
CREATE TABLE
stock=# \d tbl_stock
                                              Table "public.tbl_stock"
     Column      |         Type          | Collation | Nullable |                      Default
-----------------+-----------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer               |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(50) |           |          |
 int_quantity    | integer               |           |          |
 int_price       | integer               |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)


stock=# desc tbl_stock;
ERROR:  syntax error at or near "desc"
LINE 1: desc tbl_stock;
        ^
stock=# ALTER table tbl_stock ALTER COLUMN int_price TYPE float;
ALTER TABLE
stock=# \d tbl_stock
                                              Table "public.tbl_stock"
     Column      |         Type          | Collation | Nullable |                      Default
-----------------+-----------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer               |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(50) |           |          |
 int_quantity    | integer               |           |          |
 int_price       | double precision      |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)


stock=# CREATE TABLE tbl_supplier(
stock(# pk_int_supplier_id SERIAL PRIMARY KEY,
stock(# vchr_supplier_name VARCHAR(50)
stock(# );
CREATE TABLE
stock=# \d tbl_supplier
                                                 Table "public.tbl_supplier"
       Column       |         Type          | Collation | Nullable |                         Default
--------------------+-----------------------+-----------+----------+----------------------------------------------------------
 pk_int_supplier_id | integer               |           | not null | nextval('tbl_supplier_pk_int_supplier_id_seq'::regclass)
 vchr_supplier_name | character varying(50) |           |          |
Indexes:
    "tbl_supplier_pkey" PRIMARY KEY, btree (pk_int_supplier_id)

ALTER TABLE tbl_stock ADD COLUMN fk_int_supplier INT

stock=# ALTER TABLE tbl_supplier ADD COLUMN fk_int_supplier INT;
ALTER TABLE
stock=# ALTER TABLE tbl_stock
ADD CONSTRAINT fk_int_supplier 
FOREIGN KEY(fk_int_supplier) REFERENCES tbl_supplier(pk_int_supplier_id)
ON DELETE CASCADE ON UPDATE CASCADE;
\d tbl_supplier
                                                 Table "public.tbl_supplier"
       Column       |         Type          | Collation | Nullable |                         Default
--------------------+-----------------------+-----------+----------+----------------------------------------------------------
 pk_int_supplier_id | integer               |           | not null | nextval('tbl_supplier_pk_int_supplier_id_seq'::regclass)
 vchr_supplier_name | character varying(50) |           |          |
 fk_int_supplier    | integer               |           |          |
Indexes:
    "tbl_supplier_pkey" PRIMARY KEY, btree (pk_int_supplier_id)
Referenced by:
    TABLE "tbl_stock" CONSTRAINT "fk_int_supplier" FOREIGN KEY (fk_int_supplier) REFERENCES tbl_supplier(pk_int_supplier_id) ON UPDATE CASCADE ON DELETE CASCADE


stock=#

CREATE TABLE tbl_dept (
pk_int_dept_id SERIAL PRIMARY KEY,
vchr_dept_name VARCHAR(50)
);

CREATE TABLE tbl_classes (
pk_int_class_id SERIAL PRIMARY KEY,
vchr_class_name VARCHAR(50),
fk_int_dept_id INT,
FOREIGN KEY(fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_enrollment (
pk_int_enrollment_id SERIAL PRIMARY KEY,
int_count INT,
fk_int_class_id INT,
FOREIGN KEY(fk_int_class_id) REFERENCES tbl_classes(pk_int_class_id)
ON UPDATE CASCADE ON DELETE CASCADE
);
\d tbl_enrollment
                                            Table "public.tbl_enrollment"
        Column        |  Type   | Collation | Nullable |                           Default
----------------------+---------+-----------+----------+--------------------------------------------------------------
 pk_int_enrollment_id | integer |           | not null | nextval('tbl_enrollment_pk_int_enrollment_id_seq'::regclass)
 int_count            | integer |           |          |
 fk_int_class_id      | integer |           |          |
Indexes:
    "tbl_enrollment_pkey" PRIMARY KEY, btree (pk_int_enrollment_id)
Foreign-key constraints:
    "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_class_id) ON UPDATE CASCADE ON DELETE CASCADE



ALTER TABLE tbl_classes ADD UNIQUE(vchr_class_name);
stock=# \d tbl_classes
                                              Table "public.tbl_classes"
     Column      |         Type          | Collation | Nullable |                       Default
-----------------+-----------------------+-----------+----------+------------------------------------------------------
 pk_int_class_id | integer               |           | not null | nextval('tbl_classes_pk_int_class_id_seq'::regclass)
 vchr_class_name | character varying(50) |           |          |
 fk_int_dept_id  | integer               |           |          |
Indexes:
    "tbl_classes_pkey" PRIMARY KEY, btree (pk_int_class_id)
    "tbl_classes_vchr_class_name_key" UNIQUE CONSTRAINT, btree (vchr_class_name)
Foreign-key constraints:
    "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE
Referenced by:
    TABLE "tbl_enrollment" CONSTRAINT "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_class_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE tbl_dept ADD COLUMN vchr_dept_description VARCHAR(50);
\d tbl_dept
                                                 Table "public.tbl_dept"
        Column         |         Type          | Collation | Nullable |                     Default
-----------------------+-----------------------+-----------+----------+--------------------------------------------------
 pk_int_dept_id        | integer               |           | not null | nextval('tbl_dept_pk_int_dept_id_seq'::regclass)
 vchr_dept_name        | character varying(50) |           |          |
 vchr_dept_description | character varying(50) |           |          |
Indexes:
    "tbl_dept_pkey" PRIMARY KEY, btree (pk_int_dept_id)
Referenced by:
    TABLE "tbl_classes" CONSTRAINT "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE

INSERT INTO tbl_supplier(pk_int_supplier_id,vchr_supplier_name) VALUES
(1,'Logitech'),
(2,'Samsung'),
(3,'Iball'),
(4,'LG'),
(5,'Creative');
stock=# SELECT * FROM tbl_supplier;
 pk_int_supplier_id | vchr_supplier_name | fk_int_supplier
--------------------+--------------------+-----------------
                  1 | Logitech           |
                  2 | Samsung            |
                  3 | Iball              |
                  4 | LG                 |
                  5 | Creative           |
(5 rows)


stock=#


