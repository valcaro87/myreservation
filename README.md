# INSTRUCTIONS

* open terminal, clone repo: https://github.com/valcaro87/myreservation.git

* change directory: *cd myreservation*
* run: *bundle install*

* open file '*database.yml*' - edit/change username and password, based from your local machine
  * make sure or grant the user to access all privileges and permissions on the database(postgreSql)

* run: *rails db:setup*
* run: *rails db:migrate*
* run: *rails s*

## Endpoints:

POST: http://localhost:3000/api/v1/reservations
(refer to payload)
* *send post data via body raw JSON format*

GET: http://localhost:3000/api/v1/reservations/id

UPDATE/PATCH: http://localhost:3000/api/v1/reservations/id
(refer to payload)
* *send patch data via body raw JSON format*


DELETE: http://localhost:3000/api/v1/reservations/id


