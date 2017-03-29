-- View: public."HistorySummaryByServiceArea"
-- Subtotal Budget History by Service Area

-- DROP VIEW public."HistorySummaryByServiceArea";

CREATE OR REPLACE VIEW public."HistorySummaryByServiceArea" WITH (security_barrier=true) AS 
 SELECT budget_app_budgethistory.fiscal_year,
    budget_app_budgethistory.service_area_code,
    sum(COALESCE(budget_app_budgethistory.amount, 0)) AS sum
   FROM budget_app_budgethistory
  GROUP BY budget_app_budgethistory.fiscal_year, budget_app_budgethistory.service_area_code
  ORDER BY budget_app_budgethistory.fiscal_year, budget_app_budgethistory.service_area_code;

ALTER TABLE public."HistorySummaryByServiceArea"
  OWNER TO budget_user;
