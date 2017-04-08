-- SQL commands for creating and initializing the lookupcode table
-- in a SQLite database.
-- See lookupcode.sql which has the SQL commands for PostgreSQL database
-- and has the documentation for the source of this data.

CREATE TABLE IF NOT EXISTS main.budget_app_lookupcode
(
  id INTEGER PRIMARY KEY ASC,
  code_type TEXT NOT NULL,
  code TEXT NOT NULL,
  description TEXT NOT NULL
) WITHOUT ROWID;

delete from main.budget_app_lookupcode;


-- build the lookup codes from the data in main.budget_app_budgethistory
insert into main.budget_app_lookupcode (code_type, code, description) select 'fund_code',fund_code, fund_name from main.budget_app_budgethistory group by fund_code,fund_name;
insert into main.budget_app_lookupcode (code_type, code, description) select 'object_code',object_code, accounting_object_name from main.budget_app_budgethistory group by object_code,accounting_object_name;
insert into main.budget_app_lookupcode (code_type, code, description) select 'service_area_code',service_area_code, service_area_code from main.budget_app_budgethistory group by service_area_code,service_area_code;
insert into main.budget_app_lookupcode (code_type, code, description) select 'bureau_code',bureau_code, bureau_name from main.budget_app_budgethistory group by bureau_code,bureau_name;
insert into main.budget_app_lookupcode (code_type, code, description) select 'fund_center_code',fund_center_code, fund_center_name from main.budget_app_budgethistory group by fund_center_code,fund_center_name;
insert into main.budget_app_lookupcode (code_type, code, description) select 'functional_area_code',functional_area_code, functional_area_name from main.budget_app_budgethistory group by functional_area_code,functional_area_name;


-- update service areas with description from spreadsheet
update main.budget_app_lookupcode set description='Community Development' where code='CD' and code_type='service_area_code';
update main.budget_app_lookupcode set description='Legislative, Administrative, & Support' where code='LA' and code_type='service_area_code';
update main.budget_app_lookupcode set description='Parks, Recreation, & Culture' where code='PR' and code_type='service_area_code';
update main.budget_app_lookupcode set description='Public Safety' where code='PS' and code_type='service_area_code';
update main.budget_app_lookupcode set description='Public Utilities' where code='PU' and code_type='service_area_code';
update main.budget_app_lookupcode set description='Transportation & Parking' where code='TP' and code_type='service_area_code';


-- insert the division names from the spreadsheet
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ATAT', 'Office of City Attorney' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','AUCA', 'Office of the City Auditor' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','AUDA', 'Office of the Chief Deputy Auditor' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','BOBO', 'City Budget Office' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','CBCF', 'Cable Franchise Regulation' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','CBMH', 'Mt Hood Cable Regulatory Commission' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','CBUF', 'Utility/Telecom Franchise Management' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','DRDR', 'Disability Retirement' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','DSAS', 'Administrative Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','DSCS', 'Customer Service' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','DSIS', 'Inspection Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','DSLU', 'Land Use Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','DSPR', 'Plan Review and Permitting Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','DSSS', 'Site Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ECAD', 'Emergency Comm Administration' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ECOP', 'Emergency Comm Operations' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','EMEM', 'Emergency Management' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ESBS', 'Business Services Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ESDR', 'Director' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ESEN', 'Engineering Services Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ESPP', 'Pollution Prevention Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ESWS', 'Watershed Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ESWW', 'Wastewater Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFFM', 'Fund Management' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','FRCO', 'Chief''s Office' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','FREO', 'Emergency Operations' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','FRMS', 'Management Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','FRPR', 'Prevention' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','FRTS', 'Training and Safety' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','GRLG', 'Legislative' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','HCMG', 'Management and Planning' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','HCPG', 'Program Delivery' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','HNHN', 'Office of Human Relations' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFCP', 'Citywide Projects' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFDR', 'Office of the Chief Administrative Officer' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFHR', 'Human Resources' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFIB', 'Internal Business Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFRB', 'Bureau of Revenue & Financial Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFTS', 'Technology Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MYMY', 'Office of the Mayor' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','NIAD', 'Administration' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','NICP', 'Crime Prevention' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','NIIR', 'Information & Referral' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','NINL', 'Neighborhood Livability Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','NINR', 'Neighborhood Resource Center' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','OEOE', 'Office of Equity & Human Rights' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PACO', 'Commissioner of Public Affairs' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PKAM', 'Asset Management' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PKCN', 'City Nature' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PKDI', 'Director''s Office' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PKLM', 'Land Management' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PKPR', 'Parks & Recreation Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PKSB', 'Strategy, Finance, and Business Development' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PKWC', 'Workforce and Community Development' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PLCH', 'Chief''s Office' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PLIN', 'Investigations' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PLOP', 'Operations' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PLSB', 'Services Branch' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PNCP', 'Comprehensive Planning' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PNDO', 'Director''s Office' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PNDP', 'District Planning' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PNOP', 'Operations' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PNPC', 'Policy and Code Planning' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PNSD', 'Sustainable Development' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PSCO', 'Commissioner of Public Safety' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PUCO', 'Commissioner of Public Utilities' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','PWCO', 'Commissioner of Public Works' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','MFSA', 'Office of Management & Finance - Special Approps' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','SDSD', 'Sustainable Development' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','TRDR', 'Directors Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','TRED', 'Trans Engr & Development Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','TRMN', 'Transportation Mainenance Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','TRPP', 'Modal Coordination' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','TRTS', 'Transportation System Group' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WAAD', 'Administration' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WABA', 'Bureau Administrator' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WACS', 'Customer Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WAEN', 'Engineering Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WAFS', 'Finance and Support Services' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WAHP', 'Hydroelectric Power' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WAMC', 'Maintenance & Construction' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WAOP', 'Operations' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','WARP', 'Resource Protection & Planning' );
insert into main.budget_app_lookupcode (code_type, code, description) values ('division_code','ZDFS', 'Portland Development Commission Grant Management' );
