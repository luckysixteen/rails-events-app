# Event Receiving App

Feature
====
### Event CRUD operation 
Receive POSTed event JSON blobs.
[> check api doc](#EventCRUDoperationAPI)

### Today Stats
groups event by event_type and returns the count for each
* Way 1: Query from event table  
[> check api doc](#TodaystatsfromqueryingAPI)
* Way 2: From statistic table
[> check api doc](#TodaystatsfromstatistictableAPI)




Documentation
====
#### Event CRUD operation API
- [Show all events](#Showallevents) : `GET /events`
- [Receive a event](#Receiveaevent) : `GET /events/:id`
- [Create a event](#Createaevent) : `POST /events`
- [Delete a event](#Deleteaevent) : `DELETE /evemts/:id`

#### Today stats from querying API
- [Show today stats](#Showtodaystats-query) : `GET /statistic`
- [Show specific day stats](#Showspecificdaystats-query) : `GET /statistic/:date`

#### Today stats from statistic table API
- [Show today stats](#Showtodaystats-table) : `GET /stats`
- [Show specific day stats](#Showspecificdaystats-table) : `GET /stats/:date`


### **Show all events**
----
Returns json data about all events.
**URL** : `/events`
**URL Params** : None
**Method** : `GET`
**Data Params** : {}
**Sample Call** :
```bash
curl -X GET 'https://peaceful-meadow-66894.herokuapp.com/events'
```

#### Success Response
**Code** : `200 OK`

### **Show an event**
----
Returns json data about request event.
**URL** : `/events/:id`
**URL Params** : `id=[integer]` where `id` is ID of the event
**Method** : `GET`
**Data Params** : {}
**Sample Call** :
```bash
curl -X GET 'https://peaceful-meadow-66894.herokuapp.com/events/1'
```

#### Success Response
**Condition** : The URL parameter is a valid id number and that id query has already stored in the database.
**Code** : `200 OK`
**Success Sample**
```json
{
"id": 1,
"name": "test button",
"event_type": "click",
"created_at": "2020-06-20T08:38:45.897Z",
"updated_at": "2020-06-20T08:38:45.897Z"
}
```
#### Fail Response
**Condition 1** : The URL parameter is not a valid id number.
**Code** : `400 Bad Request`
**Fail URL Sample**: `/events/abc`
**Fail Sample**
```json
{"error": "Event ID is invalid."}
```
**Condition 2** : Cannot find the id query in the database.
**Code** : `400 Bad Request`
**Fail URL Sample**: `/events/100`
**Fail Sample**
```json
{"error": "Cannot find the event."}
```


**Condition 1** : The URL parameter is a valid id number and that id query has already stored in the database.
**Code** : `400 Bad Request`
**Fail Sample**
```json
{"error": "Cannot find the event"}
```




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
### Version
* ruby 2.6.3p62
* Rails 6.0.3.2
* PostgreSQL


### Task
- [x] simple CRUD for event
- [x] Store the entire blob
- [x] Two keys `name` and `event_type` are required
- [x] return HTTP status 422 with error info if keys are not included

Extra: 
- [ ] todays stats



### Implement

#### Model


**1. Event**

###### Attribute
* **name** : string
* **event_type**: reference

###### Relationship
belong_to :Statistic

###### Creation
`$ rails generate model Event name:string event_type:string`

**2. Statistic**

###### Attribute
* **date** : date
* **click**: integer
* **view** : integer
* **play**: integer
* **pause**: integer
* **add** : integer
* **remove**: integer
* **download**: integer
* **select** : integer
* **load**: integer
* **scroll**: integer


###### Relationship
has_many :Statistic



#### EventType

**event_type** :
click, view, play, pause, add, remove, download, select, load, scroll

**example** :
```json
{"name": "test button", "event_type": "click"}
{"name": "test article", "event_type": "view"}
{"name": "test video", "event_type": "play"}
{"name": "test video", "event_type": "pause"}
{"name": "test good", "event_type": "add"}
{"name": "test good", "event_type": "remove"}
{"name": "test document", "event_type": "download"}
{"name": "test checkbox", "event_type": "select"}
{"name": "test video", "event_type": "load"}
{"name": "test article", "event_type": "scroll"}
```

