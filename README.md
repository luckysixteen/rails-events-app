# Event Receiving App

Documentation
====

- [Show all events](#Showallevents) : `GET /events`
- [Receive a event](#Receiveaevent) : `GET /events/:id`
- [Create a event](#Createaevent) : `POST /events`
- [Delete a event](#Deleteaevent) : `DELETE /evemts/:id`


### **Show all events**
----
Returns json data about all events.
**URL** : `/events`
**URL Params** : `id=[integer]` where `id` is ID of the event
**Method** : `GET`
**Data Params** : {}
**Sample Call** :
```bash
curl -X GET 'https://peaceful-meadow-66894.herokuapp.com/events'
```

#### Success Response
**Code** : `200 OK`



### **Create a event**
----
Create a event and save the "name" and "event_type" in the database. Returns event json data.
**URL** : `/events`
**URL Params** : None
**Method** : `POST`
**Data Params** : requeire `name` and `event_type`
**Sample Call** :
```bash
curl -X POST --header 'Content-Type: application/json' --data '{"event" : {"name" : "test button", "event_type" : "click", "at" : "2020-06-12T00:00:01", "button_color" : "red" }}' 'https://peaceful-meadow-66894.herokuapp.com/events'
```

#### Success Response
**Code** : `200 OK`



Note
====
#### Version
* ruby 2.6.3p62
* Rails 6.0.3.2
* PostgreSQL


#### Task
- [x] simple CRUD for event
- [ ] Store the entire blob
- [x] Two keys `name` and `event_type` are required
- [ ] return HTTP status 422 with error info if keys are not included

Extra: 
- [ ] todays stats



#### Implement

##### Model
`$ rails generate model Event name:string event_type:string`

