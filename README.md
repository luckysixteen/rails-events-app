# Event Receiving API App

Feature
====
### Event CRUD operation 
Receive POSTed event JSON blobs and add the data to PostgreSQL database. Validate on `name` and `event_type` keyword and show all data or specific data from Database.
[>> check api doc](#event-crud-operation-api)

### Today Stats

Groups event by `event_type` and returns the count for each. Realizes in two ways. All result based on **server timezone** (Pacific Time (US & Canada)).

**1. Query from event table**  [>> check api doc](#today-stats-from-querying-api)
* Everytime the endpoint request comes, grouping and querying statistic data from `event` table. 
* Simple impletation, however the response will increase with database size increasing.
* No need `statistic` table.
* Trade time for space

**2. From statistic table** [>> check api doc](#today-stats-from-statistic-table-api)
* Endpoint request query directly from `statistic` table. Fast response all the time.
* Need to maintain `statistic` table during all event CUD operation.
* Trade space for time


Documentation
====
#### Event CRUD operation API
- [The Event Object](#the-event-object)   
- [Show all events](#show-all-events) : `GET /events`
- [Show an event](#show-an-event) : `GET /events/:id`
- [Create an event](#create-an-event) : `POST /events`
- [Delete an event](#delete-an-event) : `DELETE /evemts/:id`

#### Today stats from querying API
- [Show today stats from query](#show-today-stats-from-query) : `GET /stats`
- [Show specific day stats from query](#show-specific-day-stats-from-query) : `GET /stats/:date`

#### Today stats from statistic table API
- [Show today stats from table](#show-today-stats-from-table) : `GET /statistics`
- [Show specific day stats from table](#show-specific-day-stats-from-table) : `GET /statistics/:date`


### **The Event object**
----
##### Event object attributes
* **id**: Unique identifier for the object.
* **name**: event name
* **event_type**: refer to [event type](#event-type)
* **created_at**: event create time
* **details**: entire blob data

##### Event object sample
```json
{
    "event": {
        "id": 22,
        "name": "test good",
        "event_type": "remove",
        "created_at": "2020-06-21T23:17:07.813Z"
    },
    "details": {
        "event": {
            "name": "test good",
            "event_type": "remove",
            "metadata": {
                "when": "yesterday",
                "how_often": "never"
            }
        }
    }
}
```


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
refer to [Event object sample](#event-object-sample)

#### Error Response
**Condition** : The URL parameter is not a valid id number.  
**Code** : `400 Bad Request`  
**Error URL Sample**: `/events/abc`  
**Error Sample**
```json
{"error": "Event ID is invalid."}
```
##### Or
**Condition** : Cannot find the id query in the database.  
**Code** : `400 Bad Request`  
**Error URL Sample**: `/events/100000`  
**Error Sample**
```json
{"error": "Cannot find the event."}
```


### **Create an event**
----
Create an event by validating `name` and `event_type` information. Save the entire request json data in the database. Returns event object data.  
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
**Success Sample**
```json
{
    "message": "Event succeessfully store in the database.",
    "event": {
        "id": 29,
        "name": "test button",
        "event_type": "click",
        "created_at": "2020-06-22T00:09:46.515Z"
    },
    "details": {
        "event": {
            "name": "test button",
            "event_type": "click",
            "at": "2020-06-12T00:00:01",
            "button_color": "red"
        }
    }
}
```
#### Error Response
**Condition** : Missing `name` or `event_type` keyword in request json data.  
**Code** : `422 Unprocessable Entity`  
**Error Request**
```json
{
    "event": {
        "event_type": "click",
        "button_color": "red"
    }
}
```
**Error Sample**
```json
{
    "error": {
        "name": [
            "can't be blank"
        ]
    }
}
```
##### Or
**Condition** : `event_type` is invalid. Check all valid type: [event type](#event-type)  
**Code** : `422 Unprocessable Entity`  
**Error Request**
```json
{
    "event": {
        "name": "test tab",
        "event_type": "close", // "close" is not a valid type
        "button_color": "red"
    }
}
```
**Error Sample**
```json
{
    "error": {
        "event_type": [
            "is not included in the list"
        ]
    }
}
```

### **Delete an event**
----
Delete the event of request id from database and returns result.  
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
    "name": "test button 1",
    "event_type": "click",
    "deleted": true
}
```
#### Error Response
**Condition** : The URL parameter is not a valid id number.  
**Code** : `400 Bad Request`  
**Error URL Sample**: `/events/abc`  
**Error Sample**
```json
{"error": "Event ID is invalid."}
```
##### Or
**Condition** : Cannot find the id query in the database.  
**Code** : `400 Bad Request`  
**Error URL Sample**: `/events/100000`  
**Error Sample**
```json
{"error": "Cannot find the event."}
```


### **Show today stats from query**
----
Returns json data about today's event_type statistics. Base on **server timezone** (Pacific Time (US & Canada)).  
**URL** : `/stats`  
**URL Params** : None  
**Method** : `GET`  
**Data Params** : {}  
**Sample Call** :
```bash
curl -X GET 'https://peaceful-meadow-66894.herokuapp.com/stats'
```
#### Success Response
**Code** : `200 OK`  
**Success Sample**
```json
{
    "today_date": "2020-06-21",
    "todays_stats": {
        "add": 1,
        "click": 1,
        "load": 4,
        "pause": 10,
        "play": 1,
        "remove": 3,
        "scroll": 5,
        "view": 1
    }
}
```


### **Show specific day stats from query**
----
Returns json data about a request date's event_type statistics.  
**URL** : `/stats/:date`  
**URL Params** : `date=[integer]` where `date` is the date in `yyyymmdd` format.  
**Method** : `GET`  
**Data Params** : {}  
**Sample Call** :
```bash
curl -X GET 'https://peaceful-meadow-66894.herokuapp.com/stats/20200622'
```
#### Success Response
**Condition** : The URL parameter is a valid date number in `yyyymmdd` format.  
**Code** : `200 OK`  
**Success Sample**
```json
{
    "date": "2020-06-21",
    "stats": {
        "add": 1,
        "load": 4,
        "pause": 10,
        "play": 1,
        "remove": 3,
        "scroll": 5
    }
}
```
#### Error Response
**Condition** : The URL parameter is not a valid date number (not in `yyyymmdd` format).  
**Code** : `400 Bad Request`  
**Error URL Sample**: `/stats/2020622`  
**Error Sample**
```json
{"error":"Date parameter is invalid."}
```


### **Show today stats from table**
----
Returns json data about today's event_type statistics from `statistics` table. Base on **server timezone** (Pacific Time (US & Canada)).  
**URL** : `/stats`  
**URL Params** : None  
**Method** : `GET`  
**Data Params** : {}  
**Sample Call** :
```bash
curl -X GET 'https://peaceful-meadow-66894.herokuapp.com/statistics'
```
#### Success Response
**Code** : `200 OK`  
**Success Sample**
```json
{
    "date": "2020-06-22",
    "statistics": {
        "click": 1,
        "view": 7,
        "play": 1,
        "pause": 0,
        "add": 3,
        "remove": 0,
        "download": 0,
        "select": 0,
        "load": 0,
        "scroll": 0
    }
}
```


### **Show specific day stats from table**
----
Returns json data about a request date's event_type statistics from `statistics` table..  
**URL** : `/statistics/:date`  
**URL Params** : `date=[integer]` where `date` is the date in `yyyymmdd` format.  
**Method** : `GET`  
**Data Params** : {}  
**Sample Call** :
```bash
curl -X GET 'https://peaceful-meadow-66894.herokuapp.com/statistics/20200622'
```
#### Success Response
**Condition** : The URL parameter is a valid date number in `yyyymmdd` format.  
**Code** : `200 OK`  
**Success Sample**
```json
{
    "date": "2020-06-22",
    "statistics": {
        "click": 1,
        "view": 7,
        "play": 1,
        "pause": 0,
        "add": 3,
        "remove": 0,
        "download": 0,
        "select": 0,
        "load": 0,
        "scroll": 0
    }
}
```
##### Or 
```json
{
    "date": "2020-06-20",
    "message": "No record on this day."
}
```
#### Error Response
**Condition** : The URL parameter is not a valid date number (not in `yyyymmdd` format).  
**Code** : `400 Bad Request`  
**Error URL Sample**: `/stats/2020622`  
**Error Sample**
```json
{"error": "Date parameter is invalid."}
```



Notes
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
- [x] todays stats


### Implement

#### Model


**1. Event**

###### Attribute
* **name** : string
* **event_type**: reference
* **details**: string

<!-- ###### Relationship
belong_to :Statistic -->

###### Creation
```bash
$ rails generate model Event name:string event_type:string
```


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
<!-- ###### Relationship
has_many :Statistic -->
###### Creation
```bash
$ rails generate model Statistic date:date click:integer view:integer play:integer pause:integer add:integer remove:integer download:integer select:integer load:integer scroll:integer
```


#### Event Type

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

