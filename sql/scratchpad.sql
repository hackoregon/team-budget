-- Scratchpad for Hack Oregon Budget database.
-- SQL statements for browsing the tables, including
--   some joins to show the relationships between tables.
-- PostgreSQL database at:
--   35.166.152.102:5432
-- Tables are explored in roughly alphabetical order.
-- Quoted comments are from the documentation for this database: 
--   "BRASS Table Definitions, Version 5.40.08"
--   BRASS Table Definitions.pdf

-- Overview:
--   ss_data seems to hold dollar amounts.
--   consoldef, consolinfo, consolnames define organizational hierarchy for consolidation.
--   funds, fundinfo hold fund definitions, but not dollar amounts.
--   perfmeas, perftype specifies the Performance Measures, 
--     "but not the values" associated with those measures.

-- Account definitions
-- "accounts which bind Orgs, funds, programs, and possibly objects and MUT/MUD."
select count(*) from accts; -- 0 rows.

-- 0 rows in alloc* tables.
select * from allocdet;
select * from allochdr;
select * from allocres;

-- Employee type by bureau?
-- These tables not listed in documentation.
select count(id) from category; -- 30 rows.
select * from category order by description limit 500;
select * from categsupp order by categ, supp limit 500; -- Associative table
select * from suppamt order by id;
select * from suppcode order by description;

select c.id, c.description, cs.supp, sc.description, c.sal_pct, c.benf_pct, c.srv_id, c.sal_object, c.fte_object, c.pos_object
from category c inner join categsupp cs on c.id = cs.categ
  inner join suppcode sc on cs.supp = sc.id
order by c.id, c.description limit 500;

-- Column definitions for views and reports.
-- label1 in {'FY 2016-17', 'FY 2015-16', ...}.
-- label2 in {'Adopted', 'Estimated', 'Performance', ...}.
-- mp1, mp2, ... fields are "multi-posting column".
-- Per documentation, "A multi-posting column is another column that should 
--   be affected if any data is added to the current column. It is effectively 
--   used to maintain sub-total columns when their detail is altered."
select count(*) from columns; -- 105 rows.
select * from columns order by seq limit 500;
select distinct(label1) from columns order by label1;
select distinct(label2) from columns order by label2;
select distinct(label3) from columns order by label3;

-- Commodity Items. "a list of items used in the detail boxes."
-- What are these used for?
-- Only 4 rows. id in {GF-ONLY, GF-SPLIT, OTHER, OVHD-SPLIT}.
select * from commitems limit 500;

-- Consolidation Table Definitions
-- "The data is uniquely identified by the combination of the TABLE ID and the ORG ID."
-- organizational hierarchy: See 'org' and 'parent' columns.
-- What is the meaning of the different level values?
-- "The lineage section of the consolidation file (the levx fields) is used
--   to quickly determine the children to a given spreadsheet. 
--   Given a spreadsheet (e.g. ‘0012’), read the table to find its internal
--   level (e.g. 3); use this value to select the records
--   whose levx (e.g. lev3) is equal to the spreadsheet 
--   (e.g. SELECT org FROM ct01tb WHERE lev3 = ‘0012’)."
select count(*) from consoldef; -- 1130 rows.
select * from consoldef order by org limit 1200;
select distinct(tbl) from consoldef order by tbl; -- only '01'
select distinct(parent) from consoldef order by parent; -- 116 rows
select distinct(lev3) from consoldef order by lev3; -- 85 rows
select * from consoldef where parent like 'CITY%' order by org;
select * from consoldef where parent like 'AUCA%' order by org; -- See constbl1 for description of 'AUCA'.
select d.tbl, d.org, d.ext_lev, d.int_lev, d.parent, c.description, d.type, d.seq, d.lev1, d.lev2, d.lev3, d.lev4
  from consoldef d inner join constbl1 c on d.parent = c.id
  order by d.org;
select * from consoldef where parent like 'DS%' order by org;
select i.org, i.name, d.parent from consoldef d inner join consolinfo i on d.org = i.org where d.parent like 'CITY%' order by org;
select i.org, i.name, d.parent, d.type, d.lev1, d.lev2, d.lev3, i.tbl1, i.tbl2, i.tbl3, i.value3
  from consoldef d inner join consolinfo i on d.org = i.org 
  where i.org like 'FR%' order by org;

-- Consolidation Entry Information
-- Names of organizational units within the city.
-- tbl* columns are "Optional code value, may tie into CONSTBL1."
--   What does that mean? What is a "code value" used for?
select count(*) from consolinfo; -- 1132 rows.
select * from consolinfo order by org, name limit 1200;

-- Consolidation Table Names
-- Only 1 row: 'Organizational View           '
select * from consolnames limit 100;

-- Consolidation Table Optional Code Tables
-- "These tables are used to define the lookup values for the CONSOLINFO.TBL1 
--   through TBL16 fields."
-- Combines with tables that use id value as org identifier.
select * from constbl1 order by id;  -- 111 rows. Bureau names + ?
select * from constbl2 order by id;  -- {Active, Inactive}
select * from constbl3 order by id;  -- {Exclude, Include}
select * from constbl5 order by id;  -- 8 rows with Service Area names.

-- ?? Not listed in documentation.
select * from fixamt order by minimum, maximum, amount, id; -- 558 rows
select a.id, c.description, a.minimum, a.maximum, a.amount, a.pct 
  from fixamt a inner join fixcode c on a.id = c.id
  order by a.minimum, a.maximum, a.amount, a.id 
  limit 1000;
select * from pctamt order by minimum, maximum, amount, id; -- 283 rows
select a.id, c.description, a.minimum, a.maximum, a.amount, a.pct 
  from pctamt a inner join pctcode c on a.id = c.id
  order by a.minimum, a.maximum, a.amount, a.id 
  limit 1000;

-- Fund Table
-- "hierarchical structure ... organize funds into Funds and Sub-Funds."
-- hierarchy relationship in 'org' and 'parent' fields.
select count(*) from funds;  -- 577 rows.
select * from funds order by seq limit 1000;
select f.tbl, f.org, i.name, f.ext_lev, f.int_lev, f.parent, f.type, f.seq, f.lev1, f.lev2, f.lev3, f.lev4
  from funds f inner join fundinfo i on f.org = i.org
  order by f.seq limit 1000;

-- Funds information.
-- "contains no lineage or hierarchical consolidation information."
select count(*) from fundinfo; -- 578 rows.
select * from fundinfo order by org limit 1000;

-- 'name' seems to identify revenue (mp1=R) and expense (mp1=E) items.
-- What is the meaning of the mp* columns?
select * from lines order by seq limit 500;

-- "predefined lists for individual users."
select count(*) from listcache; -- 208,582 rows.
select * from listcache limit 500;

-- pen* tables?? Not listed in documentation.
select * from pengalloc limit 500;
select * from pengbenf limit 500;
select * from pengbenfalloc limit 500;
select * from penginp limit 500;
select * from pengres limit 500;

-- Performance Measures
select count(id) from perfmeas; -- 1,010 rows
select * from perfmeas order by seq limit 1200;
-- "Performance measures are values that can be associated with various 
--   entities in the system to measure their output, to quantify their inputs 
--   and/or to be the basis of various efficiency units."
-- "Performance Measures can be associated with Orgs, Programs, Grants, Projects."
select count(*) from ss_perf; -- 16,033 rows
select * from ss_perf order by perf limit 1000;

select ssp.perf, ssp.col, ssp.data, p.name, p.lname, p.seq, p.ptype, p.corg
from ss_perf ssp inner join perfmeas p on ssp.perf = p.id
order by ssp.perf, ssp.col limit 2000;

-- only 4 rows: {Effectiveness, Efficiency, Key Performance Measure, Workload}
select * from perftype limit 500;

-- Programs by bureau?
select count(*) from programs; -- 968 rows.
select * from programs order by id limit 1000;
select * from programs where id like 'FR%' order by id limit 1000;

select count(*) from projects; -- 6,355 rows.
select * from projects order by org limit 1000;
select * from projinfo limit 1000;
select p.tbl, p.org, i.name, p.ext_lev, p.int_lev, p.parent, p.type, p.seq, p.lev1, p.lev2, p.lev3, p.lev4
  from projects p inner join projinfo i on p.org = i.org
  order by p.org
  limit 1000;

-- "Any user entry that alters a value leaves a trail in this file."
select count(id) from ss_audit; -- 33,933 rows
select * from ss_audit limit 1000;

-- Spreadsheet Data Repository
-- "This table is the main storage for all system spreadsheet and program 
-- detailed data. This storage technique is used because the arrays are 
-- primarily sparse arrays and this approach saves storage space."
-- Actual expenditures?
select count(*) from ss_data;  -- 3,645,260 rows
select * from ss_data order by fund, col, object limit 1000;

-- Displays associated names for some of the id fields.
select cd.parent, d.org, ci.name, d.fund, fi.name, d.program, d.object, d.col, d.data, d.mut, d.mud
  from ss_data d inner join consolinfo ci on d.org = ci.org
    inner join consoldef cd on d.org = cd.org
    inner join fundinfo fi on d.fund = fi.org
  where d.org like 'FR%'
  order by d.org, d.fund, d.col, d.data
  limit 2000;

select count(distinct object) from ss_data; -- 823
select distinct object from ss_data order by object;

-- What are projections used for?
-- "BRASS projection definitions excluding the equations which are stored in ss_projrection_eqs."
-- "Projections is the main tool to generate projection which write back to ss_data."
select * from ss_projection order by proj_name limit 500; -- 5 rows.
-- "BRASS projection equations which are associated with a projection definitions in ss_projection."
-- "Equations are the processed in a BRASS projection."
select * from ss_projection_eqs order by val_tot limit 500; -- 5 rows.

-- 7 rows: {'Rollover from prior year', ...}
select * from stages;

-- Salary levels?
select * from stepamt;
select * from steps;

-- "user lists that do not change during a working session. For instance, 
--   a user’s list or accessible programs can be determined at login."
select * from user_list limit 1000;

-- "This table contains users specific information. 
--   This includes security related items such as passwords and access related 
--   pointers but also individual information such as preferred page layouts."
select count(userid) from users; -- 276 rows.
select * from users order by name limit 500;

-- "typically used to store local or temporary data and lists for processing."
select * from work_a limit 1000;
select * from work_f limit 1000;
