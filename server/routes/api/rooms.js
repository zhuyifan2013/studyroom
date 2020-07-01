const router = require('express').Router();
const auth = require('../auth');
const roomManager = require('../../room_manager')

router.post('/enter', auth.optional, (req, res, next) => {
    const {body: {topic}} = req;
    console.log('Topic is ' + topic)
    let roomId = roomManager.enterRoom(topic)
    // Find or create a room
    return res.json({ room_id: roomId });
})


router.post('/create', auth.optional, (req, res, next) => {
    const {body: {topic}} = req;
    console.log('Topic is ' + topic)
    let roomId = roomManager.createRoom(topic)
    // Find or create a room
    return res.json({ room_id: roomId });
})

router.get('/', auth.optional, (req,res,next) => {
   return res.json({"yifan": '11'})
})
module.exports = router;