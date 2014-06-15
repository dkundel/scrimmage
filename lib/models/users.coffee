'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema

UserSchema = new Schema(
  id:
    type: Number
    unique: true
  name:
    type: String
    required: true
  first_name:
    type: String
    required: true
  preferences:
    search:
      gameType:
        type: String
        enum: ['C', 'R']
      userType:
        type: String
        enum: ['S', 'D']
      location: String
      radius:
        type: Number
        min: 1
    create:
      gameType:
        type: String
        enum: ['C', 'R']
      userType:
        type: String
        enum: ['S', 'D']
      fieldType:
        type: String
        enum: ['H', 'G', 'C']
      balls: Boolean
      rackets: Boolean
      skillLevel:
        type: Number
        min: 0
        max: 5
      description: String
      location: String
  trustPoints: Number
  statistics:
    won:
      type: Number
      min: 0
    tied:
      type: Number
      min: 0
    lost:
      type: Number
      min: 0
)

module.exports = mongoose.model 'User', UserSchema