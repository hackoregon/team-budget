# Budget team project repo

This repo contains code and documents for all aspects of the Budget team project.

Per recommendation from Megan McKissack, Hack Oregon projects are asked to use branches, not separate repos, to manage code for frontend and backend work.

## Branch-based Approach to FE and BE separation
- all frontend code should terminate at the `frontend` branch (not master), and that frontend features should branch from the `frontend` branch (rather than branching from `master`).  TravisCI will be configured to build all commits that make it to the `frontend` branch, and all AWS frontend deploys will use the code committed to the `frontend` branch (assuming it passes the current set of frontend unit tests).
- all backend code should terminate at the `backend` branch (not `master`), and that backend features should branch from the `backend` branch (rather than branching from `master`).  TravisCI will be configured to build all commits that make it to the `backend` branch, and all AWS backend deploys will use the code committed to the `backend` branch (assuming it passes the current set of backend unit tests).
- `master` should be used sparingly e.g. for code and documents that are truly shared between frontend and backend.  The sample data structures that have been posted to date are one example, since they can be used as mocks of the data that will be provided from PostgreSQL and the APIs in the future.
