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

// For socket.io
const server = require('http').createServer(app)
const io = require('socket.io')(server)

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
mongoose.connect('mongodb://localhost/study_room', { useNewUrlParser: true,useUnifiedTopology: true});
mongoose.set('debug', true);

require('./models/Users')
require('./config/passport')
app.use(require('./routes'))


app.get('/', (req, res) => res.send('Hello World!'))
app.get('/room', (req, res) => {
    res.sendFile(__dirname + '/room.html');
})
// app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`))

io.on('connection', (socket)=>{
    console.log(socket.id + ' connected')

    socket.on('disconnect', () => {
        if(socket.socketStudyUser != null) {
            const socketStudyUser = JSON.parse(socket.socketStudyUser)
            const roomId = socketStudyUser.room_id

            io.in(roomId).clients((error, clients) => {
                let studyUsersData = JSON.stringify(clients.map( clientId => io.sockets.sockets[clientId].socketStudyUser))
                io.to(roomId).emit('study_room/update', studyUsersData)
            })
        }
        console.log(socket.id + 'user disconnected');
    });

    socket.on('message', (msg) => {
        console.log(socket.id + ' send msg : ' + msg['b']);
    });

    socket.on('study_room/enter', (data) => {


        const socketStudyUser = JSON.parse(data)
        console.log(" user : " + socketStudyUser.user.email)
        socket.socketStudyUser = data
        const roomId = socketStudyUser.room_id


        socket.join(roomId)

        io.in(roomId).clients((error, clients) => {
            let studyUsersData = JSON.stringify(clients.map( clientId => io.sockets.sockets[clientId].socketStudyUser))
            io.to(roomId).emit('study_room/update', studyUsersData)
        })

    })

    socket.on('study_room/update', (data) => {

    })

})

server.listen(3001, ()=> {
    console.log('Listening on 3001')
})

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
  

