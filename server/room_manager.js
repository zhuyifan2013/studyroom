const {v4: uuidv4} = require('uuid');
const Fuse = require('fuse.js')

const options = {
    threshold: 0.3,
    keys: [
        "topic"
    ]
};

class Room {
    users = [];

    constructor(id, topic) {
        this.id = id;
        this.topic = topic;
    }
}

let roomList = [];
let fuse = new Fuse(roomList, options)
const FULL_ROOM_NUMBER = 4

function enterRoom(topic) {
    // Get rooms with nearly same topic
    let foundRooms = fuse.search(topic)
    let roomId = findRoom(foundRooms)
    if (foundRooms.length === 0 || roomId === -1) {
        // No related room is found
        return createRoom(topic)
    }
    // Filter one room which is not full
    return roomId
}

function createRoom(topic) {
    let newRoom = new Room(uuidv4(), topic)
    roomList.push(newRoom)
    fuse = new Fuse(roomList, options);
    return newRoom.id
}

function findRoom(foundRooms) {
    if (foundRooms.length === 0) {
        return -1;
    }
    let filteredRooms = foundRooms.filter(room => room.item.users.length < FULL_ROOM_NUMBER)
    if (filteredRooms.length === 0) {
        return -1;
    }
    return filteredRooms[0].item.id
}

module.exports = {
    enterRoom: enterRoom,
    createRoom: createRoom
}