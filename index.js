'use strict';

const http = require("http")
const socketio = require("socket.io")
const express = require("express")

const port = 8080
const app = express()
const server = http.Server(app)
const io = socketio(server)

app.use(express.static(__dirname + '/public'))

io.on('connection', (socket) => {
    console.log('listening on *:' + port)

    socket.on('chat_message', (data) => {
	console.log('message: ' + data)
	io.emit('broadcast_message', data)
    })
});

server.listen(port)
