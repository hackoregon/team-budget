-- View: public."HistorySummaryByBureauFund"
-- Subtotal Budget History by Service Area, Bureau & Funding type

-- DROP VIEW public."HistorySummaryByBureauFund";

CREATE OR REPLACE VIEW public."HistorySummaryByBureauFund" WITH (security_barrier=true) AS 
 SELECT budget_app_budgethistory.fiscal_year,
    budget_app_budgethistory.service_area_code,
    budget_app_budgethistory.bureau_code,
    budget_app_budgethistory.object_code,
    sum(COALESCE(budget_app_budgethistory.amount, 0)) AS sum
   FROM budget_app_budgethistory
  GROUP BY budget_app_budgethistory.fiscal_year, budget_app_budgethistory.service_area_code, budget_app_budgethistory.bureau_code, budget_app_budgethistory.object_code
  ORDER BY budget_app_budgethistory.fiscal_year, budget_app_budgethistory.service_area_code, budget_app_budgethistory.bureau_code, budget_app_budgethistory.object_code;

ALTER TABLE public."HistorySummaryByBureauFund"
  OWNER TO budget_user;
