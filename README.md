# Event Receiving App

#### Version
* ruby 2.6.3p62
* Rails 6.0.3.2
* PostgreSQL


#### Task
- [x] simple CRUD for event
- [ ] Store the entire blob
- [ ] Two keys `name` and `event_type` are required
- [ ] return HTTP status 422 with error info if keys are not included

Extra: 
- [ ] todays stats



#### Implement

##### Model
`$ rails generate model Event name:string event_type:string`

