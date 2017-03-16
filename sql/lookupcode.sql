/*  Methodology
I used Excel to generate a lot of the SQL. Just line up the columns and then use CONCATENATE to put together a SQL command.
The information for inserts and updates came from the spreadsheet "Hack Oregon hx budget data ASV2.xlsx"

A) PULL
 For example, here's the formula for the SQL to pull the codes from public.budget_app_budgethistory
=CONCATENATE("insert into public.budget_app_lookupcode (code_type, code, description) select '",B3,"',",B3,", ",A3," from public.budget_app_budgethistory group by ",B3,",",A3,";")

Where B3 is the code column (eg: fund_code) and A3 is the code description (eg: fund_name)

This creates a command that looks like this:
insert into public.budget_app_lookupcode (code_type, code, description) select 'fund_code',fund_code, fund_name from public.budget_app_budgethistory group by fund_code,fund_name;


B) INSERT
To create the SQL for inserting divisions:
Here's the formula
=CONCATENATE("insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','",A2,"', '",B2,"' );")

Where A2 is the division code, and B2 the division description.

Resulting command:
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ATAT', 'Office of City Attorney' );


C) UPDATE
Here's the formula to update
=CONCATENATE("update public.budget_app_lookupcode set description='",A1,"' where code='",B1,"' and code_type='service_area_code';")

Where A1 is the service area description and B1 is the service area code.

Here's the actual command
update public.budget_app_lookupcode set description='Community Development' where code='CD' and code_type='service_area_code';
*/

-- This query shows the different code types populating public.budget_app_lookupcode
select code_type from public.budget_app_lookupcode group by code_type;

-- Here are the codes as of this iteration
-- "fund_center_code"
-- "bureau_code"
-- "object_code"
-- "service_area_code"
-- "functional_area_code"
-- "fund_code"

-- re: reading the codes. you can see how these codes interact
--  bureau_code		BO	City Budget Office
--  division_code	BOBO	City Budget Office
--  fund_center_code	BOBO000001	City Budget Office
-- A division is within a bureau
-- The division code builds off the bureau code

-- Here is the SQL I generated (with Excel) to populate the table
-- empty the lookup table of all data
truncate table public.budget_app_lookupcode;

-- build the lookup codes from the data in public.budget_app_budgethistory
begin
insert into public.budget_app_lookupcode (code_type, code, description) select 'fund_code',fund_code, fund_name from public.budget_app_budgethistory group by fund_code,fund_name;
insert into public.budget_app_lookupcode (code_type, code, description) select 'object_code',object_code, accounting_object_name from public.budget_app_budgethistory group by object_code,accounting_object_name;
insert into public.budget_app_lookupcode (code_type, code, description) select 'service_area_code',service_area_code, service_area_code from public.budget_app_budgethistory group by service_area_code,service_area_code;
insert into public.budget_app_lookupcode (code_type, code, description) select 'bureau_code',bureau_code, bureau_name from public.budget_app_budgethistory group by bureau_code,bureau_name;
insert into public.budget_app_lookupcode (code_type, code, description) select 'fund_center_code',fund_center_code, fund_center_name from public.budget_app_budgethistory group by fund_center_code,fund_center_name;
insert into public.budget_app_lookupcode (code_type, code, description) select 'functional_area_code',functional_area_code, functional_area_name from public.budget_app_budgethistory group by functional_area_code,functional_area_name;
end


-- update service areas with description from spreadsheet
update public.budget_app_lookupcode set description='Community Development' where code='CD' and code_type='service_area_code';
update public.budget_app_lookupcode set description='Legislative, Administrative, & Support' where code='LA' and code_type='service_area_code';
update public.budget_app_lookupcode set description='Parks, Recreation, & Culture' where code='PR' and code_type='service_area_code';
update public.budget_app_lookupcode set description='Public Safety' where code='PS' and code_type='service_area_code';
update public.budget_app_lookupcode set description='Public Utilities' where code='PU' and code_type='service_area_code';
update public.budget_app_lookupcode set description='Transportation & Parking' where code='TP' and code_type='service_area_code';


-- insert the division names from the spreadsheet
begin
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ATAT', 'Office of City Attorney' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','AUCA', 'Office of the City Auditor' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','AUDA', 'Office of the Chief Deputy Auditor' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','BOBO', 'City Budget Office' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','CBCF', 'Cable Franchise Regulation' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','CBMH', 'Mt Hood Cable Regulatory Commission' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','CBUF', 'Utility/Telecom Franchise Management' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','DRDR', 'Disability Retirement' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','DSAS', 'Administrative Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','DSCS', 'Customer Service' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','DSIS', 'Inspection Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','DSLU', 'Land Use Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','DSPR', 'Plan Review and Permitting Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','DSSS', 'Site Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ECAD', 'Emergency Comm Administration' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ECOP', 'Emergency Comm Operations' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','EMEM', 'Emergency Management' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ESBS', 'Business Services Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ESDR', 'Director' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ESEN', 'Engineering Services Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ESPP', 'Pollution Prevention Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ESWS', 'Watershed Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ESWW', 'Wastewater Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFFM', 'Fund Management' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','FRCO', 'Chief''s Office' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','FREO', 'Emergency Operations' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','FRMS', 'Management Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','FRPR', 'Prevention' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','FRTS', 'Training and Safety' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','GRLG', 'Legislative' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','HCMG', 'Management and Planning' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','HCPG', 'Program Delivery' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','HNHN', 'Office of Human Relations' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFCP', 'Citywide Projects' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFDR', 'Office of the Chief Administrative Officer' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFHR', 'Human Resources' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFIB', 'Internal Business Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFRB', 'Bureau of Revenue & Financial Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFTS', 'Technology Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MYMY', 'Office of the Mayor' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','NIAD', 'Administration' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','NICP', 'Crime Prevention' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','NIIR', 'Information & Referral' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','NINL', 'Neighborhood Livability Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','NINR', 'Neighborhood Resource Center' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','OEOE', 'Office of Equity & Human Rights' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PACO', 'Commissioner of Public Affairs' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PKAM', 'Asset Management' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PKCN', 'City Nature' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PKDI', 'Director''s Office' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PKLM', 'Land Management' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PKPR', 'Parks & Recreation Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PKSB', 'Strategy, Finance, and Business Development' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PKWC', 'Workforce and Community Development' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PLCH', 'Chief''s Office' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PLIN', 'Investigations' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PLOP', 'Operations' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PLSB', 'Services Branch' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PNCP', 'Comprehensive Planning' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PNDO', 'Director''s Office' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PNDP', 'District Planning' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PNOP', 'Operations' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PNPC', 'Policy and Code Planning' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PNSD', 'Sustainable Development' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PSCO', 'Commissioner of Public Safety' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PUCO', 'Commissioner of Public Utilities' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','PWCO', 'Commissioner of Public Works' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','MFSA', 'Office of Management & Finance - Special Approps' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','SDSD', 'Sustainable Development' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','TRDR', 'Directors Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','TRED', 'Trans Engr & Development Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','TRMN', 'Transportation Mainenance Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','TRPP', 'Modal Coordination' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','TRTS', 'Transportation System Group' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WAAD', 'Administration' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WABA', 'Bureau Administrator' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WACS', 'Customer Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WAEN', 'Engineering Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WAFS', 'Finance and Support Services' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WAHP', 'Hydroelectric Power' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WAMC', 'Maintenance & Construction' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WAOP', 'Operations' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','WARP', 'Resource Protection & Planning' );
insert into public.budget_app_lookupcode (code_type, code, description) values ('division_code','ZDFS', 'Portland Development Commission Grant Management' );
end
