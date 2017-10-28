-- View: public."HistorySummaryByServiceArea"
-- Subtotal Budget History by Service Area

-- DROP VIEW public."HistorySummaryByServiceArea";

CREATE OR REPLACE VIEW public."HistorySummaryByServiceArea" WITH (security_barrier=true) AS 
SELECT 
    budget_app_budgethistory.fiscal_year,
    case 
      when budget_app_budgethistory.bureau_code = 'MF' then 'LA'
      when budget_app_budgethistory.bureau_code in ('MY','PA','PS','PW','PU','AU') then 'EO'
      else budget_app_budgethistory.service_area_code
    end as service_area_code,
    sum(COALESCE(budget_app_budgethistory.amount, 0)) AS sum
FROM budget_app_budgethistory
  GROUP BY 1,2
  ORDER BY 1,2;
  
ALTER TABLE public."HistorySummaryByServiceArea"
  OWNER TO budget_user;
