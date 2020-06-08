const express = require('express')
const path = require('path')
const bodyParser = require('body-parser');
const session = require('express-session');
const cors = require('cors');
const mongoose = require('mongoose');
const errorHandler = require('errorhandler');

//Configure mongoose's promise to global promise
mongoose.promise = global.Promise;


//Configure isProduction variable
const isProduction = process.env.NODE_ENV === 'production';

const app = express()
const port = 8000


//Configure our app
app.use(cors());
app.use(require('morgan')('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({ secret: 'passport-tutorial', cookie: { maxAge: 60000 }, resave: false, saveUninitialized: false }));

if(!isProduction) {
    app.use(errorHandler());
}

//Configure Mongoose
mongoose.connect('mongodb://localhost/study_room');
mongoose.set('debug', true);

require('./models/Users')
require('./config/passport')
app.use(require('./routes'))
//Error handlers & middlewares

// if(!isProduction) {
//   console.log('111')
//     app.use((err, req, res,) => {
//       console.log(res)
//       res.status(err.status || 500);
  
//       res.json({
//         errors: {
//           message: err.message,
//           error: err,
//         },
//       });
//     });
// } else {
//   console.log('2')
//   app.use((err, req, res) => {
//     res.status(err.status || 500);
//     res.json({
//         errors: {
//         message: err.message,
//         error: {},
//         },
//     });
//   });
// }
  


app.get('/', (req, res) => res.send('Hello World!'))

app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`))