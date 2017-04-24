-- View: public."HistorySummaryByBureau"
-- Subtotal Budget History by Service Area & Bureau

-- DROP VIEW main."HistorySummaryByBureau";

CREATE VIEW main."HistorySummaryByBureau" AS
 SELECT budget_app_budgethistory.fiscal_year,
    case
      when budget_app_budgethistory.bureau_code = 'MF' then 'LA'
      when budget_app_budgethistory.bureau_code in ('MY','PA','PS','PW','PU','AU') then 'EO'
      else budget_app_budgethistory.service_area_code
    end as service_area_code,
    budget_app_budgethistory.bureau_code,
    sum(COALESCE(budget_app_budgethistory.amount, 0)) AS sum
   FROM budget_app_budgethistory
  GROUP BY 1,2,3
  ORDER BY 1,2,3;
