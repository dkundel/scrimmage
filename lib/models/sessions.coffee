'use strict'

mongoose = require('mongoose')
Schema = mongoose.Schema

SessionSchema = new Schema(
  admin: Number
  description: String
  userType:
    type: String
    required: true
    enum: ['S', 'D']
  gameType:
    type: String
    required: true
    enum: ['C', 'R']
  fieldType:
    type: String
    required: true
    enum: ['H', 'G', 'C']
  skillLevel:
    type: Number
    min: 0
    max: 5
    required: true
  racket:
    type: Boolean
    required: true
  balls:
    type: Boolean
    required: true
  date:
    type: String
    required: true
  time:
    type: String
    required: true
  location:
    lat: Number
    long: Number
    address: String
  users: [
    id: Number
    name: String
    first_name: String
  ]
  messages: [
    user:
      id: Number
      first_name: String
    content: String
    date: 
      type: Date
      default: Date.now
  ]
)

module.exports = mongoose.model 'Session', SessionSchema