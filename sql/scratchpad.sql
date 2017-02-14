-- Scratchpad for Hack Oregon Budget database.
-- PostgreSQL database at:
--   35.166.152.102:5432
-- Tables are explored in roughly alphabetical order.

-- ss_data seems to hold dollar amounts.

-- Only 105 rows. 
-- label1 in {'FY 2016-17', 'FY 2015-16', ...}.
-- label2 in {'Adopted', 'Estimated', 'Performance', ...}.
-- What are the mp* columns?
select count(*) from columns;
select * from columns order by seq limit 500;
select distinct(label1) from columns order by label1;
select distinct(label2) from columns order by label2;
select distinct(label3) from columns order by label3;

-- Only 4 rows. id in {GF-ONLY, GF-SPLIT, OTHER, OVHD-SPLIT}.
-- I expected to find "commit items" in this table.
select * from commitems limit 500;

-- 1132 rows.
-- Names of organizational units within the city.
-- What are the tbl* columns?
select count(*) from consolinfo;
select * from consolinfo order by org, name limit 1200;

-- 1130 rows.
-- organizational hierarchy: See 'org' and 'parent' columns.
-- What is the meaning of the different level values? e.g. DS, DSIS
select count(*) from consoldef;
select * from consoldef order by org limit 1200;
select distinct(parent) from consoldef order by parent;
select distinct(lev3) from consoldef order by lev3;
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

-- Only 1 row: 'Organizational View           '
select * from consolnames limit 100;

-- Combines with tables that use id value as org identifier.
select * from constbl1 order by id;

-- {Active, Inactive}
select * from constbl2 order by id;

-- Names of Service Areas
select * from constbl5 order by id;

select * from constbl10 order by id;

-- ??
select * from fixamt order by minimum, maximum, amount, id;
select a.id, c.description, a.minimum, a.maximum, a.amount, a.pct 
  from fixamt a inner join fixcode c on a.id = c.id
  order by a.minimum, a.maximum, a.amount, a.id 
  limit 1000;
select * from pctamt order by minimum, maximum, amount, id;
select a.id, c.description, a.minimum, a.maximum, a.amount, a.pct 
  from pctamt a inner join pctcode c on a.id = c.id
  order by a.minimum, a.maximum, a.amount, a.id 
  limit 1000;

-- 578 rows. Funding sources.
select count(*) from fundinfo;
select * from fundinfo order by org limit 1000;

-- 'name' seems to identify revenue (mp1=R) and expense (mp1=E) items.
-- What is the meaning of the mp* columns?
select * from lines order by seq limit 500;

-- ??
select * from listcache limit 500;

-- ??
select * from pengalloc limit 500;
select * from pengbenf limit 500;
select * from pengbenfalloc limit 500;
select * from penginp limit 500;
select * from pengres limit 500;
-- ... pen* tables??

select * from perfmeas limit 500;
-- only 4 rows: {Effectiveness, Efficiency, Key Performance Measure, Workload}
select * from perftype limit 500;

-- Programs by bureau?
select * from programs order by id limit 1000;
select * from programs where id like 'FR%' order by id limit 1000;

select * from projects order by org limit 1000;
select * from projinfo limit 1000;
select p.tbl, p.org, i.name, p.ext_lev, p.int_lev, p.parent, p.type, p.seq, p.lev1, p.lev2, p.lev3, p.lev4
  from projects p inner join projinfo i on p.org = i.org
  order by p.org
  limit 1000;

-- Actual expenditures?
select * from ss_audit limit 1000;
select count(*) from ss_data;  -- 3645260 rows
select * from ss_data order by fund, col, object limit 1000;
select d.org, c.name, d.fund, d.program, d.object, d.col, d.mut, d.mud, d.data
  from ss_data d inner join consolinfo c on d.org = c.org
  order by d.org, d.fund
  limit 2000;
select d.org, c.parent, d.fund, d.program, d.object, d.col, d.mut, d.mud, d.data
  from ss_data d inner join consoldef c on d.org = c.org
  order by d.org
  limit 1000;

select count(*) from ss_perf;
select * from ss_perf order by perf limit 1000;

-- 7 rows: {'Rollover from prior year', ...}
select * from stages;

-- Salary levels?
select * from stepamt;
select * from steps;

-- What are these codes?
select * from user_list limit 1000;
select * from users;

select * from work_a limit 1000;
select * from work_f limit 1000;
