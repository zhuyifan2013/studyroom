const                                             // return it back as a plain object
  redis       = require('redis'),                                             // node_redis module
  rediSearch  = require('./redis/index.js'),                                        // rediSearch Abstraction library
  data        = rediSearch(redis,'study_room_rooms');  // create an instance of the abstraction module using the index 'the-bard'
                                                                              // since we passed in redis module instead of a client instance, it will create a client instance
                                                                              // using the options specified in the 3rd argument.

function init() {
    data.createIndex([                                                            // create the index using the following fields
        data.fieldDefinition.text('room_id', true),                                  // field named 'line' that holds text values and will be sortable later on
        data.fieldDefinition.text('room_name', true),                                  // field named 'line' that holds text values and will be sortable later on
        data.fieldDefinition.text('room_topic', true, { noStem : true }),               // 'play' field is a text values that won’t be  stemed
        data.fieldDefinition.numeric('users',false),                              // 'speech' is a numeric field that is sortable
      ],
      function(err) {                                                             // Error first callback after the index is created
        if (err) { throw err; }                                                   // Handle the errors
      }
    );
}