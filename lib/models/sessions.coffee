'use strict'

mongoose = require('mongoose')
Schema = mongoose.Schema

SessionSchema = new Schema(
  identifier:
    type: Schema.Types.ObjectId
    required: true
    unique: true
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
  rackets:
    type: Boolean
    required: true
  balls:
    type: Boolean
    required: true
  date:
    type: Date
    required: true
  location:
    type: String
    required: true
  users: [Number]
  messages: [
    user:
      id: Number
      first_name: String
    content: String
    date: Date
  ]
)

mongoose.model 'Session', SessionSchema