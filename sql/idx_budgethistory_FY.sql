-- Index: public."idx_budgethistory_FY"

-- DROP INDEX public."idx_budgethistory_FY";

CREATE INDEX "idx_budgethistory_FY"
  ON public.budget_app_budgethistory
  USING btree
  (fiscal_year COLLATE pg_catalog."default");
