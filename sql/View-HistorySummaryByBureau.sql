-- View: public."HistorySummaryByBureau"
-- Subtotal Budget History by Service Area & Bureau

-- DROP VIEW public."HistorySummaryByBureau";

CREATE OR REPLACE VIEW public."HistorySummaryByBureau" WITH (security_barrier=true) AS 
 SELECT budget_app_budgethistory.fiscal_year,
    budget_app_budgethistory.service_area_code,
    budget_app_budgethistory.bureau_code,
    sum(COALESCE(budget_app_budgethistory.amount, 0)) AS sum
   FROM budget_app_budgethistory
  GROUP BY budget_app_budgethistory.fiscal_year, budget_app_budgethistory.service_area_code, budget_app_budgethistory.bureau_code
  ORDER BY budget_app_budgethistory.fiscal_year, budget_app_budgethistory.service_area_code, budget_app_budgethistory.bureau_code;

ALTER TABLE public."HistorySummaryByBureau"
  OWNER TO budget_user;
