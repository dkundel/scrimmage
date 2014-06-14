'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema

UserSchema = new Schema(
  facebookIdentifier:
    type: String
    unique: true
    requird: true
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
      balls:
        type: Number
        min: 0
      rackets:
        type: Number
        min: 0
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

mongoose.model 'User', UserSchema