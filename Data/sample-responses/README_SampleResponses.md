# Sample Responses

File Name of Response | Query | Description
--------------------- | ----- | -----------
history-service\_area.json | [server]/budget/history/service\_area/ | Service Area budget totals per year.
history-service\_area-object\_code.json | [server]/budget/history/service\_area/object\_code/ | Service Area budget sub-categorized by Accounting Object per year.
history-bureau.json | [server]/budget/history/bureau/ | Bureau budget totals per year.
code-service\_area\_code.json | [server]/budget/code/?code\_type=service\_area\_code | List of Service Areas.
code-bureau\_code.json | [server]/budget/code/?code\_type=bureau\_code | List of Bureaus
code-all\_types.json | [server]/budget/code/ | List of all code types

Possible `server` values | Environment
------------------------ | -----------
http://hacko-integration-658279555.us-west-2.elb.amazonaws.com/ | Integration
http://localhost:8000/ | Development
http://127.0.0.1:8000/ | Development
http://192.168.99.100:8000/ | Development with Docker
